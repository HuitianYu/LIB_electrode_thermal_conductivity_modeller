%% K_MODEL_OUT_OF_NAME_CALCULATOR This function generates a function handle, which calculates the thermal conductivity
% out of the model name.

function keff = k_model_out_of_name_calculator(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity,modelName)
%% Explanations of input & output arguments:

    % thermalConductivitiesMatrix: e.g. [0.2;24] or 0.2: n_matrix * 1 numeric array of thermal conductivities
    % volumeFractionsMatrix:   e.g. [0.5] or []: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one must be omitted.
    % thermalConductivityFiller: e.g. 'none' or 24: numeric variable.
    % porosity: e.g. 0 or 0.5: numeric variable.
    % modelName:    e.g. 'parallelModel','EMTN,f=6','krischerModel,a=0.5',
    %               'LNM,kE=2.5,phiM=0.637','MEM_1,f=3',
    %               'bruggemanModel,alpha = 0,f=0','percolationModel,kc=0.44,vc=0.15,nExp=0.51','sphereDisperseModel',
    %               'RNM_1,modeTortuosity=1,a=0','RNM_2,modeTortuosity=1,a=0',
    %               'ZSM_1,curveName=''curveRAreaContact'',modelAddName=''percolationModel,kc=0.3,vc=0.15,nExp=0.51'',modeTortuosity=1,a=0',
    %               'ZSM_2,curveName=''curveRAreaContact'',modelAddName=''percolationModel,kc=0.3,vc=0.15,nExp=0.51'',modeTortuosity=1,alpha=0'£¬
    %               'ZSM_3,curveName=''curveRAreaContact'',modelAddName=''percolationModel,kc=0.3,vc=0.15,nExp=0.51'',modeTortuosity=1,a=0,c=''automatic'',e=0',
    %               'ZSM_4,curveName=''curveRAreaContact'',modelAddName=''percolationModel,kc=0.3,vc=0.15,nExp=0.51'',modeTortuosity=1,alpha=0,c=''automatic'',e=0':
    %               char array, which contains the following input parameters:
    %               whose corresponding k_model_calculator contains the following input arguments:
    %               (thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity).
    
%% To generate a function handle and calculate the effective thermal conductivity

    % to find the postion of useful comma and equation symbol, which is not surrounded by a pair of apostrophe.
    
    % to remove spaces in between
    positionsSpace = strfind(modelName,' ');
    modelName(positionsSpace) = [];
    
    positionsComma = strfind(modelName,',');
    positionsEquation = strfind(modelName,'=');

    
    positionsApostrophe =strfind(modelName,'''');
    
    logicalComma = true(1,size(positionsComma,2));
    logicalEquation = true(1,size(positionsEquation,2));

    % to remove unfunctional comma, which does not seperate two inputs.
    for ii = 1:size(positionsApostrophe,2)/2
       for jj = 1:size(positionsComma,2)
           if positionsComma(1,jj) > positionsApostrophe(1,2 * ii - 1) && positionsComma(1,jj) < positionsApostrophe(1,2 * ii)
                logicalComma(1,jj) = false;
           end
       end
       for jj = 1:size(positionsEquation,2)
           if positionsEquation(1,jj) > positionsApostrophe(1,2 * ii - 1) && positionsEquation(1,jj) < positionsApostrophe(1,2 * ii)
                logicalEquation(1,jj) = false;
           end
       end
    end

    positionsComma = positionsComma(logicalComma);
    positionsEquation = positionsEquation(logicalEquation);

    % to find the string length of core part of model name, e.g. 'parallelModel'

    if any(logicalComma)
       modelName_core = modelName(1:positionsComma(1,1)-1);
    else
        modelName_core = modelName;
    end
    % to create a string for evaluation function
    strEval = strcat(   'k_model_calculator = @(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity)k_',...
                        modelName_core,...
                        '_calculator(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity');
    for hh = 1:size(positionsComma,2)
        if hh <= size(positionsComma,2) - 1
            strEval = strcat(strEval,',',modelName(positionsEquation(1,hh) + 1 : positionsComma(1,hh + 1) - 1));
        elseif hh == size(positionsComma,2)
            strEval = strcat(strEval,',',modelName(positionsEquation(1,hh) + 1 : strlength(modelName)));
        end
    end
    strEval = strcat(strEval,');');
    eval(strEval);


    % calculate the effective thermal conductivity
    keff = k_model_calculator(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity);
            