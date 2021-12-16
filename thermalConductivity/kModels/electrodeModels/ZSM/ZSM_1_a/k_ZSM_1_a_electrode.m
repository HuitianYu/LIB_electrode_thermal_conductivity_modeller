%% K_ZSM_1_A_ELECTRODE This model calculates the effective thermal conductivity using electrode information from table electrode
% according to ZSM_1_a.

function keff = k_ZSM_1_a_electrode(nameElectrode,nameFiller,curveName,modelAdditiveName,modeTortuosity,a,c,e,g)
%% Explations of input & output arguments:

	% nameElectrode: e.g. 'graphiteAnodeParallel': electrode name from table electrode.
	% nameFiller: e.g. 'LP30': one line table cell from statistics.
	% curveName:
	% modelAdditiveName:
	% modeTortuosity:
	% a:
	% c:
	% e:
	% g:

%% Calculation of the effective thermal conductivity

	modelNamesParameters ='ZSM_1_a';

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

	% to calculate the effective thermal conductivity
	keff = k_model_out_of_name_electrode(nameElectrode,nameFiller,modelNamesParameters);