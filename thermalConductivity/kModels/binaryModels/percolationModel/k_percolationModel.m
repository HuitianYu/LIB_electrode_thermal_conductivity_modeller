%% K_PERCOLATIONMODEL This function calculates the effective thermal conductivities of 2 materials with their volume fractions,
% which is organized with percolation model, using names out of table statistics.
% using names out of table statistics.
% 1: continuous phase (matrix), 2: disperse phase (filler).

function keff = k_percolationModel(namesMatrix,volumeFractionsMatrix,nameFiller,porosity,kc,vc,nExp)
%% Explanations of input & output arguments:

    % namesMatrix: e.g. {'PVDF';'carbonBlack'} or {'PVDF'}: n_matrix * 1 numeric array of thermal conductivities
    % volumeFractionsMatrix:   e.g. [0.5] or []: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one can be omitted.
    % thermalConductivityFiller: e.g. 'none' or 'carbonBlack': numeric variable.
    % porosity: e.g. 0 or 0.5: numeric variable.
    % kc: e.g. 0.44: numeric variable: effective thermal conductivity, wenn v2 = vc.
    % vc: e.g. 0.15: numeric variable: percolation threshold in range of [0.15,0.2].
    % nExp: e.g. 0.51: numeric variable: percolation exponent in range of [0.3,0.8].

%% Calculation of effective thermal conductivity
    
    % calculate the effective thermal conductivity
    keff = k_model_out_of_name( namesMatrix,volumeFractionsMatrix,nameFiller,porosity,...
                                ['percolationModel,kc=',num2str(kc),',vc=',num2str(vc),',nExp=',num2str(nExp)]);
    