%% K_ZSM_5_ELECTRODE This model calculates the effective thermal conductivity using electrode information from table electrode
% according to ZSM_5.

function keff = k_ZSM_5_electrode(nameElectrode,nameFiller,curveName,modelAdditiveName,modeTortuosity,a,c)
%% Explanations of input & output arguments:

	% nameElectrode: e.g. 'graphiteAnodeParallel': electrode name from table electrode.
	% nameFiller: e.g. 'LP30': one line table cell from statistics.
	% curveName:
	% modelAdditiveName:
	% modeTortuosity:
	% a:
	% c:

%% Calculation of the effective thermal conductivity

	modelNamesParameters ='ZSM_5';

	% to find a whole string for the model name plus selective parameters with their values
	strlength_modelNamesParameters = strlength(modelNamesParameters);
	modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[',',getVarName(curveName),'=']);
	if ischar(curveName)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,['''',curveName,'''']);
	elseif isnumeric(curveName)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,num2str(curveName));
	end

	strlength_modelNamesParameters = strlength(modelNamesParameters);
	modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[',',getVarName(modelAdditiveName),'=']);
	if ischar(modelAdditiveName)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,['''',modelAdditiveName,'''']);
	elseif isnumeric(modelAdditiveName)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,num2str(modelAdditiveName));
	end

	strlength_modelNamesParameters = strlength(modelNamesParameters);
	modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[',',getVarName(modeTortuosity),'=']);
	if ischar(modeTortuosity)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,['''',modeTortuosity,'''']);
	elseif isnumeric(modeTortuosity)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,num2str(modeTortuosity));
	end

	strlength_modelNamesParameters = strlength(modelNamesParameters);
	modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[',',getVarName(a),'=']);
	if ischar(a)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,['''',a,'''']);
	elseif isnumeric(a)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,num2str(a));
	end

	strlength_modelNamesParameters = strlength(modelNamesParameters);
	modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[',',getVarName(c),'=']);
	if ischar(c)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,['''',c,'''']);
	elseif isnumeric(c)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,num2str(c));
	end

	% to calculate the effective thermal conductivity
	keff = k_model_out_of_name_electrode(nameElectrode,nameFiller,modelNamesParameters);