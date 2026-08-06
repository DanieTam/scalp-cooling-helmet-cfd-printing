function out = model
%
% helmet_cooling_model_v7.m
%
% Model exported on Mar 15 2026, 22:19 by COMSOL 6.3.0.420.

import com.comsol.model.*
import com.comsol.model.util.*

model = ModelUtil.create('Model');

model.modelPath(['C:\Users\danie\OneDrive - Universit' native2unicode(hex2dec({'00' 'e0'}), 'unicode') ' di Napoli Federico II\2nd mission - research\2026_5_Helmet_Cancer']);

model.label('helmet_cooling_model_v4.mph');

model.component.create('comp1', true);

model.component('comp1').geom.create('geom1', 3);
model.component('comp1').geom('geom1').lengthUnit('mm');

model.param.set('Rx_head', '95[mm]');
model.param.set('Ry_head', '80[mm]');
model.param.set('Rz_head', '115[mm]');
model.param.set('gap', '4[mm]');
model.param.set('shell', '5[mm]');
model.param.set('z_cut', '-15[mm]');
model.param.set('Rx_out', 'Rx_head+gap+shell');
model.param.set('Ry_out', 'Ry_head+gap+shell');
model.param.set('Rz_out', 'Rz_head+gap+shell');
model.param.set('port_r', '3[mm]');
model.param.set('port_L', '22[mm]');
model.param.set('port_x', '100[mm]');
model.param.set('port_y', '0[mm]');
model.param.set('port_z0', 'z_cut-port_L+2[mm]');
model.param.set('dist_r', '3.0[mm]');
model.param.set('dist_h', '260[mm]');
model.param.set('dist_dx', '18[mm]');
model.param.set('dist_dy', '18[mm]');
model.param.set('dist_z0', '-20[mm]');
model.param.set('Qin', '1[L/min]');
model.param.set('Tin', '10[degC]');
model.param.set('Tskin', '36[degC]');
model.param.set('Uin', 'Qin/(pi*port_r^2)');
model.param.set('rho_w', '997[kg/m^3]');
model.param.set('mu_w', '0.00089[Pa*s]');
model.param.set('k_w', '0.6[W/(m*K)]');
model.param.set('Cp_w', '4180[J/(kg*K)]');
model.param.set('sel_pad_xy', '1.5[mm]');
model.param.set('sel_pad_z', '1[mm]');

model.component('comp1').geom('geom1').create('scalp', 'Ellipsoid');
model.component('comp1').geom('geom1').feature('scalp').set('semiaxes', {'Rx_head' 'Ry_head' 'Rz_head'});
model.component('comp1').geom('geom1').feature('scalp').set('pos', {'0' '0' '0'});
model.component('comp1').geom('geom1').create('outer', 'Ellipsoid');
model.component('comp1').geom('geom1').feature('outer').set('semiaxes', {'Rx_out' 'Ry_out' 'Rz_out'});
model.component('comp1').geom('geom1').feature('outer').set('pos', {'0' '0' '0'});
model.component('comp1').geom('geom1').create('shell_raw', 'Difference');
model.component('comp1').geom('geom1').feature('shell_raw').selection('input').set({'outer'});
model.component('comp1').geom('geom1').feature('shell_raw').selection('input2').set({'scalp'});
model.component('comp1').geom('geom1').create('cut_blk', 'Block');
model.component('comp1').geom('geom1').feature('cut_blk').set('base', 'corner');
model.component('comp1').geom('geom1').feature('cut_blk').set('size', {'400[mm]' '400[mm]' '300[mm]'});
model.component('comp1').geom('geom1').feature('cut_blk').set('pos', {'-200[mm]' '-200[mm]' 'z_cut'});
model.component('comp1').geom('geom1').create('helmet_shell', 'Intersection');
model.component('comp1').geom('geom1').feature('helmet_shell').selection('input').set({'shell_raw' 'cut_blk'});
model.component('comp1').geom('geom1').create('inlet', 'Cylinder');
model.component('comp1').geom('geom1').feature('inlet').set('r', 'port_r');
model.component('comp1').geom('geom1').feature('inlet').set('h', 'port_L');
model.component('comp1').geom('geom1').feature('inlet').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('inlet').set('pos', {'-port_x' 'port_y' 'port_z0'});
model.component('comp1').geom('geom1').create('outlet', 'Cylinder');
model.component('comp1').geom('geom1').feature('outlet').set('r', 'port_r');
model.component('comp1').geom('geom1').feature('outlet').set('h', 'port_L');
model.component('comp1').geom('geom1').feature('outlet').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('outlet').set('pos', {'port_x' 'port_y' 'port_z0'});
model.component('comp1').geom('geom1').create('distHole_1', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_1').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_1').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_1').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_1').set('pos', {'(-4)*dist_dx' '(-3)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_2', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_2').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_2').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_2').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_2').set('pos', {'(-4)*dist_dx + 0.5*dist_dx' '(-2)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_3', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_3').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_3').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_3').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_3').set('pos', {'(-4)*dist_dx' '(-1)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_4', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_4').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_4').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_4').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_4').set('pos', {'(-4)*dist_dx + 0.5*dist_dx' '(0)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_5', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_5').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_5').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_5').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_5').set('pos', {'(-4)*dist_dx' '(1)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_6', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_6').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_6').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_6').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_6').set('pos', {'(-4)*dist_dx + 0.5*dist_dx' '(2)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_7', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_7').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_7').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_7').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_7').set('pos', {'(-4)*dist_dx' '(3)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_8', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_8').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_8').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_8').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_8').set('pos', {'(-3)*dist_dx' '(-3)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_9', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_9').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_9').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_9').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_9').set('pos', {'(-3)*dist_dx + 0.5*dist_dx' '(-2)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_10', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_10').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_10').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_10').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_10').set('pos', {'(-3)*dist_dx' '(-1)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_11', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_11').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_11').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_11').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_11').set('pos', {'(-3)*dist_dx + 0.5*dist_dx' '(0)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_12', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_12').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_12').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_12').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_12').set('pos', {'(-3)*dist_dx' '(1)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_13', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_13').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_13').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_13').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_13').set('pos', {'(-3)*dist_dx + 0.5*dist_dx' '(2)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_14', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_14').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_14').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_14').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_14').set('pos', {'(-3)*dist_dx' '(3)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_15', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_15').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_15').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_15').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_15').set('pos', {'(-2)*dist_dx' '(-3)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_16', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_16').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_16').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_16').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_16').set('pos', {'(-2)*dist_dx + 0.5*dist_dx' '(-2)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_17', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_17').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_17').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_17').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_17').set('pos', {'(-2)*dist_dx' '(-1)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_18', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_18').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_18').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_18').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_18').set('pos', {'(-2)*dist_dx + 0.5*dist_dx' '(0)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_19', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_19').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_19').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_19').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_19').set('pos', {'(-2)*dist_dx' '(1)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_20', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_20').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_20').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_20').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_20').set('pos', {'(-2)*dist_dx + 0.5*dist_dx' '(2)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_21', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_21').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_21').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_21').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_21').set('pos', {'(-2)*dist_dx' '(3)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_22', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_22').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_22').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_22').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_22').set('pos', {'(-1)*dist_dx' '(-3)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_23', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_23').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_23').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_23').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_23').set('pos', {'(-1)*dist_dx + 0.5*dist_dx' '(-2)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_24', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_24').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_24').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_24').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_24').set('pos', {'(-1)*dist_dx' '(-1)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_25', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_25').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_25').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_25').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_25').set('pos', {'(-1)*dist_dx + 0.5*dist_dx' '(0)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_26', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_26').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_26').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_26').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_26').set('pos', {'(-1)*dist_dx' '(1)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_27', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_27').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_27').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_27').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_27').set('pos', {'(-1)*dist_dx + 0.5*dist_dx' '(2)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_28', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_28').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_28').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_28').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_28').set('pos', {'(-1)*dist_dx' '(3)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_29', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_29').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_29').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_29').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_29').set('pos', {'(0)*dist_dx' '(-3)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_30', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_30').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_30').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_30').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_30').set('pos', {'(0)*dist_dx + 0.5*dist_dx' '(-2)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_31', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_31').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_31').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_31').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_31').set('pos', {'(0)*dist_dx' '(-1)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_32', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_32').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_32').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_32').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_32').set('pos', {'(0)*dist_dx + 0.5*dist_dx' '(0)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_33', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_33').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_33').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_33').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_33').set('pos', {'(0)*dist_dx' '(1)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_34', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_34').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_34').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_34').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_34').set('pos', {'(0)*dist_dx + 0.5*dist_dx' '(2)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_35', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_35').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_35').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_35').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_35').set('pos', {'(0)*dist_dx' '(3)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_36', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_36').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_36').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_36').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_36').set('pos', {'(1)*dist_dx' '(-3)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_37', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_37').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_37').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_37').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_37').set('pos', {'(1)*dist_dx + 0.5*dist_dx' '(-2)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_38', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_38').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_38').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_38').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_38').set('pos', {'(1)*dist_dx' '(-1)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_39', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_39').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_39').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_39').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_39').set('pos', {'(1)*dist_dx + 0.5*dist_dx' '(0)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_40', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_40').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_40').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_40').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_40').set('pos', {'(1)*dist_dx' '(1)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_41', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_41').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_41').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_41').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_41').set('pos', {'(1)*dist_dx + 0.5*dist_dx' '(2)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_42', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_42').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_42').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_42').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_42').set('pos', {'(1)*dist_dx' '(3)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_43', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_43').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_43').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_43').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_43').set('pos', {'(2)*dist_dx' '(-3)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_44', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_44').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_44').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_44').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_44').set('pos', {'(2)*dist_dx + 0.5*dist_dx' '(-2)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_45', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_45').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_45').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_45').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_45').set('pos', {'(2)*dist_dx' '(-1)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_46', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_46').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_46').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_46').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_46').set('pos', {'(2)*dist_dx + 0.5*dist_dx' '(0)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_47', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_47').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_47').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_47').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_47').set('pos', {'(2)*dist_dx' '(1)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_48', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_48').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_48').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_48').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_48').set('pos', {'(2)*dist_dx + 0.5*dist_dx' '(2)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_49', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_49').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_49').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_49').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_49').set('pos', {'(2)*dist_dx' '(3)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_50', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_50').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_50').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_50').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_50').set('pos', {'(3)*dist_dx' '(-3)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_51', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_51').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_51').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_51').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_51').set('pos', {'(3)*dist_dx + 0.5*dist_dx' '(-2)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_52', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_52').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_52').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_52').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_52').set('pos', {'(3)*dist_dx' '(-1)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_53', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_53').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_53').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_53').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_53').set('pos', {'(3)*dist_dx + 0.5*dist_dx' '(0)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_54', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_54').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_54').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_54').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_54').set('pos', {'(3)*dist_dx' '(1)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_55', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_55').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_55').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_55').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_55').set('pos', {'(3)*dist_dx + 0.5*dist_dx' '(2)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_56', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_56').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_56').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_56').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_56').set('pos', {'(3)*dist_dx' '(3)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_57', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_57').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_57').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_57').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_57').set('pos', {'(4)*dist_dx' '(-3)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_58', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_58').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_58').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_58').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_58').set('pos', {'(4)*dist_dx + 0.5*dist_dx' '(-2)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_59', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_59').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_59').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_59').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_59').set('pos', {'(4)*dist_dx' '(-1)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_60', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_60').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_60').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_60').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_60').set('pos', {'(4)*dist_dx + 0.5*dist_dx' '(0)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_61', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_61').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_61').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_61').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_61').set('pos', {'(4)*dist_dx' '(1)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_62', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_62').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_62').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_62').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_62').set('pos', {'(4)*dist_dx + 0.5*dist_dx' '(2)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('distHole_63', 'Cylinder');
model.component('comp1').geom('geom1').feature('distHole_63').set('r', 'dist_r');
model.component('comp1').geom('geom1').feature('distHole_63').set('h', 'dist_h');
model.component('comp1').geom('geom1').feature('distHole_63').set('axis', {'0' '0' '1'});
model.component('comp1').geom('geom1').feature('distHole_63').set('pos', {'(4)*dist_dx' '(3)*dist_dy' 'dist_z0'});
model.component('comp1').geom('geom1').create('dist_union', 'Union');
model.component('comp1').geom('geom1').feature('dist_union').selection('input').set({'distHole_1' 'distHole_2' 'distHole_3' 'distHole_4' 'distHole_5' 'distHole_6' 'distHole_7' 'distHole_8' 'distHole_9' 'distHole_10'  ...
'distHole_11' 'distHole_12' 'distHole_13' 'distHole_14' 'distHole_15' 'distHole_16' 'distHole_17' 'distHole_18' 'distHole_19' 'distHole_20'  ...
'distHole_21' 'distHole_22' 'distHole_23' 'distHole_24' 'distHole_25' 'distHole_26' 'distHole_27' 'distHole_28' 'distHole_29' 'distHole_30'  ...
'distHole_31' 'distHole_32' 'distHole_33' 'distHole_34' 'distHole_35' 'distHole_36' 'distHole_37' 'distHole_38' 'distHole_39' 'distHole_40'  ...
'distHole_41' 'distHole_42' 'distHole_43' 'distHole_44' 'distHole_45' 'distHole_46' 'distHole_47' 'distHole_48' 'distHole_49' 'distHole_50'  ...
'distHole_51' 'distHole_52' 'distHole_53' 'distHole_54' 'distHole_55' 'distHole_56' 'distHole_57' 'distHole_58' 'distHole_59' 'distHole_60'  ...
'distHole_61' 'distHole_62' 'distHole_63'});
model.component('comp1').geom('geom1').feature('dist_union').set('intbnd', false);
model.component('comp1').geom('geom1').create('fluid_core', 'Difference');
model.component('comp1').geom('geom1').feature('fluid_core').selection('input').set({'helmet_shell'});
model.component('comp1').geom('geom1').feature('fluid_core').selection('input2').set({'dist_union'});
model.component('comp1').geom('geom1').create('fluid_final', 'Union');
model.component('comp1').geom('geom1').feature('fluid_final').selection('input').set({'fluid_core' 'inlet' 'outlet'});
model.component('comp1').geom('geom1').feature('fluid_final').set('intbnd', false);
model.component('comp1').geom('geom1').run;

model.component('comp1').selection.create('sel_inlet_bnd', 'Box');
model.component('comp1').selection('sel_inlet_bnd').geom('geom1', 2);
model.component('comp1').selection('sel_inlet_bnd').set('entitydim', 2);
model.component('comp1').selection('sel_inlet_bnd').set('xmin', '-port_x-port_r-sel_pad_xy');
model.component('comp1').selection('sel_inlet_bnd').set('xmax', '-port_x+port_r+sel_pad_xy');
model.component('comp1').selection('sel_inlet_bnd').set('ymin', '-port_r-sel_pad_xy');
model.component('comp1').selection('sel_inlet_bnd').set('ymax', ' port_r+sel_pad_xy');
model.component('comp1').selection('sel_inlet_bnd').set('zmin', 'port_z0-sel_pad_z');
model.component('comp1').selection('sel_inlet_bnd').set('zmax', 'port_z0+sel_pad_z');
model.component('comp1').selection.create('sel_outlet_bnd', 'Box');
model.component('comp1').selection('sel_outlet_bnd').geom('geom1', 2);
model.component('comp1').selection('sel_outlet_bnd').set('entitydim', 2);
model.component('comp1').selection('sel_outlet_bnd').set('xmin', 'port_x-port_r-sel_pad_xy');
model.component('comp1').selection('sel_outlet_bnd').set('xmax', 'port_x+port_r+sel_pad_xy');
model.component('comp1').selection('sel_outlet_bnd').set('ymin', '-port_r-sel_pad_xy');
model.component('comp1').selection('sel_outlet_bnd').set('ymax', ' port_r+sel_pad_xy');
model.component('comp1').selection('sel_outlet_bnd').set('zmin', 'port_z0-sel_pad_z');
model.component('comp1').selection('sel_outlet_bnd').set('zmax', 'port_z0+sel_pad_z');
model.component('comp1').selection.create('sel_skin_bnd', 'Box');
model.component('comp1').selection('sel_skin_bnd').geom('geom1', 2);
model.component('comp1').selection('sel_skin_bnd').set('entitydim', 2);
model.component('comp1').selection('sel_skin_bnd').set('xmin', '-Rx_head-sel_pad_xy');
model.component('comp1').selection('sel_skin_bnd').set('xmax', ' Rx_head+sel_pad_xy');
model.component('comp1').selection('sel_skin_bnd').set('ymin', '-Ry_head-sel_pad_xy');
model.component('comp1').selection('sel_skin_bnd').set('ymax', ' Ry_head+sel_pad_xy');
model.component('comp1').selection('sel_skin_bnd').set('zmin', 'z_cut+0.5[mm]');
model.component('comp1').selection('sel_skin_bnd').set('zmax', 'Rz_head+sel_pad_xy');

model.component('comp1').material.create('mat1', 'Common');
model.component('comp1').material('mat1').label('Water_like');
model.component('comp1').material('mat1').propertyGroup('def').set('density', 'rho_w');
model.component('comp1').material('mat1').propertyGroup('def').set('dynamicviscosity', 'mu_w');
model.component('comp1').material('mat1').propertyGroup('def').set('thermalconductivity', {'k_w' '0' '0' '0' 'k_w' '0' '0' '0' 'k_w'});
model.component('comp1').material('mat1').propertyGroup('def').set('heatcapacity', 'Cp_w');

model.component('comp1').physics.create('spf', 'LaminarFlow', 'geom1');
model.component('comp1').physics('spf').create('inl1', 'Inlet', 2);
model.component('comp1').physics('spf').feature('inl1').selection.named('sel_inlet_bnd');
model.component('comp1').physics('spf').feature('inl1').set('BoundaryCondition', 'Velocity');
model.component('comp1').physics('spf').feature('inl1').set('U0in', 'Uin');
model.component('comp1').physics('spf').create('out1', 'Outlet', 2);
model.component('comp1').physics('spf').feature('out1').selection.named('sel_outlet_bnd');
model.component('comp1').physics('spf').feature('out1').set('p0', 0);
model.component('comp1').physics.create('ht', 'HeatTransferInFluids', 'geom1');
model.component('comp1').physics('ht').create('temp_in', 'TemperatureBoundary', 2);
model.component('comp1').physics('ht').feature('temp_in').selection.named('sel_inlet_bnd');
model.component('comp1').physics('ht').feature('temp_in').set('T0', 'Tin');
model.component('comp1').physics('ht').create('temp_skin', 'TemperatureBoundary', 2);
model.component('comp1').physics('ht').feature('temp_skin').selection.named('sel_skin_bnd');
model.component('comp1').physics('ht').feature('temp_skin').set('T0', 'Tskin');

model.component('comp1').multiphysics.create('nitf1', 'NonIsothermalFlow', 3);

model.component('comp1').mesh.create('mesh1');
model.component('comp1').mesh('mesh1').automatic(true);
model.component('comp1').mesh('mesh1').autoMeshSize(4);

model.study.create('std1');
model.study('std1').create('stat', 'Stationary');
model.study('std1').feature('stat').set('activate', {'spf' 'on' 'ht' 'on'});

model.component('comp1').mesh('mesh1').run;

model.component('comp1').geom('geom1').run('fin');

model.label('helmet_cooling_model_v4.mph');

model.component('comp1').mesh('mesh1').autoMeshSize(7);
model.component('comp1').mesh('mesh1').run;

model.component('comp1').physics('ht').feature('temp_skin').selection.set([5 11 12 13 14 15 31 32 141 142 147 153 269 270 283 284]);

model.study('std1').feature('stat').set('plot', true);
model.study('std1').createAutoSequences('all');

model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Velocity (spf)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').feature.create('slc1', 'Slice');
model.result('pg1').feature('slc1').label('Slice');
model.result('pg1').feature('slc1').set('showsolutionparams', 'on');
model.result('pg1').feature('slc1').set('smooth', 'internal');
model.result('pg1').feature('slc1').set('showsolutionparams', 'on');
model.result('pg1').feature('slc1').set('data', 'parent');
model.result.dataset.create('surf1', 'Surface');
model.result.dataset('surf1').label('Exterior Walls');
model.result.dataset('surf1').set('data', 'dset1');
model.result.dataset('surf1').selection.geom('geom1', 2);
model.result.dataset('surf1').selection.set([1 2 3 4 5 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286]);

model.sol('sol1').runAll;

model.result.remove('pg1');

model.study('std1').feature('stat').set('plotgroup', 'Default');

model.result.dataset('dset1').set('geom', 'geom1');
model.result.create('pg1', 'PlotGroup3D');
model.result('pg1').label('Velocity (spf)');
model.result('pg1').set('frametype', 'spatial');
model.result('pg1').feature.create('slc1', 'Slice');
model.result('pg1').feature('slc1').label('Slice');
model.result('pg1').feature('slc1').set('showsolutionparams', 'on');
model.result('pg1').feature('slc1').set('smooth', 'internal');
model.result('pg1').feature('slc1').set('showsolutionparams', 'on');
model.result('pg1').feature('slc1').set('data', 'parent');
model.result.dataset('surf1').set('data', 'dset1');
model.result.dataset('surf1').selection.geom('geom1', 2);
model.result.dataset('surf1').selection.set([1 2 3 4 5 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286]);
model.result.create('pg2', 'PlotGroup3D');
model.result('pg2').label('Pressure (spf)');
model.result('pg2').set('data', 'surf1');
model.result('pg2').set('frametype', 'spatial');
model.result('pg2').feature.create('surf1', 'Surface');
model.result('pg2').feature('surf1').label('Surface');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('expr', 'p');
model.result('pg2').feature('surf1').set('colortable', 'Dipole');
model.result('pg2').feature('surf1').set('smooth', 'internal');
model.result('pg2').feature('surf1').set('showsolutionparams', 'on');
model.result('pg2').feature('surf1').set('data', 'parent');
model.result('pg2').feature('surf1').feature.create('tran1', 'Transparency');
model.result.create('pg3', 'PlotGroup3D');
model.result('pg3').label('Temperature (ht)');
model.result('pg3').feature.create('vol1', 'Volume');
model.result('pg3').feature('vol1').set('showsolutionparams', 'on');
model.result('pg3').feature('vol1').set('solutionparams', 'parent');
model.result('pg3').feature('vol1').set('expr', 'T');
model.result('pg3').feature('vol1').set('colortable', 'HeatCameraLight');
model.result('pg3').feature('vol1').set('smooth', 'internal');
model.result('pg3').feature('vol1').set('showsolutionparams', 'on');
model.result('pg3').feature('vol1').set('data', 'parent');
model.result.create('pg4', 'PlotGroup3D');
model.result('pg4').label('Temperature and Fluid Flow (nitf1)');
model.result('pg4').set('showlegendsunit', true);
model.result('pg4').feature.create('surf1', 'Surface');
model.result('pg4').feature('surf1').label('Wall Temperature');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('solutionparams', 'parent');
model.result('pg4').feature('surf1').set('expr', 'ht.Tvar');
model.result('pg4').feature('surf1').set('colortable', 'HeatCameraLight');
model.result('pg4').feature('surf1').set('smooth', 'internal');
model.result('pg4').feature('surf1').set('showsolutionparams', 'on');
model.result('pg4').feature('surf1').set('data', 'parent');
model.result('pg4').feature('surf1').feature.create('sel1', 'Selection');
model.result('pg4').feature('surf1').feature('sel1').selection.geom('geom1', 2);
model.result('pg4').feature('surf1').feature('sel1').selection.set([1 2 3 4 5 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 96 97 98 99 100 101 102 103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 131 132 133 134 135 136 137 138 139 140 141 142 143 144 145 146 147 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175 176 177 178 179 180 181 182 183 184 185 186 187 188 189 190 191 192 193 194 195 196 197 198 199 200 201 202 203 204 205 206 207 208 209 210 211 212 213 214 215 216 217 218 219 220 221 222 223 224 225 226 227 228 229 230 231 232 233 234 235 236 237 238 239 240 241 242 243 244 245 246 247 248 249 250 251 252 253 254 255 256 257 258 259 260 261 262 263 264 265 266 267 268 269 270 271 272 273 274 275 276 277 278 279 280 281 282 283 284 285 286]);
model.result('pg4').feature.create('arwv1', 'ArrowVolume');
model.result('pg4').feature('arwv1').label('Fluid Flow');
model.result('pg4').feature('arwv1').set('showsolutionparams', 'on');
model.result('pg4').feature('arwv1').set('solutionparams', 'parent');
model.result('pg4').feature('arwv1').set('expr', {'nitf1.ux' 'nitf1.uy' 'nitf1.uz'});
model.result('pg4').feature('arwv1').set('xnumber', 30);
model.result('pg4').feature('arwv1').set('ynumber', 30);
model.result('pg4').feature('arwv1').set('znumber', 30);
model.result('pg4').feature('arwv1').set('arrowtype', 'cone');
model.result('pg4').feature('arwv1').set('arrowlength', 'logarithmic');
model.result('pg4').feature('arwv1').set('showsolutionparams', 'on');
model.result('pg4').feature('arwv1').set('data', 'parent');
model.result('pg4').feature('arwv1').feature.create('col1', 'Color');
model.result('pg4').feature('arwv1').feature('col1').set('showcolordata', 'off');
model.result('pg4').feature('arwv1').feature.create('filt1', 'Filter');
model.result('pg4').feature('arwv1').feature('filt1').set('expr', 'spf.U>nitf1.Uave');
model.result('pg1').run;
model.result('pg3').run;

model.label('helmet_cooling_model_v4.mph');

model.result('pg3').run;

model.component('comp1').geom('geom1').feature.duplicate('scalp1', 'scalp');
model.component('comp1').geom('geom1').feature.duplicate('outer1', 'outer');
model.component('comp1').geom('geom1').feature.duplicate('shell_raw1', 'shell_raw');
model.component('comp1').geom('geom1').feature.duplicate('cut_blk1', 'cut_blk');
model.component('comp1').geom('geom1').feature.duplicate('helmet_shell1', 'helmet_shell');
model.component('comp1').geom('geom1').feature('outer1').setIndex('semiaxes', 'Rx_head', 0);
model.component('comp1').geom('geom1').feature('outer1').setIndex('semiaxes', 'Rx_head', 1);
model.component('comp1').geom('geom1').feature('outer1').setIndex('semiaxes', 'Rz_head', 2);
model.component('comp1').geom('geom1').feature('outer1').setIndex('semiaxes', 'Ry_head', 1);
model.component('comp1').geom('geom1').feature('outer1').setIndex('semiaxes', 'Rx_head-2', 0);
model.component('comp1').geom('geom1').feature('outer1').setIndex('semiaxes', 'Ry_head-2', 1);
model.component('comp1').geom('geom1').feature('outer1').setIndex('semiaxes', 'Rz_head-2', 2);
model.component('comp1').geom('geom1').runPre('shell_raw1');
model.component('comp1').geom('geom1').feature('shell_raw1').selection('input').set({'scalp1'});

model.component('comp1').view('view1').set('transparency', true);
model.component('comp1').view('view1').set('clippingactive', true);
model.component('comp1').view('view1').clip.create('plane1', 'ClipPlane');
model.component('comp1').view('view1').clip('plane1').set('orientationaxes', [-1 0 0; 0 -1 0; 0 0 1]);
model.component('comp1').view('view1').clip('plane1').set('position', [0 0 4.500000000000014]);
model.component('comp1').view('view1').clip('plane1').set('translationamount', 19.667705977802626);

model.component('comp1').geom('geom1').feature('shell_raw1').selection('input2').set({'outer1'});
model.component('comp1').geom('geom1').run('cut_blk1');
model.component('comp1').geom('geom1').feature('helmet_shell1').selection('input').set({'cut_blk1' 'shell_raw1'});
model.component('comp1').geom('geom1').run('helmet_shell1');
model.component('comp1').geom('geom1').runPre('fin');

model.component('comp1').view('view1').set('clippingactive', false);

model.component('comp1').geom('geom1').feature('outer1').setIndex('semiaxes', 'Rx_head-10', 0);
model.component('comp1').geom('geom1').feature('outer1').setIndex('semiaxes', 'Ry_head-10', 1);
model.component('comp1').geom('geom1').feature('outer1').setIndex('semiaxes', 'Rz_head-10', 2);
model.component('comp1').geom('geom1').runPre('fin');
model.component('comp1').geom('geom1').feature('outer1').setIndex('semiaxes', 'Rx_head-15', 0);
model.component('comp1').geom('geom1').feature('outer1').setIndex('semiaxes', 'Ry_head-15', 1);
model.component('comp1').geom('geom1').feature('outer1').setIndex('semiaxes', 'Rz_head-15', 2);
model.component('comp1').geom('geom1').run;
model.component('comp1').geom('geom1').run('fin');
model.component('comp1').geom('geom1').feature.create('rmd1', 'RemoveDetails');
model.component('comp1').geom('geom1').feature('rmd1').set('detailsizetype', 'absolute');
model.component('comp1').geom('geom1').feature('rmd1').set('maxabssize', '0.21');
model.component('comp1').geom('geom1').run('rmd1');

model.component('comp1').physics('ht').feature('temp_skin').selection.set([16 17 18 19 180 181 188 197]);

model.component('comp1').geom('geom1').nodeGroup.create('grp1');
model.component('comp1').geom('geom1').nodeGroup('grp1').placeAfter('fluid_final');
model.component('comp1').geom('geom1').nodeGroup('grp1').add('scalp1');
model.component('comp1').geom('geom1').nodeGroup('grp1').add('outer1');
model.component('comp1').geom('geom1').nodeGroup('grp1').add('shell_raw1');
model.component('comp1').geom('geom1').nodeGroup('grp1').add('cut_blk1');
model.component('comp1').geom('geom1').nodeGroup('grp1').add('helmet_shell1');
model.component('comp1').geom('geom1').runPre('fin');
model.component('comp1').geom('geom1').nodeGroup.duplicate('grp2', 'grp1');
model.component('comp1').geom('geom1').nodeGroup.duplicate('grp3', 'grp2');
model.component('comp1').geom('geom1').nodeGroup('grp1').label('HelmetPlastic_IN');
model.component('comp1').geom('geom1').nodeGroup('grp2').label('HelmetPlastic_OUT');
model.component('comp1').geom('geom1').nodeGroup('grp3').label('Head');
model.component('comp1').geom('geom1').feature('scalp3').setIndex('semiaxes', 'Rx_head+4', 0);
model.component('comp1').geom('geom1').feature('scalp3').setIndex('semiaxes', 'Ry_head+4', 1);
model.component('comp1').geom('geom1').feature('scalp3').setIndex('semiaxes', 'Rz_head+4', 2);
model.component('comp1').geom('geom1').feature('outer3').setIndex('semiaxes', 'Rx_head-20', 0);
model.component('comp1').geom('geom1').feature('outer3').setIndex('semiaxes', 'Ry_head-20', 1);
model.component('comp1').geom('geom1').feature('outer3').setIndex('semiaxes', 'Rz_head-20', 2);
model.component('comp1').geom('geom1').feature('outer1').setIndex('semiaxes', 'Rx_head-4', 0);
model.component('comp1').geom('geom1').feature('outer1').setIndex('semiaxes', 'Ry_head-4', 1);
model.component('comp1').geom('geom1').feature('outer1').setIndex('semiaxes', 'Rz_head-4', 2);
model.component('comp1').geom('geom1').run('outer2');
model.component('comp1').geom('geom1').nodeGroup('grp3').active(false);
model.component('comp1').geom('geom1').nodeGroup('grp1').active(false);
model.component('comp1').geom('geom1').run('outer2');

model.component('comp1').view('view1').set('clippingactive', true);

model.component('comp1').geom('geom1').feature('shell_raw2').selection('input').set({'scalp2'});
model.component('comp1').geom('geom1').feature('shell_raw2').selection('input2').set({'outer2'});
model.component('comp1').geom('geom1').run('shell_raw2');
model.component('comp1').geom('geom1').runPre('helmet_shell2');
model.component('comp1').geom('geom1').feature('helmet_shell2').selection('input').set({'cut_blk2' 'shell_raw2'});
model.component('comp1').geom('geom1').run('helmet_shell2');
model.component('comp1').geom('geom1').feature('scalp2').setIndex('semiaxes', 'Rx_out', 0);
model.component('comp1').geom('geom1').feature('scalp2').setIndex('semiaxes', 'Ry_out', 1);
model.component('comp1').geom('geom1').feature('scalp2').setIndex('semiaxes', 'Rz_out', 2);
model.component('comp1').geom('geom1').feature('outer2').setIndex('semiaxes', 'Rx_out+4', 0);
model.component('comp1').geom('geom1').feature('outer2').setIndex('semiaxes', 'Ry_out+4', 1);
model.component('comp1').geom('geom1').feature('outer2').setIndex('semiaxes', 'Rz_out+4', 2);
model.component('comp1').geom('geom1').runPre('fin');
model.component('comp1').geom('geom1').feature('scalp2').setIndex('semiaxes', 'Rx_out+4', 0);
model.component('comp1').geom('geom1').feature('scalp2').setIndex('semiaxes', 'Ry_out+4', 1);
model.component('comp1').geom('geom1').feature('scalp2').setIndex('semiaxes', 'Rz_out+4', 2);
model.component('comp1').geom('geom1').feature('outer2').setIndex('semiaxes', 'Rx_out', 0);
model.component('comp1').geom('geom1').feature('outer2').setIndex('semiaxes', 'Ry_out', 1);
model.component('comp1').geom('geom1').feature('outer2').setIndex('semiaxes', 'Rz_out', 2);
model.component('comp1').geom('geom1').runPre('fin');
model.component('comp1').geom('geom1').nodeGroup('grp3').active(true);
model.component('comp1').geom('geom1').feature('scalp3').setIndex('semiaxes', 'Rx_head-4', 0);
model.component('comp1').geom('geom1').feature('scalp3').setIndex('semiaxes', 'Ry_head-4', 1);
model.component('comp1').geom('geom1').feature('scalp3').setIndex('semiaxes', 'Rz_head-4', 2);
model.component('comp1').geom('geom1').runPre('shell_raw3');
model.component('comp1').geom('geom1').feature('shell_raw3').selection('input').set({'scalp3'});
model.component('comp1').geom('geom1').feature('shell_raw3').selection('input2').set({'outer3'});
model.component('comp1').geom('geom1').runPre('helmet_shell3');
model.component('comp1').geom('geom1').feature('helmet_shell3').selection('input').set({'cut_blk3' 'shell_raw3'});
model.component('comp1').geom('geom1').runPre('fin');
model.component('comp1').geom('geom1').nodeGroup('grp1').active(true);
model.component('comp1').geom('geom1').runPre('shell_raw1');
model.component('comp1').geom('geom1').feature('shell_raw1').selection('input').init;
model.component('comp1').geom('geom1').feature('shell_raw1').selection('input').set({'scalp1'});
model.component('comp1').geom('geom1').runPre('helmet_shell1');
model.component('comp1').geom('geom1').feature('helmet_shell1').selection('input').set({'shell_raw1'});
model.component('comp1').geom('geom1').feature('helmet_shell1').selection('input').init;
model.component('comp1').geom('geom1').run('cut_blk1');
model.component('comp1').geom('geom1').feature('helmet_shell1').selection('input').set({'cut_blk1' 'shell_raw1'});
model.component('comp1').geom('geom1').runPre('fin');

model.component('comp1').view('view1').set('clippingactive', false);

model.component('comp1').geom('geom1').run;

model.component('comp1').physics('spf').selection.set([2]);
model.component('comp1').physics('ht').selection.set([2]);
model.component('comp1').physics('ht').feature('temp_skin').active(false);
model.component('comp1').physics.create('ht2', 'HeatTransfer', 'geom1');

model.study('std1').feature('stat').setSolveFor('/physics/ht2', true);

model.component('comp1').physics('ht2').selection.set([1 3 4]);
model.component('comp1').physics('ht2').create('hf1', 'HeatFluxBoundary', 2);
model.component('comp1').physics('ht2').feature('hf1').selection.set([25]);
model.component('comp1').physics('ht2').create('hs1', 'HeatSource', 3);
model.component('comp1').physics('ht2').feature('hs1').selection.set([4]);
model.component('comp1').physics('ht2').feature('hf1').active(false);
model.component('comp1').physics.create('ht3', 'HeatTransferInSolidsAndFluids', 'geom1');

model.study('std1').feature('stat').setSolveFor('/physics/ht3', true);

model.label('helmet_cooling_model_v6_test2.mph');

model.component('comp1').physics('ht3').active(false);

model.component('comp1').view('view1').set('clippingactive', false);

model.component('comp1').multiphysics.remove('nitf1');

model.component('comp1').physics('ht').active(false);
model.component('comp1').physics('ht2').active(false);
model.component('comp1').physics.create('ht4', 'HeatTransferInSolidsAndFluids', 'geom1');

model.study('std1').feature('stat').setSolveFor('/physics/ht4', true);

model.component('comp1').physics('ht4').feature('fluid1').selection.set([2]);

model.component('comp1').multiphysics.create('nitf1', 'NonIsothermalFlow', 3);

model.component('comp1').physics('ht4').feature('fluid1').set('u_src', 'root.comp1.u');
model.component('comp1').physics('ht4').feature('fluid1').set('minput_pressure_src', 'root.comp1.spf.pA');

model.component('comp1').multiphysics('nitf1').active(false);

model.component('comp1').physics('ht4').feature('solid1').set('k_mat', 'userdef');
model.component('comp1').physics('ht4').feature('solid1').set('k', [1000 0 0 0 1000 0 0 0 1000]);
model.component('comp1').physics('ht4').feature('solid1').set('rho_mat', 'userdef');
model.component('comp1').physics('ht4').feature('solid1').set('k', [100 0 0 0 100 0 0 0 100]);
model.component('comp1').physics('ht4').feature('solid1').set('rho', 1200);
model.component('comp1').physics('ht4').feature('solid1').set('Cp_mat', 'userdef');
model.component('comp1').physics('ht4').feature('solid1').set('Cp', 1200);
model.component('comp1').physics('ht4').feature('fluid1').set('k_mat', 'userdef');
model.component('comp1').physics('ht4').feature('fluid1').set('k', [100 0 0 0 100 0 0 0 100]);
model.component('comp1').physics('ht4').feature('fluid1').set('fluidType', 'idealGas');
model.component('comp1').physics('ht4').feature('fluid1').set('Rs_mat', 'userdef');
model.component('comp1').physics('ht4').feature('fluid1').set('Rs', 100);
model.component('comp1').physics('ht4').feature('fluid1').set('heatcapacity_mat', 'userdef');
model.component('comp1').physics('ht4').feature('fluid1').set('heatcapacity', 12000);
model.component('comp1').physics('ht4').create('temp1', 'TemperatureBoundary', 2);
model.component('comp1').physics('ht4').feature('temp1').selection.set([456]);
model.component('comp1').physics('ht4').feature('temp1').set('T0', '273.15[K]');
model.component('comp1').physics('spf').feature('inl1').selection.set([13]);
model.component('comp1').physics('ht4').feature('temp1').selection.set([13]);

model.component('comp1').mesh('mesh1').run;

model.study('std1').createAutoSequences('all');

model.component('comp1').physics('ht4').create('temp2', 'TemperatureBoundary', 2);
model.component('comp1').physics('ht4').feature('temp2').selection.set([35 36 231 240]);

model.study('std1').createAutoSequences('all');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg2').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').run;
model.result('pg3').run;

model.component('comp1').multiphysics('nitf1').active(true);
model.component('comp1').multiphysics('nitf1').set('Heat_physics', 'ht4');

model.study('std1').createAutoSequences('all');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').feature('vol1').set('descr', 'T Temperature');
model.result('pg3').feature('vol1').set('expr', 'T4');
model.result('pg3').run;

model.label('helmet_cooling_model_v6_test2.mph');

model.result('pg4').run;
model.result('pg3').run;
model.result.table.create('evl3', 'Table');
model.result.table('evl3').comments('Interactive 3D values');
model.result.table('evl3').label('Evaluation 3D');
model.result.table('evl3').addRow([9.152167993895693 -91.74283433815455 17.112111109888357 293.14786836727626], [0 0 0 0]);

model.param.set('Qin', '10[L/min]');

model.study('std1').createAutoSequences('all');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg3').run;

model.component('comp1').physics('ht4').create('hs1', 'HeatSource', 3);
model.component('comp1').physics('ht4').feature('hs1').set('Q0', 'rho_b*Cp_b*omega_b*(Tb-T4)+Qmet');

model.param.set('rho_b', '1000[kg/m^3]');
model.param.set('Cp_b', '3600[J/(kg*K)]');
model.param.set('Tb', '310.15[K]');
model.param.set('Qmet', '1000[W/m^3]');
model.param.set('omega_b', '0.005[1/s]');
model.param.set('Qmet', '5000[W/m^3]');
model.param.set('rho_b', '1050[kg/m^3]');

model.component('comp1').physics('ht4').feature('hs1').selection.set([4]);
model.component('comp1').physics('ht4').feature('solid1').set('k', [0.15 0 0 0 0.15 0 0 0 0.15]);
model.component('comp1').physics('ht4').feature('fluid1').set('k', [0.6 0 0 0 0.6 0 0 0 0.6]);
model.component('comp1').physics('ht4').feature('fluid1').set('heatcapacity', 4180);
model.component('comp1').physics('ht4').feature('fluid1').set('fluidType', 'gasLiquid');
model.component('comp1').physics('ht4').feature('fluid1').set('Cp_mat', 'userdef');
model.component('comp1').physics('ht4').feature('fluid1').set('rho_mat', 'userdef');
model.component('comp1').physics('ht4').feature('fluid1').set('rho', 1000);
model.component('comp1').physics('ht4').feature('fluid1').set('Cp', 4180);

model.study('std1').createAutoSequences('all');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg3').run;
model.result('pg3').run;

model.component('comp1').physics('ht4').feature('temp2').active(false);

model.result('pg3').run;

model.study('std1').createAutoSequences('all');

model.component('comp1').physics('spf').feature('fp1').set('mu_mat', 'userdef');

model.result('pg3').run;

model.study('std1').createAutoSequences('all');

model.sol('sol1').runAll;

model.result('pg1').run;
model.result('pg3').run;

model.label('helmet_cooling_model_v7.mph');

model.result('pg3').run;

out = model;
