%% AVERAGEDENSITY_CALCULATOR This function calculates the average density.

function avgRho = averageDensity_calculator(densitiesMatrix,volumeFractionsMatrix,densityFiller,porosity)
%% Explanations of input & output arguments:
    % densitiesMatrix: e.g. [2.26;2.26;1.2]: n_densitiesMatrix * 1 double array.
    % volumeFractionsMatrix:    e.g. [0.9;0.05]: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one can be omitted.
    % densityFiller: e.g. 1.2: numeric variable.
    % porosity: e.g. 0.5: numeric variable.
    
%% Calculation of average density

    % concatenate densities and volume fractions
    [densities,volumeFractions] = densities_volumeFractions(...
                densitiesMatrix,volumeFractionsMatrix,densityFiller,porosity);
            
    % calculate the average density
    avgRho = sum(densities .* volumeFractions);