%% K_ZSM_1_a_polyAM_CALCULATOR This function calculates the effective thermal conductivity of active material (2 kinds), conductive additve, binder filled with filler with the extended 1_a model.
% part 1: only filler (up-part & down-part), part 2: active material (up-part) + extra additive (conductive additive, down part)
% part 3:   point contact Zehner-Schlunder model with activematerial, additive and filler as up-part;
%           with extra additive and filler correspondently in down-part.
% upper-part: 1 - c, down-part: c.
% neck part of additive in upper part of part 3: 1 - e, side part of additive: e.

function keff = k_ZSM_1_a_polyAM_calculator(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity,curveName,modelAdditiveName,modeTortuosity,a,c,e,g,volumeFractionsAM)
%% Explanations of input & output arguments:

    % thermalConductivitiesMatrix: e.g. [6;4;0.1874;2.5]: (n_AM + 2) * 1 numeric array of thermal conductivities for active material 1, active material 2, ... active material n_AM, conductive additive andbinder respectively.
    % volumeFractionsMatrix: e.g. [0.9;0.05]: 2 * 1 numeric array for active material (1 + 2 + ... + n_AM) and conductive additive respectively.
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
    %     or 'automatic': char array.
    % e: e.g. 0.1: numeric variable in range of [0,1].
    % g: e.g. 0.2: numeric variable. ratio of inner porosity to additive volume.
    % volumeFractionsAM: e.g. [0.8;0.2]: n_AM * 1 array, the last one can be omitted.
    % keff: effecitive thermal conductivity: numeric variable > 0.
    
%% Calculation of effective thermal conductivity

    n_AM = size(thermalConductivitiesMatrix,1) - 2;
    thermalConductivities_AM = thermalConductivitiesMatrix(1:n_AM,1);
    keff_PolyAM = zeros(size(n_AM,1),1);
    volumeFractionsAM(n_AM,1) = 1 - sum(volumeFractionsAM(1:n_AM - 1,1),1);
    for ii = 1 : n_AM
        thermalConductivitiesMatrix_temp = [thermalConductivities_AM(ii,1);thermalConductivitiesMatrix(n_AM + 1:size(thermalConductivitiesMatrix,1),1)];
        keff_PolyAM(ii,1) = k_ZSM_1_a_calculator(thermalConductivitiesMatrix_temp,volumeFractionsMatrix,thermalConductivityFiller,porosity,curveName,modelAdditiveName,modeTortuosity,a,c,e,g);
    end
    clear ii
    
    keff_temp = 0;
    for ii = 1 : n_AM
        for jj = 1 : n_AM
            keff_temp = keff_temp + volumeFractionsAM(ii,1) * volumeFractionsAM(jj,1) * k_seriesModel_calculator([keff_PolyAM(ii,1);keff_PolyAM(jj,1)],[volumeFractionsAM(ii,1);volumeFractionsAM(jj,1)],'none',0);
        end
        clear jj
    end
    clear ii
    keff = keff_temp;
