%% K_ZSM_1_ELECTRODE This function calculates the effective thermal conductivity for one electrode,
% which is organized by ZSM_1.

function keff = k_ZSM_1_electrode(nameElectrode,nameFiller,curveName,modelAdditiveName,modeTortuosity,a,c,e,g) 
%% Explanations of input & output arguments:

    % nameElectrode:   e.g. 'graphiteAnodeParallel': cell array, name for one line table for electrode out of table electrode.
    % nameFiller: e.g. 'air': cell array, name for one line table for filling fluid out of table statistics.
    % curveName: e.g. 'curveRAreaContact': char array, the name of a function handle with variables (r,B,alpha).
    % modelAdditiveName:     e.g. 'parallelModel','EMTN','EMTN,f=6','krischerModel,a=0.5','LNM,kE=2.5,phiM=0.637','MEM1,f=3': char array, which contains the following input parameters:
    %                   whose corresponding k_model_calculator contains the following input arguments:
    %                   (thermalconductivities,volumeFractions,n).
    % modeTortuosity: e.g. 1, numeric varible. The mode is from 1 to 3.
    % a: e.g. 0, numeric variable, the volume fraction of active material in part 2 in active material. a is in range of [0,1].
    % c: e.g. 0.002, numeric variable, the volume ratio of down-part in range of [0,1].
    % e: e.g. 0.1: numeric variable in range of [0,1].
    % g: e.g. 0.2: numeric variable. ratio of inner porosity to additive volume.    
    % keff: effecitive thermal conductivity: numeric variable > 0.
    
%% calculate the thermal conductivity
  
    % calculate the effective thermal conductivity
    if ischar(c)
        keff = k_model_out_of_name_electrode(   nameElectrode,nameFiller,...
                                                ['ZSM_1,curveName=''',curveName,''',modelAdditiveName=''',modelAdditiveName,...
                                                ''',modeTortuosity=',num2str(modeTortuosity),',a=',num2str(a),',c=''',c,'''',',e=',num2str(e),',g=',num2str(g)]);
    elseif isnumeric(c)
        keff = k_model_out_of_name_electrode(   nameElectrode,nameFiller,...
                                                ['ZSM_1,curveName=''',curveName,''',modelAdditiveName=''',modelAdditiveName,...
                                                ''',modeTortuosity=',num2str(modeTortuosity),',a=',num2str(a),',c=',num2str(c),',e=',num2str(e),',g=',num2str(g)]);
    end
    
    