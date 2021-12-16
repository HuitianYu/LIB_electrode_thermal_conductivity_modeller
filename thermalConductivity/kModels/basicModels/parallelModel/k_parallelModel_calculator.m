%% K_PARALLELMODEL_CALCULATOR This function calculates the effective thermal conductivities of n materials with their volume fractions,
% which is organized in parallel.

function keff = k_parallelModel_calculator(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity) 
%% Explanations of input & output arguments:

    % thermalConductivitiesMatrix: e.g. [180;0.1874;2.5]: n_matrix * 1 numeric array of thermal conductivities
    % volumeFractionsMatrix:   e.g. [0.9;0.05]: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one can be omitted.
    % thermalConductivityFiller: e.g. 0.026: numeric variable.
    % porosity: e.g. 0.5: numeric variable.
    
%% calculate the thermal conductivity

    % concatenate thermal conductivities and volume fractions
    [thermalConductivities,volumeFractions] = thermalConductivities_volumeFractions(...
                thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity);
    
    % calculate the effective thermal conductivity
    keff =	sum(volumeFractions .* thermalConductivities);