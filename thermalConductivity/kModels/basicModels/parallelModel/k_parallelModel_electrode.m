%% K_SERIESMODELELECTRODE This function calculates the effective thermal conductivity for one electrode,
% which is organized in parallel.

function keff = k_parallelModel_electrode(nameElectrode,nameFiller)
%% Explanations of input & output arguments:

    % nameElectrode:   e.g. 'graphiteAnodeParallel': electrode name from table electrode. 
    % nameFiller: e.g. 'LP30': one line table cell from statistics. 

%% calculate the thermal conductivity
   
    % calculate the effective thermal conductivity
    keff = k_model_out_of_name_electrode(   nameElectrode,nameFiller,...
                                            'parallelModel') ;