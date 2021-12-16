%% K_MODEL_OUT_OF_NAME This function generates a function handle, which calculates the thermal conductivity
% out of the model name and material names.

function keff = k_model_out_of_name(namesMatrix,volumeFractionsMatrix,nameFiller,porosity,modelName)
%% Explanations of input & output arguments:

    % namesMatrix: e.g. {'PVDF';'carbonBlack'} or {'PVDF'}: n_matrix * 1 numeric array of thermal conductivities
    % volumeFractionsMatrix:   e.g. [0.5] or []: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one can be omitted.
    % nameFiller: e.g. 'none' or 'carbonBlack': char array.
    % porosity: e.g. 0 or 0.5: numeric variable.
    % modelName:    e.g. 'parallelModel','EMTN,f=6','krischerModel,a=0.5',
    %               'LNM,kE=2.5,phiM=0.637','bruggemanModel,alpha = 0,f=1','MEM_1,f=3',
    %               'percolationModel','percolationModel,kc=0.44,vc=0.15,nExp=0.51','sphereDisperseModel',
    %               'RNM_1,modeTortuosity=1,a=0.1',
    %               'ZSM_1,curveName=''curveRAreaContact'',modelAdditiveName=''percolationModel,kc=0.3,vc=0.15,nExp=0.51'',modeTortuosity=1,a=0.002,c=''automatic'',e=0':
    %               char array, which contains the following input parameters:
    %               whose corresponding k_model_calculator contains the following input arguments:
    %               (thermalconductivities,volumeFractions,n).
    
%% To import thermal conductivities from table statistics

    [thermalConductivities_matrix,thermalConductivity_filler] =...
        values_out_of_name(namesMatrix,nameFiller,porosity,'thermalConductivity');
    
%% calculate the thermal conductivity

    % calculate the effective thermal conductivity using the corresponding calculator
    keff = k_model_out_of_name_calculator(...
        thermalConductivities_matrix,volumeFractionsMatrix,thermalConductivity_filler,porosity,modelName);