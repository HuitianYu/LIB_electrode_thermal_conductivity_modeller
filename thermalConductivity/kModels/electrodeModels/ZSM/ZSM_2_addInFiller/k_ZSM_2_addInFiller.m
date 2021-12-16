%% K_ZSM_2_ADDINFILLER This model calculates the effective thermal conductivity using names from table statistics
% according to ZSM_2_addInFiller.

function keff = k_ZSM_2_addInFiller(namesMatrix,volumeFractionsMatrix,nameFiller,porosity,curveName,modelAdditiveName,modeTortuosity,alpha,c,e,g,modelAddInFillerName)
%% Explanations of input & output arguments:

	% namesMatrix: e.g. {'PVDF';'carbonBlack'} or {'PVDF'}: n_matrix * 1 numeric array of thermal conductivities.
	% volumeFractionsMatrix:   e.g. [0.5] or []: (n_matrix - 1) * 1 numeric array. The sum should not exceed 1. The last one can be omitted.
	% thermalConductivityFiller: e.g. 'none' or 'carbonBlack': numeric variable.
	% porosity: e.g. 0 or 0.5: numeric variable.
	% curveName:
	% modelAdditiveName:
	% modeTortuosity:
	% alpha:
	% c:
	% e:
	% g:
	% modelAddInFillerName:

%% Calculation of the effective thermal conductivity

	modelNamesParameters ='ZSM_2_addInFiller';

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
	modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[',',getVarName(alpha),'=']);
	if ischar(alpha)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,['''',alpha,'''']);
	elseif isnumeric(alpha)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,num2str(alpha));
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

	strlength_modelNamesParameters = strlength(modelNamesParameters);
	modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[',',getVarName(e),'=']);
	if ischar(e)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,['''',e,'''']);
	elseif isnumeric(e)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,num2str(e));
	end

	strlength_modelNamesParameters = strlength(modelNamesParameters);
	modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[',',getVarName(g),'=']);
	if ischar(g)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,['''',g,'''']);
	elseif isnumeric(g)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,num2str(g));
	end

	strlength_modelNamesParameters = strlength(modelNamesParameters);
	modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[',',getVarName(modelAddInFillerName),'=']);
	if ischar(modelAddInFillerName)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,['''',modelAddInFillerName,'''']);
	elseif isnumeric(modelAddInFillerName)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,num2str(modelAddInFillerName));
	end

	% to calculate the effective thermal conductivity
	keff = k_model_out_of_name(namesMatrix,volumeFractionsMatrix,nameFiller,porosity,modelNamesParameters);