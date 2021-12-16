%% FRACTIONSMATRIX_XPOROSITY_TRANSFER This function transfers the fraction and porosity base for fractionsMatrix and porosity from mass to volume
% and vice versa.

function [output_fractionsMatrix,output_porosity] = fractionsMatrix_xPorosity_transfer(namesMatrix,inputFractionsMatrix,nameFiller,inputPorosity,inputModeFractionsMatrix,inputModePorosity,outputModeFractionsMatrix,outputModePorosity)
%% Explanations of input & output arguments:
    % namesMatrix: e.g. {'PVDF';'carbonBlack'} or {'PVDF'}: n_matrix * 1 numeric array of thermal conductivities
    % inputFractionsMatrix:   e.g. [0.5] or []: (n_matrix - 1) * 1 numeric array.
    %                           The sum should not exceed 1. The last one can be omitted.
    % nameFiller: e.g. 'none' or 'carbonBlack': char array.
    % inputPorosity: e.g. 0 or 0.5: numeric variable.
    % inputModeFractionsMatrix: 1: mass fraction, 0: volume fraction: numeric variable.
    % inputModePorosity: 1: mass porosity, 0: volume porosity: numeric variable.
    % outputModeFractionsMatrix: 1: mass fraction, 0: volume fraction: numeric variable.
    % outputModePorosity: 1: mass porosity, 0: volume porosity: numeric variable.    
    % output_fractionsMatrix:   e.g. [0.5]: (n_matrix - 1) * 1 numeric array.
    %                           The sum should not exceed 1. The last one is omitted.    
    % output_porosity: e.g. 0 or 0.5: numeric variable.    
    
%% Transfer of fractionsMatrix and porosity

    % STEP 1: variables preparation
    % load statistics and electrode from tables
    load tables statistics
    
    % calculate the number of elements in namesMatrix array and assign values to input_fractionsMatrix.
    n_matrix = size(namesMatrix,1);
    inputFractionsMatrix(n_matrix,1) = 1 - sum(inputFractionsMatrix(1:n_matrix - 1));
    if inputFractionsMatrix(n_matrix,1) < 0
        error('The calculated last element is negative.')
    end

    % assign values to densities_matrix and density_filler
    matrix = cell(n_matrix,1);
    densities_matrix = zeros(n_matrix,1);
    for ii = 1 : n_matrix
        matrix{ii,1} = statistics(namesMatrix{ii,1},:);
        densities_matrix(ii,1) = matrix{ii,1}.density;
    end
    
    % STEP 2: transfer from input to volume based physical quantities and mass based physical quantities
    
    % transfer inputFractionsMatrix to volumeFractionsMatrix
    switch inputModeFractionsMatrix
        case 1
            volumes_matrix = inputFractionsMatrix ./ densities_matrix;
            volumeFractions_matrix = volumes_matrix / sum(volumes_matrix);
        case 0 
            volumeFractions_matrix = inputFractionsMatrix;
        otherwise
            error('inputModeFractionsMatrix should be either 1 or 0.')
    end
    
    % transfer inputFractionsMatrix to massFractionsMatrix
    switch inputModeFractionsMatrix
        case 1
            massFractions_matrix = inputFractionsMatrix;
        case 0 
            mass_matrix = inputFractionsMatrix .* densities_matrix;
            massFractions_matrix = mass_matrix / sum(mass_matrix);
        otherwise
            error('inputModeFractionsMatrix should be either 1 or 0.')
    end
        
    
    if strcmp(nameFiller,'none') && inputPorosity == 0
        mass_porosity = 0;
        porosity = 0;
    elseif strcmp(nameFiller,'none') && inputPorosity ~= 0
        error('inputPorosity should be 0, when nameFiller is ''none''.')
    else
        filler = statistics(nameFiller,:);
        density_filler = filler.density;
        % calculate the average density of matrix
        averageDensity_matrix = sum(volumeFractions_matrix .* densities_matrix);

        % transfer inputPorosity to volumePorosity
        switch inputModePorosity
            case 1
                porosity = inputPorosity / density_filler /((1 - inputPorosity) / averageDensity_matrix + inputPorosity / density_filler);
            case 0
                porosity = inputPorosity;
            otherwise
                error('inputModePorosity should be either 1 or 0.')
        end
    
        % transfer inputPorosity to massPorosity
        switch inputModePorosity
            case 1
                mass_porosity = inputPorosity;
            case 0 
                mass_porosity = density_filler * inputPorosity / (averageDensity_matrix * (1 - inputPorosity) + density_filler * inputPorosity);
            otherwise
                error('inputModePorosity should be either 1 or 0.')
        end
    end
        
    
    % STEP 3: assign values to output_fractionsMatrix and output_porosity
    switch outputModeFractionsMatrix
        case 1
            output_fractionsMatrix = massFractions_matrix(1:n_matrix - 1,1);
        case 0 
            output_fractionsMatrix = volumeFractions_matrix(1:n_matrix - 1,1);
        otherwise
            error('outputModeFractionsMatrix should be either 1 or 0.')
    end
    
    switch outputModePorosity
        case 1
            output_porosity = mass_porosity;
        case 0
            output_porosity = porosity;
        otherwise
            error('outputModePorosity should be either 1 or 0.')
    end