%% K_ZSM_5_ADDINFILLER_CALCULATOR This function calculates the effective thermal conductivity of active material, conductive additve, binder filled with filler.
% part 1: only filler (up-part & down-part), part 2: active material (up-part) + additive (conductive additive + binder) dispersion in filler (fluid)
% part 3:   up-part: point contact Zehner-Schlunder model with activematerial,
%                   + additive dispersion in filler
%           down-part: additive dispersion
% upper-part: 1 - c, down-part: c.

function keff = k_ZSM_5_addInFiller_calculator(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity,curveName,modelAdditiveName,modeTortuosity,a,c,modelAddInFiller)
%% Explanations of input & output arguments:

    % thermalConductivitiesMatrix: e.g. [180;0.1874;2.5]: 3 * 1 numeric array of thermal conductivities for active material, conductive additive andbinder respectively.
    % volumeFractionsMatrix: e.g. [0.9;0.05]: 2 * 1 numeric array for active material and conductive additive respectively.
    %                       The sum should not exceed 1. The last one for binder can be omitted.
    % thermalConductivityFiller: e.g. 0.026: numeric variable.
    % porosity: e.g. 0.2657, numeric variable, the volume fraction of fluid.
    % curveName: e.g. 'curveRAreaContact': char array, the name of a function handle with variables (r,B,alpha).
    % modelAdditiveName:     e.g. 'parallelModel','EMTN','EMTN,f=6','krischerModel,a=0.5','LNM,kE=2.5,phiM=0.637','MEM1,f=3': char array, which contains the following input parameters:
    %                   whose corresponding k_model_calculator contains the following input arguments:
    %                   (thermalconductivities,volumeFractions,n).
    % modeTortuosity: e.g. 1, numeric varible. The mode is from 1 to 3.
    % a: e.g. 0, numeric variable, the volume fraction of active material in part 2 in active material. a is in range of [0,1].
    % c:  e.g. 0.002, numeric variable, the volume ratio of down-part in range of [0,1]. 
    % modelAddInFillerName: e.g. 'EMT,f=6': char array, model for additive system in filler.
    % keff: effecitive thermal conductivity: numeric variable > 0.
    
%% Calculation of effective thermal conductivity

    if ischar(c) && strcmp(c,'automatic')
        error('''Automatic'' is not allowed for this function.\n') 
    elseif isnumeric(c)
        c_res = c;
        [~,keff] = k_ZSM_5_addInFiller_underlying(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity,curveName,modelAdditiveName,modeTortuosity,a,c_res,modelAddInFiller);
    else
        error('Invalid input of c.')
    end
