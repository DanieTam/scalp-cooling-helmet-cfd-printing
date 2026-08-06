# scalp-cooling-helmet-cfd-printing
Code, data, and figures supporting the manuscript on CFD-guided design of a patient-customizable liquid scalp-cooling helmet.


# CFD-guided patient-customizable liquid scalp-cooling helmet

This repository contains the code, data, and figure-generation files supporting the manuscript:

**CFD-guided design of a patient-customizable liquid scalp-cooling helmet: parametric analysis of coolant flow rate and scalp heat generation**

Submitted to *Virtual and Physical Prototyping*.

## Repository contents

- `helmet_cooling_model_v7.m`  
  COMSOL Multiphysics 6.3 MATLAB-exported model file used to define the geometry, materials, boundary conditions, physics, and stationary CFD/heat-transfer simulation.

- `VelocityPlotting.m`  
  MATLAB script used to import exported velocity data, interpolate the data on slice planes, and generate velocity contour plots.

- `TemperaturePlotting.m`  
  MATLAB script used to import exported temperature data, interpolate the data on slice planes, and generate temperature contour plots.

- `scalp_cooling_helmet_generator_gui.py`  
  Python GUI for generating patient-scaled research STL files from head dimensions and design parameters.

- `example_custom_scalp_cooling_helmet.stl`  
  Example STL generated with the Python GUI.

- `figures/`  
  Final figure files used in the manuscript, including CFD plots and printed TPU prototype photographs.

- `data/`  
  Numerical data used for plotting and summary tables, where available.

## Software

The CFD model was generated using COMSOL Multiphysics 6.3 and exported as a MATLAB model file. Post-processing was performed in MATLAB. The STL-generation GUI was implemented in Python using `tkinter`, `numpy`, and `trimesh`.

## Reproducibility notes

The MATLAB plotting scripts read exported point-cloud text files containing coordinates and scalar fields. The scripts remove invalid entries, interpolate scattered data onto regular slice grids using natural-neighbor interpolation, and export contour plots as high-resolution image files.

The files are provided for research reproducibility and prototyping only. They do not constitute a validated clinical device and must not be used for clinical treatment.

## License

The code is released under the License unless otherwise stated. The data and figures are released under CC BY 4.0.