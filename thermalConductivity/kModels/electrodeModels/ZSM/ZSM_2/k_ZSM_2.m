%% K_ZSM_2 This function calculates the effective thermal conductivity of active material, conductive additve, binder filled with fluid
% using names out of table statistics.
% part 1: only fluid (up-part & down-part),
% part 2:   area contact Zehner-Schlunder model with activematerial, additive and fluid as up-part;
%           with extra additive and fluid correspondently in down-part.
% upper-part: 1 - c, down-part: c.
% neck part of additive in upper part of part 3: 1 - e, side part of additive: e.
% neck part of additive in upper part of part 3: 1 - e, side part of additive: e.

function keff = k_ZSM_2(namesMatrix,volumeFractionsMatrix,nameFiller,porosity,curveName,modelAdditiveName,modeTortuosity,alpha,c,e,g)
%% Explanations of input & output arguments:

    % namesMatrix: e.g. {'graphiteParallel';'carbonBlack';'PVDF'}: 3 * 1 cell array of names for active material, conductive additive andbinder respectively.
    % volumeFractionsMatrix: e.g. [0.9;0.05]: 2 * 1 numeric array for active material and conductive additive respectively.
    %                       The sum should not exceed 1. The last one for binder must be omitted.
    % nameFiller: e.g. 'air': char array of name for filling fluid.
    % porosity: e.g. 0.2657, numeric variable, the volume fraction of fluid.
    % curveName: e.g. 'curveRAreaContact': char array, the name of a function handle with variables (r,B,alpha).
    % modelAdditiveName:     e.g. 'parallelModel','EMTN','EMTN,f=6','krischerModel,a=0.5','LNM,kE=2.5,phiM=0.637','MEM1,f=3': char array, which contains the following input parameters:
    %                   whose corresponding k_model_calculator contains the following input arguments:
    %                   (thermalconductivities,volumeFractions,n).
    % modeTortuosity: e.g. 1, numeric varible. The mode is from 1 to 3.
    % alpha: e.g. 0, numeric variable, the contact area factor. 0 is point contact.
    % c: e.g. 0.002, numeric variable, the volume ratio of down-part in range of [0,1].
    % e: e.g. 0.1: numeric variable in range of [0,1].   
    % g: e.g. 0.2: numeric variable. ratio of inner porosity to additive volume.
    % keff: effecitive thermal conductivity: numeric variable > 0.
    
%% Calculation of effective thermal conductivity
    
    % calculate the effective thermal conductivity
    if ischar(c)
        keff = k_model_out_of_name( namesMatrix,volumeFractionsMatrix,nameFiller,porosity,...
                                    ['ZSM_2,curveName=''',curveName,''',modelAdditiveName=''',modelAdditiveName,...
                                    ''',modeTortuosity=',num2str(modeTortuosity),',alpha=',num2str(alpha),',c=''',c,'''',',e=',num2str(e),',g=',num2str(g)]);
    elseif isnumeric(c)
        keff = k_model_out_of_name( namesMatrix,volumeFractionsMatrix,nameFiller,porosity,...
                                    ['ZSM_2,curveName=''',curveName,''',modelAdditiveName=''',modelAdditiveName,...
                                    ''',modeTortuosity=',num2str(modeTortuosity),',alpha=',num2str(alpha),',c=',num2str(c),',e=',num2str(e),',g=',num2str(g)]);
    end    