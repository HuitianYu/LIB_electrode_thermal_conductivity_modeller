%% K_LNM_CALCULATOR This function calculates the effective thermal conductivities of 2 materials with their volume fractions,
% which is organized with Lewis-Nielsen model, using names
% 1: continuous phase (matrix), 2: disperse phase (filler).
% A = 2, phiM = 1, this model reduces to Maxwell-Euken model.

function keff = k_LNM_calculator(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity,kE,phiM)
%% Explanations of input & output arguments:

    % thermalConductivitiesMatrix: e.g. [0.2;24] or 0.2: n_matrix * 1 numeric array of thermal conductivities
    % volumeFractionsMatrix:   e.g. [0.5] or []: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one can be omitted.
    % thermalConductivityFiller: e.g. 'none' or 24: numeric variable.
    % porosity: e.g. 0 or 0.5: numeric variable.
    % kE:   e.g. 2.5 (for rigid spheres suspended in a matrix with Poisson ratio of 0.5):
    %       numeric variable: Einstein coefficient.
    % phiM: 0.637 (for random close packing of spheres): numeric variable:
    %       maximum packing volume fraction of particles, which ranges 
    %       from 0.32 to 1.0.

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
    k1 = thermalConductivities(1,1);
    k2 = thermalConductivities(2,1);
    v1 = volumeFractions(1,1);
    
    %  calculate the second volume fraction: phi
    v2 = 1 - v1;

    % calculate A and B:
    A = kE - 1;
    B = (k2 - k1) / (k2 + A * k1);
    
    % calculate psi:
    psi = 1 + v2 * (1 - phiM) / phiM^2;
    
    % calculate the effective thermal conductivity:
    keff = (1 + A * B * v2) / (1 - B * psi * v2) * k1;