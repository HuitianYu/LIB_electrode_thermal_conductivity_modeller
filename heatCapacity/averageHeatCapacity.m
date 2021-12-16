%% AVERAGEHEATCAPACITY This function generates a function handle, which calculates the average heat capacity
% out of the model name and material names.

function avgCp = averageHeatCapacity(namesMatrix,massFractionsMatrix,nameFiller,massPorosity)
%% Explanations of input & output arguments:

    % namesMatrix: e.g. {'PVDF';'carbonBlack'} or {'PVDF'}: n_matrix * 1 numeric array of thermal conductivities
    % massFractionsMatrix:   e.g. [0.5] or []: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one can be omitted.
    % nameFiller: e.g. 'none' or 'carbonBlack': char array.
    % massPorosity: e.g. 0 or 0.5: numeric variable.
    
%% To import densities from table statistics

    [heatCapacities_matrix,heatCapacity_filler] = values_out_of_name(namesMatrix,nameFiller,massPorosity,'heatCapacity');
%{
    % load statistics from tables
    load tables statistics
    % assign one line of table to table variable of all materials
    n_matrix = size(namesMatrix,1);
    matrix = cell(n_matrix,1);
    heatCapacities_matrix = zeros(n_matrix,1);
    for ii = 1:n_matrix
        matrix{ii,1} = statistics(namesMatrix{ii,1},:); 
        heatCapacities_matrix(ii,1) = matrix{ii,1}.heatCapacity;
    end    
    
    if ischar(nameFiller) && strcmp(nameFiller,'none') && massPorosity == 0
        thermalCapacity_filler = 'none';
    elseif (ischar(nameFiller) && strcmp(nameFiller,'none')) && massPorosity ~= 0
        error('porosity should be 0, when nameFiller is ''none''.')
    else
        filler = statistics(nameFiller,:);
        thermalCapacity_filler = filler.heatCapacity;
    end
%}

%% calculate the thermal conductivity
        
    % calculate the average heat capacity using the corresponding calculator
    avgCp = averageHeatCapacity_calculator(heatCapacities_matrix,massFractionsMatrix,heatCapacity_filler,massPorosity);