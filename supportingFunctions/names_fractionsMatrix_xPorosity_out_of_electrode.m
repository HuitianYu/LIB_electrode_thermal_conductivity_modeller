%% NAMESMATRIX_FRACTIONSMATRIX_XPOROSITY_OUT_OF_ELECTRODE

function [names_matrix,fractions_matrix,xPorosity] = names_fractionsMatrix_xPorosity_out_of_electrode(nameElectrode,nameFiller,modeFractionsMatrixPorosity)
%% Explanations of input & output arguments:

    % nameElectrode:   e.g. 'graphiteAnodeParallel': electrode name from table electrode. 
    % nameFiller: e.g. 'LP30': one line table cell from statistics. 
    % modeFractionsMatrixPorosity: e.g. 1 (mass mode) or 0 (volume mode): numeric variable: for both fractionMatrix and porosity.
    % names_matrix: 3 * 1 cell array.
    % fractions_matrix: 3 * 1 numeric array.
    % xPorosity: numeric variable.
    
%% To import thermal conductivities from table statistics

    % load statistics and electrodefrom tables
    load tables statistics electrode
    % assign one line of table to table variable of all materials
    thisElectrode = electrode(nameElectrode,:); 
%% calculate the fractionsMatrix and assign values to output arguments

    % allocate some arrays
    % 1: acitveMaterial, 2: conductiveAdditive, 3: binder
    matrix = cell(3,1);
    names_matrix = cell(3,1);
    massFractions_matrix = zeros(3,1);
    densities_matrix = zeros(3,1);
    
    % assignment to arrays and a variable
    for ii = 1:3
        names_matrix{ii,1} = thisElectrode{1,ii}{1,1}; % assign material name of statistics from electrode table to materialNames array
        matrix{ii,1} = statistics(names_matrix{ii,1},:); % assign one line table of statistics from electrode table to materials array
        massFractions_matrix(ii,1) = thisElectrode{1,3 + ii}; % assign mass fraction from electrode table to massFractions array
        densities_matrix(ii,1) = matrix{ii,1}.density; % assign density from electrode to densities
    end
    porosity = thisElectrode{1,7}; % assignment porosity from electrode table to porosity variable
    filler = statistics(nameFiller,:);
    density_filler = filler.density;
    
    % calculate the volumeFrctions of matrix
    volumes_matrix = massFractions_matrix ./ densities_matrix; % totoal volume per mass unit
    volumeFractions_matrix = volumes_matrix / sum(volumes_matrix); % volume fractions
    averageDensity_matrix = sum(volumeFractions_matrix .* densities_matrix);
    
    % calculate the mass porosisty
    mass_porosity = density_filler * porosity /(averageDensity_matrix * (1 - porosity) + density_filler * porosity);
    
    switch modeFractionsMatrixPorosity 
        case 1
            fractions_matrix = massFractions_matrix;
            xPorosity = mass_porosity;
        case 0 
            fractions_matrix = volumeFractions_matrix;
            xPorosity = porosity;
        otherwise
            error('modeFractionsMatrixPorosity should be either 1 or 0.')
    end