%% K_KRISCHERMODEL_ELECTRODE This function calculates the effective thermal conductivity for one electrode,
% which is organized with krischer model.

function keff = k_krischerModel_electrode(nameElectrode,nameFiller,a) 
%% Explanations of input & output arguments:

    % nameElectrode:   e.g. 'graphiteAnodeParallel': electrode name from table electrode. 
    % nameFiller: e.g. 'LP30': one line table cell from statistics. 
    % a: e.g. 0.5: numeric variable, scaling factor for series part.
 
%% calculate the thermal conductivity
    
    % calculate the effective thermal conductivity
    keff = k_model_out_of_name_electrode(   nameElectrode,nameFiller,...
                                            ['krischerModel,a=',num2str(a)]) ;