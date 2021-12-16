%% AVERAGEHEATCAPACITY_ELECTRODE This function calculates the average heat capacity for one electrode,
% out of the model name, electrode names and filler name.

function avgCp = averageHeatCapacity_electrode(nameElectrode,nameFiller) 
%% Explanations of input & output arguments:

    % nameElectrode:   e.g. 'graphiteAnodeParallel': electrode name from table electrode. 
    % nameFiller: e.g. 'LP30': one line table cell from statistics. 
    % avgCp: numeric variable: average heat capacity.
    
%% To import thermal conductivities from table statistics

    [names_matrix,massFractions_matrix,massPorosity] =...
        names_fractionsMatrix_xPorosity_out_of_electrode(...
        nameElectrode,nameFiller,1);

    % calculate the average heat capacity
    avgCp = averageHeatCapacity(...
        names_matrix,massFractions_matrix,nameFiller,massPorosity);
