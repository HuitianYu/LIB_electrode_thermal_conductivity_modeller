%% VALUES_OUT_OF_NAMES This function returs values out of names from table statistics

function [values_matrix,value_filler] = values_out_of_name(namesMatrix,nameFiller,xPorosity,namePhysicalQuantity)
%% Explanations of input & output arguments:

    % namesMatrix: e.g. {'PVDF';'carbonBlack'} or {'PVDF'}: n_matrix * 1 numeric array of thermal conductivities
    % nameFiller: e.g. 'none' or 'carbonBlack': char array.
    % namePhysicalQuantity: e.g. 'thermalConductivity','density','heatCapacity': char array.
    % values_matrix: e.g. [180;24;0.2]: numeric arrray.
    % value_filler: e.g. 0.026: numeric variable.
    % xPorosity: e.g. 0 or 0.5: numeric variable, volume porosity or mass porosity.
    % values_matrix: n_matrix * 1 numeric array.
    % value_filler: numeric variable.
    
%% To import values from table statistics

    % load statistics from tables
    load tables statistics
    % assign one line of table to table variable of all materials
    n_matrix = size(namesMatrix,1);
    matrix = cell(n_matrix,1);
    values_matrix = zeros(n_matrix,1);
    for ii = 1:n_matrix
        matrix{ii,1} = statistics(namesMatrix{ii,1},:); 
        eval(['values_matrix(ii,1) = matrix{ii,1}.',namePhysicalQuantity,';'])
    end    
    
    if ischar(nameFiller) && strcmp(nameFiller,'none') && xPorosity == 0
        eval('value_filler_temp = ''none'';')
        value_filler = value_filler_temp;
    elseif (ischar(nameFiller) && strcmp(nameFiller,'none')) && xPorosity ~= 0
        error('porosity should be 0, when nameFiller is ''none''.')
    else
        filler = statistics(nameFiller,:);
        eval(['value_filler_temp = ',getVarName(filler),'.',namePhysicalQuantity,';'])
        value_filler = value_filler_temp;
    end
    