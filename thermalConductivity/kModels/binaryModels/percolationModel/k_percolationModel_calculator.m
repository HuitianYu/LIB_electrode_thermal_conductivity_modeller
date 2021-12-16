%% K_PERCOLATIONMODEL_CALCULATOR This function calculates the effective thermal conductivities of n materials with their volume fractions,
% which is organized with percolation model.
% 1: continuous phase (matrix), 2: disperse phase (filler).

function keff = k_percolationModel_calculator(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity,kc,vc,nExp)
%% Explanations of input & output arguments:

    % thermalConductivitiesMatrix: e.g. [0.2;24] or 0.2: n_matrix * 1 numeric array of thermal conductivities
    % volumeFractionsMatrix:   e.g. [0.5] or []: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one can be omitted.
    % thermalConductivityFiller: e.g. 'none' or 24: numeric variable.
    % porosity: e.g. 0 or 0.5: numeric variable.
    % kc: e.g. 0.44: numeric variable: effective thermal conductivity, wenn v2 = vc.
    % vc: e.g. 0.15: numeric variable: percolation threshold in range of [0.15,0.2].
    % nExp: e.g. 0.51: numeric variable: percolation exponent in range of [0.3,0.8].


%% calculate the thermal conductivity

    % concatenate thermal conductivities and volume fractions
    [thermalConductivities,volumeFractions] = thermalConductivities_volumeFractions(...
                thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity);
    
    % check whether n_materials is 2
    n_materials = size(thermalConductivities,1);
    if n_materials ~= 2
        error(  ['n_materials should be 2.',...
                ' Either one value in thermalConductivitiesMatrix ',...
                'and one in thermalConductivityFiller or 2 values in thermalConductivitiesMatrix ',...
                'and ''none'' in thermalConductivityFiller.'])
    end
    
    % simplify the variable names 
    k2 = thermalConductivities(2,1);
    v1 = volumeFractions(1,1);
    
    %  calculate the second volume fraction
    v2 = 1 - v1;
    
    % calculate the effective thermal conductivity
    keff = k2 * (kc / k2) ^(((1-v2)/(1-vc))^nExp);
    
    
    