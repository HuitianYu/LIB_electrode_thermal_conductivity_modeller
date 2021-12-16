%% K_ZSM_1 This function calculates the effective thermal conductivity of active material, conductive additve, binder filled with filler
% using names out of table statistics.
% part 1: only filler (up-part & down-part), part 2: active material (up-part) + extra additive (conductive additive, down part)
% part 3:   point contact Zehner-Schlunder model with activematerial, additive and filler as up-part;
%           with extra additive and filler correspondently in down-part.
% upper-part: 1 - c, down-part: c.
% neck part of additive in upper part of part 3: 1 - e, side part of additive: e.

function keff = k_ZSM_1(namesMatrix,volumeFractionsMatrix,nameFiller,porosity,curveName,modelAdditiveName,modeTortuosity,a,c,e,g)
%% Explanations of input & output arguments:

    % namesMatrix: e.g. {'graphiteParallel';'carbonBlack';'PVDF'}: 3 * 1 cell array of names for active material, conductive additive andbinder respectively.
    % volumeFractionsMatrix: e.g. [0.9;0.05]: 2 * 1 numeric array for active material and conductive additive respectively.
    %                       The sum should not exceed 1. The last one for binder can be omitted.
    % nameFiller: e.g. 'air': char array of name for filling fluid.
    % porosity: e.g. 0.2657, numeric variable, the volume fraction of fluid.
    % curveName: e.g. 'curveRAreaContact': char array, the name of a function handle with variables (r,B,alpha).
    % modelAdditiveName:     e.g. 'parallelModel','EMTN','EMTN,f=6','krischerModel,a=0.5','LNM,kE=2.5,phiM=0.637','MEM1,f=3': char array, which contains the following input parameters:
    %                   whose corresponding k_model_calculator contains the following input arguments:
    %                   (thermalconductivities,volumeFractions,n).
    % modeTortuosity: e.g. 1, numeric varible. The mode is from 1 to 3.
    % a: e.g. 0, numeric variable, the volume fraction of active material in part 2 in active material. a is in range of [0,1].
    % c: e.g. 0.002, numeric variable, the volume ratio of down-part in range of [0,1].
    % e: e.g. 0.1: numeric variable in range of [0,1].\
    % g: e.g. 0.2: numeric variable. ratio of inner porosity to additive volume.    
    % keff: effecitive thermal conductivity: numeric variable > 0.
    
%% Calculation of effective thermal conductivity
    
    % calculate the effective thermal conductivity
    if ischar(c)
        keff = k_model_out_of_name( namesMatrix,volumeFractionsMatrix,nameFiller,porosity,...
                                    ['ZSM_1,curveName=''',curveName,''',modelAdditiveName=''',modelAdditiveName,...
                                    ''',modeTortuosity=',num2str(modeTortuosity),',a=',num2str(a),',c=''',c,'''',',e=',num2str(e),',g=',num2str(g)]);
    elseif isnumeric(c)
        keff = k_model_out_of_name( namesMatrix,volumeFractionsMatrix,nameFiller,porosity,...
                                    ['ZSM_1,curveName=''',curveName,''',modelAdditiveName=''',modelAdditiveName,...
                                    ''',modeTortuosity=',num2str(modeTortuosity),',a=',num2str(a),',c=',num2str(c),',e=',num2str(e),',g=',num2str(g)]);
    end