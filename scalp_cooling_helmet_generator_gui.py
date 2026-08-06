"""
Parametric scalp-cooling helmet STL generator (research prototype)
-----------------------------------------------------------------
This GUI creates a patient-scaled 3D printable reference geometry for a
scalp-cooling helmet based on an ellipsoidal head approximation and a staggered
surface channel concept inspired by the CFD-optimized design reported in the
paper.

IMPORTANT: This script is for research/prototyping only. It does not create a
certified medical device and must not be used for clinical treatment without
formal engineering verification, biocompatibility assessment, leak testing,
thermal safety testing, and regulatory approval.

Dependencies:
    pip install numpy trimesh

Run:
    python scalp_cooling_helmet_generator_gui.py
"""

from __future__ import annotations

import math
import os
import tkinter as tk
from tkinter import filedialog, messagebox
from dataclasses import dataclass
from typing import Iterable, List, Tuple

import numpy as np
import trimesh


@dataclass
class HelmetParameters:
    head_width_mm: float = 190.0       # left-right diameter = 2*Rx
    head_depth_mm: float = 160.0       # front-back diameter = 2*Ry
    head_height_mm: float = 230.0      # vertical diameter = 2*Rz
    lower_cut_mm: float = -15.0        # z-cut plane in ellipsoid coordinates
    fluid_gap_mm: float = 4.0          # space between scalp and cooling wall
    shell_thickness_mm: float = 5.0    # printed wall thickness
    channel_radius_mm: float = 3.0     # radius of surface channel/rib tubes
    channel_spacing_mm: float = 18.0   # spacing inherited from CFD concept
    port_radius_mm: float = 3.0
    port_length_mm: float = 22.0
    n_theta: int = 72                  # circumferential mesh resolution
    n_phi: int = 48                    # vertical mesh resolution
    output_file: str = "custom_scalp_cooling_helmet.stl"


def _safe_float(value: str, name: str, minimum: float, maximum: float) -> float:
    try:
        out = float(value)
    except ValueError as exc:
        raise ValueError(f"{name} must be a number") from exc
    if not (minimum <= out <= maximum):
        raise ValueError(f"{name} must be between {minimum} and {maximum}")
    return out


def ellipsoid_surface_mesh(rx: float, ry: float, rz: float, z_cut: float,
                           n_theta: int, n_phi: int) -> trimesh.Trimesh:
    """Create an open ellipsoidal cap surface above z_cut."""
    z_cut = max(min(z_cut, 0.95 * rz), -0.95 * rz)
    phi_min = math.acos(z_cut / rz)  # z = rz*cos(phi); top phi=0
    phis = np.linspace(0.0, phi_min, n_phi)
    thetas = np.linspace(0.0, 2.0 * math.pi, n_theta, endpoint=False)

    vertices = []
    for phi in phis:
        sp = math.sin(phi)
        cp = math.cos(phi)
        for theta in thetas:
            vertices.append([rx * sp * math.cos(theta),
                             ry * sp * math.sin(theta),
                             rz * cp])
    vertices = np.asarray(vertices, dtype=float)

    faces = []
    for i in range(n_phi - 1):
        for j in range(n_theta):
            a = i * n_theta + j
            b = i * n_theta + (j + 1) % n_theta
            c = (i + 1) * n_theta + (j + 1) % n_theta
            d = (i + 1) * n_theta + j
            faces.append([a, d, c])
            faces.append([a, c, b])

    return trimesh.Trimesh(vertices=vertices, faces=np.asarray(faces), process=False)


def helmet_shell_mesh(params: HelmetParameters) -> trimesh.Trimesh:
    """Create a closed ellipsoidal shell by connecting inner and outer cap meshes."""
    rx = params.head_width_mm / 2.0
    ry = params.head_depth_mm / 2.0
    rz = params.head_height_mm / 2.0

    # Inner surface is offset from scalp to define fluid/comfort gap.
    rxi = rx + params.fluid_gap_mm
    ryi = ry + params.fluid_gap_mm
    rzi = rz + params.fluid_gap_mm

    # Outer surface adds printable wall thickness.
    rxo = rxi + params.shell_thickness_mm
    ryo = ryi + params.shell_thickness_mm
    rzo = rzi + params.shell_thickness_mm

    inner = ellipsoid_surface_mesh(rxi, ryi, rzi, params.lower_cut_mm,
                                   params.n_theta, params.n_phi)
    outer = ellipsoid_surface_mesh(rxo, ryo, rzo, params.lower_cut_mm,
                                   params.n_theta, params.n_phi)

    vertices = np.vstack([outer.vertices, inner.vertices])
    n = len(outer.vertices)
    faces: List[List[int]] = []

    # Outer faces as created.
    faces.extend(outer.faces.tolist())
    # Inner faces reversed to orient normals inward.
    faces.extend((inner.faces[:, ::-1] + n).tolist())

    # Close bottom rim between outer and inner surfaces.
    nt = params.n_theta
    outer_start = (params.n_phi - 1) * nt
    inner_start = n + (params.n_phi - 1) * nt
    for j in range(nt):
        o1 = outer_start + j
        o2 = outer_start + (j + 1) % nt
        i1 = inner_start + j
        i2 = inner_start + (j + 1) % nt
        faces.append([o1, o2, i2])
        faces.append([o1, i2, i1])

    mesh = trimesh.Trimesh(vertices=vertices, faces=np.asarray(faces), process=True)
    return mesh


def project_to_ellipsoid_outer(x: float, y: float, rx: float, ry: float, rz: float) -> np.ndarray | None:
    """Project an x-y location to the upper ellipsoid surface."""
    val = 1.0 - (x / rx) ** 2 - (y / ry) ** 2
    if val <= 0.0:
        return None
    z = rz * math.sqrt(val)
    return np.array([x, y, z], dtype=float)


def cylinder_between_points(p0: np.ndarray, p1: np.ndarray, radius: float, sections: int = 14) -> trimesh.Trimesh | None:
    """Create a cylinder between p0 and p1."""
    segment = p1 - p0
    length = float(np.linalg.norm(segment))
    if length < 1e-6:
        return None
    mesh = trimesh.creation.cylinder(radius=radius, height=length, sections=sections)
    # Cylinder is initially along z; align z-axis to segment.
    transform = trimesh.geometry.align_vectors([0, 0, 1], segment / length)
    mesh.apply_transform(transform)
    mesh.apply_translation((p0 + p1) / 2.0)
    return mesh


def channel_network_mesh(params: HelmetParameters) -> trimesh.Trimesh:
    """Generate a staggered surface-channel/rib network projected onto the helmet."""
    rx = params.head_width_mm / 2.0 + params.fluid_gap_mm + params.shell_thickness_mm
    ry = params.head_depth_mm / 2.0 + params.fluid_gap_mm + params.shell_thickness_mm
    rz = params.head_height_mm / 2.0 + params.fluid_gap_mm + params.shell_thickness_mm
    offset = params.channel_radius_mm * 0.85
    rxo, ryo, rzo = rx + offset, ry + offset, rz + offset

    meshes: List[trimesh.Trimesh] = []
    spacing = params.channel_spacing_mm
    y_values = np.arange(-0.72 * ryo, 0.72 * ryo + 0.1 * spacing, spacing)

    for row, y in enumerate(y_values):
        x_min = -0.82 * rxo + (0.5 * spacing if row % 2 else 0.0)
        x_max = 0.82 * rxo
        xs = np.arange(x_min, x_max + spacing, spacing)
        points = []
        for x in xs:
            p = project_to_ellipsoid_outer(x, y, rxo, ryo, rzo)
            if p is not None and p[2] > params.lower_cut_mm + 8.0:
                points.append(p)
        for p0, p1 in zip(points[:-1], points[1:]):
            cyl = cylinder_between_points(p0, p1, params.channel_radius_mm, sections=12)
            if cyl is not None:
                meshes.append(cyl)

    # Add a few transverse balancing manifolds.
    x_values = np.arange(-0.65 * rxo, 0.65 * rxo + spacing, 2.0 * spacing)
    for x in x_values:
        ys = np.arange(-0.65 * ryo, 0.65 * ryo + spacing, spacing)
        points = []
        for y in ys:
            p = project_to_ellipsoid_outer(x, y, rxo, ryo, rzo)
            if p is not None and p[2] > params.lower_cut_mm + 8.0:
                points.append(p)
        for p0, p1 in zip(points[:-1], points[1:]):
            cyl = cylinder_between_points(p0, p1, params.channel_radius_mm * 0.65, sections=10)
            if cyl is not None:
                meshes.append(cyl)

    # Inlet and outlet ports, horizontal along x, near lower lateral rim.
    z_port = params.lower_cut_mm + params.port_radius_mm + 6.0
    y_port = 0.0
    x_left = -rxo - params.port_length_mm
    x_left_end = -rxo + 2.0
    x_right = rxo - 2.0
    x_right_end = rxo + params.port_length_mm
    for p0, p1 in [
        (np.array([x_left, y_port, z_port]), np.array([x_left_end, y_port, z_port])),
        (np.array([x_right, y_port, z_port]), np.array([x_right_end, y_port, z_port])),
    ]:
        cyl = cylinder_between_points(p0, p1, params.port_radius_mm, sections=20)
        if cyl is not None:
            meshes.append(cyl)

    if not meshes:
        return trimesh.Trimesh()
    return trimesh.util.concatenate(meshes)


def generate_helmet_stl(params: HelmetParameters) -> str:
    shell = helmet_shell_mesh(params)
    channels = channel_network_mesh(params)
    combined = trimesh.util.concatenate([shell, channels])
    combined.process(validate=True)
    combined.export(params.output_file)
    return params.output_file


class HelmetGeneratorApp(tk.Tk):
    def __init__(self) -> None:
        super().__init__()
        self.title("Parametric scalp-cooling helmet STL generator")
        self.geometry("690x560")
        self.resizable(False, False)
        self.entries = {}
        self._build_ui()

    def _row(self, parent: tk.Widget, label: str, key: str, default: float, unit: str, row: int) -> None:
        tk.Label(parent, text=label, anchor="w").grid(row=row, column=0, sticky="w", padx=8, pady=5)
        var = tk.StringVar(value=str(default))
        entry = tk.Entry(parent, textvariable=var, width=12)
        entry.grid(row=row, column=1, sticky="w", padx=8, pady=5)
        tk.Label(parent, text=unit, anchor="w").grid(row=row, column=2, sticky="w", padx=8, pady=5)
        self.entries[key] = var

    def _build_ui(self) -> None:
        intro = (
            "Create a patient-scaled STL for a research scalp-cooling helmet. "
            "Enter head dimensions measured with calipers or a 3D scan. "
            "The generated geometry is a printable prototype concept, not a medical device."
        )
        tk.Label(self, text=intro, wraplength=650, justify="left").pack(padx=12, pady=10, anchor="w")

        frame = tk.LabelFrame(self, text="Geometry inputs")
        frame.pack(padx=12, pady=8, fill="x")
        defaults = HelmetParameters()
        rows = [
            ("Head width, left-right diameter", "head_width_mm", defaults.head_width_mm, "mm"),
            ("Head depth, front-back diameter", "head_depth_mm", defaults.head_depth_mm, "mm"),
            ("Head height, chin/top reference diameter", "head_height_mm", defaults.head_height_mm, "mm"),
            ("Lower helmet cut coordinate", "lower_cut_mm", defaults.lower_cut_mm, "mm"),
            ("Fluid/comfort gap", "fluid_gap_mm", defaults.fluid_gap_mm, "mm"),
            ("Printed shell thickness", "shell_thickness_mm", defaults.shell_thickness_mm, "mm"),
            ("Channel radius", "channel_radius_mm", defaults.channel_radius_mm, "mm"),
            ("Channel spacing", "channel_spacing_mm", defaults.channel_spacing_mm, "mm"),
            ("Port radius", "port_radius_mm", defaults.port_radius_mm, "mm"),
            ("Port length", "port_length_mm", defaults.port_length_mm, "mm"),
        ]
        for i, item in enumerate(rows):
            self._row(frame, *item, row=i)

        out_frame = tk.LabelFrame(self, text="Output")
        out_frame.pack(padx=12, pady=8, fill="x")
        self.output_var = tk.StringVar(value=os.path.abspath(defaults.output_file))
        tk.Entry(out_frame, textvariable=self.output_var, width=72).grid(row=0, column=0, padx=8, pady=8)
        tk.Button(out_frame, text="Browse", command=self._browse).grid(row=0, column=1, padx=8, pady=8)

        btn_frame = tk.Frame(self)
        btn_frame.pack(padx=12, pady=12, fill="x")
        tk.Button(btn_frame, text="Generate STL", command=self._generate, height=2, width=20).pack(side="left", padx=8)
        tk.Button(btn_frame, text="Quit", command=self.destroy, height=2, width=12).pack(side="right", padx=8)

        warning = (
            "Safety note: before any human use, the part must be leak-tested, thermally validated on a phantom, "
            "and reviewed under the applicable medical-device regulatory framework."
        )
        tk.Label(self, text=warning, wraplength=650, justify="left", fg="red").pack(padx=12, pady=6, anchor="w")

    def _browse(self) -> None:
        path = filedialog.asksaveasfilename(
            defaultextension=".stl",
            filetypes=[("STL files", "*.stl"), ("All files", "*.*")],
            initialfile="custom_scalp_cooling_helmet.stl",
        )
        if path:
            self.output_var.set(path)

    def _get_params(self) -> HelmetParameters:
        return HelmetParameters(
            head_width_mm=_safe_float(self.entries["head_width_mm"].get(), "Head width", 120, 260),
            head_depth_mm=_safe_float(self.entries["head_depth_mm"].get(), "Head depth", 120, 240),
            head_height_mm=_safe_float(self.entries["head_height_mm"].get(), "Head height", 150, 320),
            lower_cut_mm=_safe_float(self.entries["lower_cut_mm"].get(), "Lower cut", -80, 50),
            fluid_gap_mm=_safe_float(self.entries["fluid_gap_mm"].get(), "Fluid gap", 1, 20),
            shell_thickness_mm=_safe_float(self.entries["shell_thickness_mm"].get(), "Shell thickness", 1, 20),
            channel_radius_mm=_safe_float(self.entries["channel_radius_mm"].get(), "Channel radius", 1, 10),
            channel_spacing_mm=_safe_float(self.entries["channel_spacing_mm"].get(), "Channel spacing", 8, 50),
            port_radius_mm=_safe_float(self.entries["port_radius_mm"].get(), "Port radius", 1, 12),
            port_length_mm=_safe_float(self.entries["port_length_mm"].get(), "Port length", 5, 80),
            output_file=self.output_var.get(),
        )

    def _generate(self) -> None:
        try:
            params = self._get_params()
            folder = os.path.dirname(os.path.abspath(params.output_file))
            if folder and not os.path.isdir(folder):
                os.makedirs(folder, exist_ok=True)
            out = generate_helmet_stl(params)
        except Exception as exc:  # noqa: BLE001 - GUI should show errors
            messagebox.showerror("Generation failed", str(exc))
            return
        messagebox.showinfo("STL generated", f"Saved STL file:\n{out}")


if __name__ == "__main__":
    app = HelmetGeneratorApp()
    app.mainloop()
