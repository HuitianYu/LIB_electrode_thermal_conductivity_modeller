%% K_MEM_1 This function calculates the effective thermal conductivity of n materials with their volume fractions,
% which is organized with Maxwell-Euken-1 model.
% 1: continuous phase (matrix), 2: disperse phase (filler).

function keff = k_MEM_1(namesMatrix,volumeFractionsMatrix,nameFiller,porosity,f)
%% Explanations of input & output arguments:

    % namesMatrix: e.g. {'PVDF';'carbonBlack'} or {'PVDF'}: n_matrix * 1 numeric array of thermal conductivities
    % volumeFractionsMatrix:   e.g. [0.5] or []: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one can be omitted.
    % thermalConductivityFiller: e.g. 'none' or 'carbonBlack': numeric variable.
    % porosity: e.g. 0 or 0.5: numeric variable.
    % f: e.g. 3: numeric variable. It usually equals 3.

%% calculate the thermal conductivity
    
    % calculate the effective thermal conductivity using the corresponding calculator
    keff = k_model_out_of_name( namesMatrix,volumeFractionsMatrix,nameFiller,porosity,...
                                ['MEM_1,f=',num2str(f)]);