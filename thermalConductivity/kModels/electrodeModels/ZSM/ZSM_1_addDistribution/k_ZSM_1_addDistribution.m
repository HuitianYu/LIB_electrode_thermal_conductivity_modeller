%% K_ZSM_1_ADDDISTRIBUTION This model calculates the effective thermal conductivity using names from table statistics
% according to ZSM_1_addDistribution.

function keff = k_ZSM_1_addDistribution(namesMatrix,volumeFractionsMatrix,nameFiller,porosity,curveName,modelAdditiveName,modeTortuosity,a,c,e,g,addDistribution,addDisPar)
%% Explanations of input & output arguments:

	% namesMatrix: e.g. {'PVDF';'carbonBlack'} or {'PVDF'}: n_matrix * 1 numeric array of thermal conductivities.
	% volumeFractionsMatrix:   e.g. [0.5] or []: (n_matrix - 1) * 1 numeric array. The sum should not exceed 1. The last one can be omitted.
	% thermalConductivityFiller: e.g. 'none' or 'carbonBlack': numeric variable.
	% porosity: e.g. 0 or 0.5: numeric variable.
	% curveName:
	% modelAdditiveName:
	% modeTortuosity:
	% a:
	% c:
	% e:
	% g:
	% addDistribution:
	% addDisPar:

%% Calculation of the effective thermal conductivity

	modelNamesParameters ='ZSM_1_addDistribution';

	% to find a whole string for the model name plus selective parameters with their values
	strlength_modelNamesParameters = strlength(modelNamesParameters);
	modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[',',getVarName(curveName),'=']);
	if ischar(curveName)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,['''',curveName,'''']);
	elseif isnumeric(curveName)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,'[');
		for ii = 1 : size(curveName,1)
			strlength_modelNamesParameters = strlength(modelNamesParameters);
			modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[num2str(curveName(ii,1)),';']);
		end
		clear ii
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,']');
	end

	strlength_modelNamesParameters = strlength(modelNamesParameters);
	modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[',',getVarName(modelAdditiveName),'=']);
	if ischar(modelAdditiveName)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,['''',modelAdditiveName,'''']);
	elseif isnumeric(modelAdditiveName)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,'[');
		for ii = 1 : size(modelAdditiveName,1)
			strlength_modelNamesParameters = strlength(modelNamesParameters);
			modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[num2str(modelAdditiveName(ii,1)),';']);
		end
		clear ii
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,']');
	end

	strlength_modelNamesParameters = strlength(modelNamesParameters);
	modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[',',getVarName(modeTortuosity),'=']);
	if ischar(modeTortuosity)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,['''',modeTortuosity,'''']);
	elseif isnumeric(modeTortuosity)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,'[');
		for ii = 1 : size(modeTortuosity,1)
			strlength_modelNamesParameters = strlength(modelNamesParameters);
			modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[num2str(modeTortuosity(ii,1)),';']);
		end
		clear ii
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,']');
	end

	strlength_modelNamesParameters = strlength(modelNamesParameters);
	modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[',',getVarName(a),'=']);
	if ischar(a)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,['''',a,'''']);
	elseif isnumeric(a)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,'[');
		for ii = 1 : size(a,1)
			strlength_modelNamesParameters = strlength(modelNamesParameters);
			modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[num2str(a(ii,1)),';']);
		end
		clear ii
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,']');
	end

	strlength_modelNamesParameters = strlength(modelNamesParameters);
	modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[',',getVarName(c),'=']);
	if ischar(c)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,['''',c,'''']);
	elseif isnumeric(c)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,'[');
		for ii = 1 : size(c,1)
			strlength_modelNamesParameters = strlength(modelNamesParameters);
			modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[num2str(c(ii,1)),';']);
		end
		clear ii
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,']');
	end

	strlength_modelNamesParameters = strlength(modelNamesParameters);
	modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[',',getVarName(e),'=']);
	if ischar(e)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,['''',e,'''']);
	elseif isnumeric(e)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,'[');
		for ii = 1 : size(e,1)
			strlength_modelNamesParameters = strlength(modelNamesParameters);
			modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[num2str(e(ii,1)),';']);
		end
		clear ii
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,']');
	end

	strlength_modelNamesParameters = strlength(modelNamesParameters);
	modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[',',getVarName(g),'=']);
	if ischar(g)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,['''',g,'''']);
	elseif isnumeric(g)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,'[');
		for ii = 1 : size(g,1)
			strlength_modelNamesParameters = strlength(modelNamesParameters);
			modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[num2str(g(ii,1)),';']);
		end
		clear ii
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,']');
	end

	strlength_modelNamesParameters = strlength(modelNamesParameters);
	modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[',',getVarName(addDistribution),'=']);
	if ischar(addDistribution)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,['''',addDistribution,'''']);
	elseif isnumeric(addDistribution)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,'[');
		for ii = 1 : size(addDistribution,1)
			strlength_modelNamesParameters = strlength(modelNamesParameters);
			modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[num2str(addDistribution(ii,1)),';']);
		end
		clear ii
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,']');
	end

	strlength_modelNamesParameters = strlength(modelNamesParameters);
	modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[',',getVarName(addDisPar),'=']);
	if ischar(addDisPar)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,['''',addDisPar,'''']);
	elseif isnumeric(addDisPar)
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,'[');
		for ii = 1 : size(addDisPar,1)
			strlength_modelNamesParameters = strlength(modelNamesParameters);
			modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,[num2str(addDisPar(ii,1)),';']);
		end
		clear ii
		strlength_modelNamesParameters = strlength(modelNamesParameters);
		modelNamesParameters = insertAfter(modelNamesParameters,strlength_modelNamesParameters,']');
	end

	% to calculate the effective thermal conductivity
	keff = k_model_out_of_name(namesMatrix,volumeFractionsMatrix,nameFiller,porosity,modelNamesParameters);