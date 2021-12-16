%% K_MODEL_OUT_OF_NAME_ELECTRODE This function calculates the effective thermal conductivity for one electrode,
% out of the model name, electrode names and filler name.

function keff = k_model_out_of_name_electrode(nameElectrode,nameFiller,modelName) 
%% Explanations of input & output arguments:

    % nameElectrode:   e.g. 'graphiteAnodeParallel': electrode name from table electrode. 
    % nameFiller: e.g. 'LP30': one line table cell from statistics. 
    % modelName:    e.g. 'parallelModel','EMTN,f=6','krischerModel,a=0.5',
    %               'RNM_1,modeTortuosity=1,a=0.1',
    %               'ZSM_3,curveName=''curveRAreaContact'',modelAdditiveName=''percolationModel,kc=0.3,vc=0.15,nExp=0.51'',modeTortuosity=1,a=0.002,c=''automatic'',e=0':
    %               char array, which contains the following input parameters:
    %               whose corresponding k_model_calculator contains the following input arguments:
    %               (thermalconductivities,volumeFractions,n).
    % keff: numeric variable: effective thermal conductivity.
    
%% calculate the thermal conductivity

    [names_matrix,volumeFractions_matrix,porosity] =...
        names_fractionsMatrix_xPorosity_out_of_electrode(...
        nameElectrode,nameFiller,0);

    % calculate the effective thermal conductivity
    keff = k_model_out_of_name(...
        names_matrix,volumeFractions_matrix,nameFiller,porosity,modelName);
