%% K_KRISCHERMODEL_CALCULATOR This function calculates the effective thermal conductivities of n materials with their volume fractions,
% which is organized with krischer model.

function keff = k_krischerModel_calculator(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity,a) 
%% Explanations of input & output arguments:

    % thermalConductivitiesMatrix: e.g. [180;0.1874;2.5]: n_matrix * 1 numeric array of thermal conductivities
    % volumeFractionsMatrix:   e.g. [0.9;0.05]: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one can be omitted.
    % thermalConductivityFiller: e.g. 0.026: numeric variable.
    % porosity: e.g. 0.5: numeric variable.
    % a: e.g. 0.5: numeric variable, scaling factor for series part.

%% calculate the thermal conductivity
    
    % create a 1 * 2 numeric array which contains thermal conductivities using series and parallel models separately
    k_vector = [k_model_out_of_name_calculator(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity,'seriesModel') ;... % series part : a
        k_model_out_of_name_calculator(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity,'parallelModel')];   % parallel part : 1 - a
    
    % calculate the effective thermal conductivity by combining above mentioned 2 parts in series using scaling factor a
    if a == 1
        keff = k_vector(1,1);
    elseif a == 0
        keff = k_vector(2,1);
    else
        keff = 1 / sum([a;1-a] ./ k_vector);
    end