%% K_EMT_CALCULATOR This function calculates the effective thermal conductivities of n materials with their volume fractions,
% which is organized with Effective Medium Theory Model.

function keff = k_EMT_calculator(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity,f) 
%% Explanations of input & output arguments:

    % thermalConductivitiesMatrix: e.g. [180;0.1874;2.5]: n_matrix * 1 numeric array of thermal conductivities
    % volumeFractionsMatrix:   e.g. [0.9;0.05]: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one can be omitted.
    % thermalConductivityFiller: e.g. 0.026: numeric variable.
    % porosity: e.g. 0.5: numeric variable.
    % f: e.g. 6: numeric variable, factor. It usually equals 6.
    
%% calculate the thermal conductivity

    % concatenate thermal conductivities and volume fractions
    [thermalConductivities,volumeFractions] = thermalConductivities_volumeFractions(...
                thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity);
    
    
    % create a function handle for EMT model with variable k_e
    FuncEMTN = @(k_e) sum(volumeFractions .* ( (thermalConductivities - k_e) ./ (thermalConductivities + ( f/2 - 1 ) * k_e) ));
   
    % set options and solve the zero point (k_e) with fsolve
    options = optimoptions('fsolve','Display','none','TolFun',1e-6);
    keff = fsolve(FuncEMTN,sum(volumeFractions.^(6 + abs((f-6))^3) .* thermalConductivities),options); % initial value can be adjusted