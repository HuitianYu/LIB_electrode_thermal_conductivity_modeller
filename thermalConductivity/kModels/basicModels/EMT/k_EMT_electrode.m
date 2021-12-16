%% K_EMT_ELECTRODE This function calculates the effective thermal conductivity for one electrode,
% which is organized with Effective Medium Theory Model.

function keff = k_EMT_electrode(nameElectrode,nameFiller,f) 
%% Explanations of input & output arguments:

    % nameElectrode:   e.g. 'graphiteAnodeParallel': electrode name from table electrode. 
    % nameFiller: e.g. 'LP30': one line table cell from statistics. 
    % f: e.g. 6: numeric variable, factor. It usually equals 6.

%% calculate the thermal conductivity

    % calculate the effective thermal conductivity
    keff = k_model_out_of_name_electrode(   nameElectrode,nameFiller,...
                                            ['EMT,f=',num2str(f)]) ;