%% THERMALCONDUCTIVITIES_VOLUMEFRACTIONS This function concatenates thermalConductivitiesMatrix, voluemFractionsMatrix, thermalConductivityFiller and porosity
% to thermalConductivities and volumeFractions, where filler does not need
% to be distinguished from matrix materials.

function [thermalConductivities,volumeFractions] = thermalConductivities_volumeFractions(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity)
%% Explanations of input & output arguments:

    % thermalConductivitiesMatrix: e.g. [0.2;24] or 0.2: n_matrix * 1 numeric array of thermal conductivities
    % volumeFractionsMatrix:   e.g. [0.5] or []: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one can be omitted.
    % thermalConductivityFiller: e.g. 'none' or 24: numeric variable.
    % porosity: e.g. 0 or 0.5: numeric variable.    
    
%% To concatenate the input argument

    [thermalConductivities,volumeFractions] = values_xFractions(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity);
