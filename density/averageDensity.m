%% AVERAGEDENSITY This function generates a function handle, which calculates the average density
% out of the model name and material names.

function avgRho = averageDensity(namesMatrix,volumeFractionsMatrix,nameFiller,porosity)
%% Explanations of input & output arguments:

    % namesMatrix: e.g. {'PVDF';'carbonBlack'} or {'PVDF'}: n_matrix * 1 numeric array of thermal conductivities
    % volumeFractionsMatrix:   e.g. [0.5] or []: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one can be omitted.
    % nameFiller: e.g. 'none' or 'carbonBlack': char array.
    % porosity: e.g. 0 or 0.5: numeric variable.
    
%% To import densities from table statistics

    [densities_matrix,density_filler] =...
        values_out_of_name(namesMatrix,nameFiller,porosity,'density');
%% calculate the thermal conductivity

    % calculate the average density using the corresponding calculator
    avgRho = averageDensity_calculator(densities_matrix,volumeFractionsMatrix,density_filler,porosity);