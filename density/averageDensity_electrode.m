%% AVERAGEDENSITY_ELECTRODE This function calculates the average density for one electrode,
% out of the model name, electrode names and filler name.

function avgRho = averageDensity_electrode(nameElectrode,nameFiller) 
%% Explanations of input & output arguments:

    % nameElectrode:   e.g. 'graphiteAnodeParallel': electrode name from table electrode. 
    % nameFiller: e.g. 'LP30': one line table cell from statistics.
    % avgRho: numeric variable: average density.
    
%% calculate the thermal conductivity

    [names_matrix,volumeFractions_matrix,porosity] =...
        names_fractionsMatrix_xPorosity_out_of_electrode(...
        nameElectrode,nameFiller,0);

    % calculate the average density
    avgRho = averageDensity(...
        names_matrix,volumeFractions_matrix,nameFiller,porosity);
