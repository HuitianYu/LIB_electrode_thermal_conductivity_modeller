%% DENSITIES_VOLUMEFRACTIONS This function concatenates densitiesMatrix, voluemFractionsMatrix, densitiyFiller and porosity
% to densities and volumeFractions, where filler does not need
% to be distinguished from matrix materials.

function [densities,volumeFractions] = densities_volumeFractions(densitiesMatrix,volumeFractionsMatrix,densityFiller,porosity)
%% Explanations of input & output arguments:

    % densitiesMatrix: e.g. [2.26;1.2] or 2.26: n_matrix * 1 numeric array of thermal conductivities
    % volumeFractionsMatrix:   e.g. [0.5] or []: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one can be omitted.
    % thermalConductivityFiller: e.g. 'none' or 1.2: numeric variable.
    % porosity: e.g. 0 or 0.5: numeric variable.    
    
%% To concatenate the input argument
    
    [densities,volumeFractions] = values_xFractions(densitiesMatrix,volumeFractionsMatrix,densityFiller,porosity);

    