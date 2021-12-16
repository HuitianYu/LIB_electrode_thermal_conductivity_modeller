%% K_BRUGGEMANMODEL_CALCULATOR This function calculates the effective thermal conductivities of n materials with their volume fractions,
% which is organized with Bruggeman model.
% 1: continuous phase (matrix), 2: disperse phase (filler).

function keff = k_bruggemanModel_calculator(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity,alpha,f)
%% Explanations of input & output arguments:

    % thermalConductivitiesMatrix: e.g. [0.2;24] or 0.2: n_matrix * 1 numeric array of thermal conductivities
    % volumeFractionsMatrix:   e.g. [0.5] or []: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one can be omitted.
    % thermalConductivityFiller: e.g. 'none' or 24: numeric variable.
    % porosity: e.g. 0 or 0.5: numeric variable.
    % alpha: e.g. 0 (thermal Resistance not considered): numeric variable
    % f : e.g. 1.08 (usually 1): numeric variable, an effect factor.

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
    
    %  calculate the second volume fraction
    v2 = 1 - v1;
    
    % create a function handle for the Bruggeman model
    FuncBruggemanModel = @(keff_Iter) (k2 * (1 - alpha) - keff_Iter) / (k2 * (1 - alpha) - k1) * (f * k1 / keff_Iter)^((1 + 2 * alpha)/3) - v1^(1 - alpha);
    
    % set options and solve the zero point (k_e) with fsolve
    options = optimoptions('fsolve','Display','none','TolFun',1e-6);
    keff = fsolve(FuncBruggemanModel,sum([v1;v2] .* [k1;k2]),options);