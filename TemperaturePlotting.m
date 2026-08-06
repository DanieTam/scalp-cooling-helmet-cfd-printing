%% ============================================================
%  SECTION: Temperature Slice Visualization and PNG Export
%  ============================================================

clear; clc; close all;

filename = 'Temperature.txt';
output_folder = 'temperature_slices_png';

% Create output folder
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

%% Import data
opts = detectImportOptions(filename, ...
    'FileType', 'text', ...
    'CommentStyle', '%');

data = readmatrix(filename, opts);
data = data(~any(isnan(data),2), :);

% Columns
x = data(:,1);
y = data(:,2);
z = data(:,3);
T = data(:,4);

fprintf('Loaded %d valid points from %s\n', size(data,1), filename);

%% Global color scale
Tmin = min(T);
Tmax = max(T);

%% Choose slice locations across the helmet
% You can change nslices if you want more/less sections
nslices = 5;

xmin = min(x);
xmax = max(x);

xSlices = linspace(xmin, xmax, nslices);

fprintf('Plotting %d temperature slices from x = %.2f to x = %.2f mm\n', ...
    nslices, xmin, xmax);

%% Grid for interpolation
ny = 300;
nz = 300;

for i = 1:nslices

    xi = xSlices(i);

    % Select points close to the slice plane
    % tolerance based on x-range
    tol = (xmax - xmin)/40;
    idx = abs(x - xi) < tol;

    % If too few points, enlarge tolerance automatically
    if nnz(idx) < 20
        tol = tol * 2;
        idx = abs(x - xi) < tol;
    end

    yi = y(idx);
    zi = z(idx);
    Ti = T(idx);

    % Skip empty slices
    if isempty(Ti)
        fprintf('Skipping slice %d: no data near x = %.2f mm\n', i, xi);
        continue
    end

    % Interpolation grid
    yq = linspace(min(yi), max(yi), ny);
    zq = linspace(min(zi), max(zi), nz);
    [Yq, Zq] = meshgrid(yq, zq);

    % Interpolate scattered temperature data
    F = scatteredInterpolant(yi, zi, Ti, 'natural', 'none');
    Tq = F(Yq, Zq);

    %% Plot
    fig = figure('Color','w', 'Position', [100 100 650 520]);

    contourf(Yq, Zq, Tq, 40, 'LineColor', 'none');
    axis equal tight

    xlabel('y [mm]', 'FontSize', 12);
    ylabel('z [mm]', 'FontSize', 12);
    title(sprintf('Temperature slice at x = %.1f mm', xi), ...
        'FontSize', 13, 'FontWeight', 'normal');

    colormap(jet);
    cb = colorbar;
    cb.Label.String = 'Temperature [K]';

    caxis([Tmin Tmax]);
    set(gca, 'FontSize', 11, 'Box', 'on');

    %% Save figure
    filename_png = fullfile(output_folder, ...
        sprintf('temperature_slice_%02d_x_%0.1fmm.png', i, xi));

    exportgraphics(fig, filename_png, 'Resolution', 300);

    fprintf('Saved: %s\n', filename_png);

    close(fig);
end

fprintf('\nAll temperature slices exported successfully.\n');