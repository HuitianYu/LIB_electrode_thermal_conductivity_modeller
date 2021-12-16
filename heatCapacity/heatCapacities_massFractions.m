%% HEATCAPACITIES_MASSFRACTIONS This function concatenates heatCapacitiesMatrix, massFractionsMatrix, heatCapacityFiller and massFractionFiller
% to heatCapacities and volumeFractions, where filler does not need
% to be distinguished from matrix materials.

function [heatCapacities,massFractions] = heatCapacities_massFractions(heatCapacitiesMatrix,massFractionsMatrix,heatCapacityFiller,massPorosity)
%% Explanations of input & output arguments:

    % heatCapacitiesMatrix: e.g. [0.7;1.19] or 0.7: n_matrix * 1 numeric array of thermal conductivities
    % massFractionsMatrix:   e.g. [0.5] or []: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one can be omitted.
    % heatCapacityFiller: e.g. 'none' or 1.19: numeric variable.
    % massPorosity: e.g. 0 or 0.5: numeric variable.    
    
%% To concatenate the input argument

    [heatCapacities,massFractions] = values_xFractions(...
        heatCapacitiesMatrix,massFractionsMatrix,heatCapacityFiller,massPorosity);
    