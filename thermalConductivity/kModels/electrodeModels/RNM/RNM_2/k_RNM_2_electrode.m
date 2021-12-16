%% K_RNM_2_ELECTRODE This function calculates the effective thermal conductivity for one electrode,
% which is organized by RNM 2.

function keff = k_RNM_2_electrode(nameElectrode,nameFiller,modeTortuosity,a) 
%% Explanations of input & output arguments:

    % nameElectrode:   e.g. 'graphiteAnodeParallel': cell array, name for one line table for electrode out of table electrode.
    % nameFiller: e.g. 'air': cell array, name for one line table for filling fluid out of table statistics.
    % modeTortuosity: e.g. 1, numeric varible. The mode is from 1 to 3.
    % a: e.g. 0, numeric variable, the volume fraction of active material in part 2 in active material. a is in range of [0,1].
    
%% calculate the thermal conductivity
 
    % calculate the effective thermal conductivity
    keff = k_model_out_of_name_electrode(   nameElectrode,nameFiller,...
                                            ['RNM_2,modeTortuosity=',num2str(modeTortuosity),',a=',num2str(a)]);

    
    