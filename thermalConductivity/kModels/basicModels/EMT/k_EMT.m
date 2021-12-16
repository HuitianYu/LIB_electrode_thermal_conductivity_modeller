%% K_EMT_MODEL This function calculates the effective thermal conductivity of n materials with their volume fractions,
% which is organized with Effective Medium Theory Model.

function keff = k_EMT(namesMatrix,volumeFractionsMatrix,nameFiller,porosity,f)
%% Explanations of input & output arguments:

	% namesMatrix: e.g. {'PVDF';'carbonBlack'}: n_matrix * 1 cell array.
    % volumeFractions:  e.g. [0.5;0.3]: (n-matrix - 1) * 1 numeric array. 
    %                   The sum should not exceed 1. The last one must be omitted.
    % nameFiller: 'air': char array.
    % porosity: e.g. 0.5: numeric variable.
    % f: e.g. 6: numeric variable, factor. It usually equals 6.

%% calculate the thermal conductivity

    % calculate the effective thermal conductivity using the corresponding calculator
    keff = k_model_out_of_name( namesMatrix,volumeFractionsMatrix,nameFiller,porosity,...
                                ['EMT,f=',num2str(f)]);
