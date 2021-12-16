%% K_MODEL_AUTOGENERATOR_ELECTRODE This function automatically creates k_model_electrode from k_model_calculator.

function k_model_autoGenerator_electrode(modelName_core,selectiveParameters)
%% Explanations of input & output arguments:
    % modelName_core: e.g. 'parallelModel'.
    % selectiveParameters: e.g. {'alpha';'f'}, which are behind thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity.
    
%% Creation of the k_model m-file
    % open  a file and assign it to variable to fid
	eval(['fid = fopen(''k_',modelName_core,'_electrode.m'',''w'');'])
    
    % write to file
    
    % Block 1:  help information
    % e.g.  %% K_EXAMPLEMODEL This model calculates the effective thermal conductivity using names from statistics
    %       % according to exampleModel.
    %
    
    % create a string for block 1
    str = ['%%%% K_',upper(modelName_core),'_ELECTRODE This model calculates the effective thermal conductivity using electrode information from table electrode\n'];
    strlength_str = strlength(str);
    str = insertAfter(str,strlength_str,['%% according to ',modelName_core,'.\n\n']);
    % write to file and delete str
    fprintf(fid,str);
    clear str strlength_str
    
    % Block 2:
    % e.g.  function keff = k_exampleModel(namesMatrix,volumeFractionsMatrix,nameFiller,porosity,otherParameter1,otherParameter2,otherParameter3)
    
    % find the number of elements in selectiveParameters
    n_selectiveParameters = size(selectiveParameters,1);
    % create the whole string for block 2
    str = ['function keff = k_',modelName_core,'_electrode(nameElectrode,nameFiller'];
    strlength_str = strlength(str);
    for ii = 1 : n_selectiveParameters
        str = insertAfter(str,strlength_str,[',',selectiveParameters{ii,1}]);
        strlength_str = strlength(str);
    end
    clear ii
    str = insertAfter(str,strlength_str,')\n');
    % write to file and delete str
    fprintf(fid,str);
    clear str strlength_str
    
    % Block 3
    % e.g.  %% Explanations of input & output arguments:
    %           % nameElectrode:   e.g. 'graphiteAnodeParallel': electrode name from table electrode. 
    %           % nameFiller: e.g. 'LP30': one line table cell from statistics. 
    %
    
    % create a string for block 3
    str = '%%%% Explations of input & output arguments:\n\n';
    strlength_str = strlength(str);
    str = insertAfter(str,strlength_str,['\t','%% nameElectrode: e.g. ''graphiteAnodeParallel'': electrode name from table electrode.\n']);
    strlength_str = strlength(str);
    str = insertAfter(str,strlength_str,['\t','%% nameFiller: e.g. ''LP30'': one line table cell from statistics.\n']);
    
    for jj = 1 : n_selectiveParameters
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,['\t','%% ',selectiveParameters{jj,1},':\n']);
    end
    clear jj
    strlength_str = strlength(str);
    str = insertAfter(str,strlength_str,'\n');
    
    % write to file and delete str
    fprintf(fid,str);
    clear str strlength_str    
    
    % Block 4
    % %% Calculation of the effective thermal conductivity
    
    % create a string for block 4
    str = '%%%% Calculation of the effective thermal conductivity\n\n';
    
    % write to file and delete str
    fprintf(fid,str);
    clear str strlength_str
    
    % Block 5
    % e.g.  modeNamesParameters ='exampleModel';
    %
    
    % create a string for block 5
    str = ['\t','modelNamesParameters =''',modelName_core,''';\n\n'];
    % write to file and delete str
    fprintf(fid,str);
    clear str strlength_str

    
    % Block 6
	%   e.g.    strlength_modelNamesParameters = strlength(modelNamesParameters);
	%           modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[',',getVarName(otherParameter1),'=']);
	%           if ischar(otherParameter1)
	%               strlength_modelNamesParameters = strlength(modelNamesParameters);
	%               modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,['''''',otherParameter1,'''''']);
	%           elseif isnumeric(otherParameter1)
	%               strlength_modelNamesParameters = strlength(modelNamesParameters);
	%               modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,num2str(otherParameter1));
	%           end
    %

    
    % create a string for block 6
    str = blanks(0);
    str = insertAfter(str,0,['\t','%% to find a whole string for the model name plus selective parameters with their values\n']);
    for hh = 1 : n_selectiveParameters
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,['\t','strlength_modelNamesParameters = strlength(modelNamesParameters);\n']);
        
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,...
                    ['\t','modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[']);
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,...
                    [''',''',',getVarName(',selectiveParameters{hh,1},'),''='']);\n']);
        
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,['\t','if ischar(',selectiveParameters{hh,1},')\n']);
        
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,['\t','\t','strlength_modelNamesParameters = strlength(modelNamesParameters);\n']);
        
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,...
                    ['\t','\t','modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[']);
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,...
                    ['''','''','''','''',',',selectiveParameters{hh,1},',','''','''','''','''',']);\n']);

                
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,['\t','elseif isnumeric(',selectiveParameters{hh,1},')\n']);
        
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,['\t','\t','strlength_modelNamesParameters = strlength(modelNamesParameters);\n']);
        
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,...
                    ['\t','\t','modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,']);
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,'''['');\n');
                
        
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,['\t','\t','for ii = 1 : size(',selectiveParameters{hh,1},',1)\n']);
        
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,['\t','\t','\t','strlength_modelNamesParameters = strlength(modelNamesParameters);\n']);
        
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,...
                    ['\t','\t','\t','modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,']);
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,...
                    ['[num2str(',selectiveParameters{hh,1},'(ii,1)),'';'']);\n']);
                
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,['\t','\t','end\n']);
        
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,['\t','\t','clear ii\n']);
        
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,['\t','\t','strlength_modelNamesParameters = strlength(modelNamesParameters);\n']);
        
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,...
                    ['\t','\t','modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,']);
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,''']'');\n');
        
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,['\t','end\n\n']);
    end
    clear hh
 
    % write to file and delete str
    fprintf(fid,str);
    clear str strlength_str
    
    % Block 6
    % e.g. keff = k_model_out_of_name(namesMatrix,volumeFractionsMatrix,nameFiller,porosity,modelNamesParameters);
    
    % create a string for block 7
    str = blanks(0);
    str = insertAfter(str,0,['\t','%% to calculate the effective thermal conductivity\n']);
    strlength_str = strlength(str);
    str = insertAfter(str,strlength_str,['\t','keff = k_model_out_of_name_electrode(nameElectrode,nameFiller,modelNamesParameters);']);
    % write to file and delete str
    fprintf(fid,str);
    clear str strlength_str
    
    eval('sta = fclose(fid);')