%% AVERAGEHEATCAPACITY_CALCULATOR This function calculates the average heat capacity.

function avgCp = averageHeatCapacity_calculator(heatCapacitiesMatrix,massFractionsMatrix,heatCapacityFiller,massFractionFiller)
%% Explanations of input & output arguments:
    % heatCapacitiesMatrix: e.g. [0.7;1.65;1.19]: n_densitiesMatrix * 1 double array.
    % massFractionsMatrix:    e.g. [0.9;0.05]: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one can be omitted.
    % heatCapacityFiller: e.g. 1.19: numeric variable.
    % massFractionFiller: e.g. 0.5: numeric variable.
    
%% Calculation of average heat capacity

    % concatenate densities and volume fractions
    [heatCapacities,massFractions] = heatCapacities_massFractions(...
                heatCapacitiesMatrix,massFractionsMatrix,heatCapacityFiller,massFractionFiller);
            
            
    % calculate the average heat capacity
    avgCp = sum(heatCapacities .* massFractions);