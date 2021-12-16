%% K_KRISCHERMODEL This function calculates the effective thermal conductivity of n materials with their volume fractions,
% which is organized with krischer model.

function keff = k_krischerModel(namesMatrix,volumeFractionsMatrix,nameFiller,porosity,a)
%% Explanations of input & output arguments:

	% namesMatrix: e.g. {'PVDF';'carbonBlack'}: n_matrix * 1 cell array.
    % volumeFractions:  e.g. [0.5;0.3]: (n-matrix - 1) * 1 numeric array. 
    %                   The sum should not exceed 1. The last one can be omitted.
    % nameFiller: 'air': char array.
    % a: e.g. 0.5: numeric variable, scaling factor for series part.
  
%% calculate the thermal conductivity

    % calculate the effective thermal conductivity using the corresponding calculator
    keff = k_model_out_of_name( namesMatrix,volumeFractionsMatrix,nameFiller,porosity,...
                                ['krischerModel,a=',num2str(a)]);