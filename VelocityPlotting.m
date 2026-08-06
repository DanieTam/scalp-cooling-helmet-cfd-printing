%% ============================================================
%  SECTION: Velocity Slice Visualization and PNG Export
%  ============================================================

clear; clc; close all;

filename = 'Velocity.txt';
output_folder = 'velocity_slices_png';

% Create output folder if it does not exist
if ~exist(output_folder, 'dir')
    mkdir(output_folder);
end

%% Import data
opts = detectImportOptions(filename, ...
    'FileType', 'text', ...
    'CommentStyle', '%');

data = readmatrix(filename, opts);
data = data(~any(isnan(data),2), :);

x = data(:,1);
y = data(:,2);
z = data(:,3);
U = data(:,4);

%% Identify slice planes
xSlices = unique(round(x,6));
nSlices = numel(xSlices);

fprintf('Detected %d slices\n', nSlices);

%% Global color scale (consistent across figures)
cmin = min(U);
cmax = max(U);

%% Loop over slices
for i = 1:nSlices

    xi = xSlices(i);
    idx = abs(x - xi) < 1e-5;

    yi = y(idx);
    zi = z(idx);
    Ui = U(idx);

    % Grid interpolation for smooth contour
    ny = 300;
    nz = 300;
    yq = linspace(min(yi), max(yi), ny);
    zq = linspace(min(zi), max(zi), nz);
    [Yq, Zq] = meshgrid(yq, zq);

    F = scatteredInterpolant(yi, zi, Ui, 'natural', 'none');
    Uq = F(Yq, Zq);

    %% Plot
    fig = figure('Color','w', 'Position', [100 100 600 500]);

    contourf(Yq, Zq, Uq, 40, 'LineColor', 'none');
    axis equal tight

    xlabel('y [mm]', 'FontSize', 12);
    ylabel('z [mm]', 'FontSize', 12);
    title(sprintf('Velocity magnitude (x = %.1f mm)', xi), ...
        'FontSize', 13, 'FontWeight','normal');

    colormap(jet);
    cb = colorbar;
    cb.Label.String = 'Velocity magnitude [m/s]';

    caxis([cmin cmax]);

    set(gca, 'FontSize', 11, 'Box', 'on');

    %% Save figure
    filename_png = fullfile(output_folder, ...
        sprintf('slice_%02d_x_%0.1fmm.png', i, xi));

    exportgraphics(fig, filename_png, 'Resolution', 300);

    fprintf('Saved: %s\n', filename_png);

    close(fig);
end

fprintf('\nAll slices exported successfully.\n');