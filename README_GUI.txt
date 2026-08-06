Parametric scalp-cooling helmet STL generator
============================================

File: scalp_cooling_helmet_generator_gui.py

Purpose:
- The GUI allows a reader to enter head dimensions and generate a research-prototype STL file.
- It preserves the paper concept: ellipsoidal patient scaling, shell/fluid-gap offsets, inlet/outlet ports, and a staggered fluidic channel guide network.

How to run:
1. Install Python 3.10 or newer.
2. Install dependencies:
   pip install numpy trimesh
3. Run:
   python scalp_cooling_helmet_generator_gui.py

Safety note:
The generated STL is for prototyping, phantom testing, and CFD iteration only. It is not a certified medical device and must not be used for clinical self-treatment without engineering validation, leak testing, thermal safety testing, biocompatibility evaluation, cleaning/sterilization validation, and regulatory approval.
