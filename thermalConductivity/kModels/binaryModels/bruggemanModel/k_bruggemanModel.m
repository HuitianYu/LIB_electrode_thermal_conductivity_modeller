%% K_BRUGGEMANMODEL This function calculates the effective thermal conductivities of 2 materials with their volume fractions,
% which is organized with Bruggeman model, using names out of table statistics.
% using names out of table statistics.
% 1: continuous phase (matrix), 2: disperse phase (filler).
% A = 2, phiM = 1, this model reduces to Maxwell-Euken model.

function keff = k_bruggemanModel(namesMatrix,volumeFractionsMatrix,nameFiller,porosity,alpha,f)
%% Explanations of input & output arguments:

    % namesMatrix: e.g. {'PVDF';'carbonBlack'} or {'PVDF'}: n_matrix * 1 numeric array of thermal conductivities
    % volumeFractionsMatrix:   e.g. [0.5] or []: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one can be omitted.
    % thermalConductivityFiller: e.g. 'none' or 'carbonBlack': numeric variable.
    % porosity: e.g. 0 or 0.5: numeric variable.
    % alpha: e.g. 0 (thermal Resistance not considered): numeric variable
    % f : e.g. 1.08 (usually 1): numeric variable, an effect factor.

%% Calculation of effective thermal conductivity
    
    % calculate the effective thermal conductivity
    keff = k_model_out_of_name( namesMatrix,volumeFractionsMatrix,nameFiller,porosity,...
                                ['bruggemanModel,alpha=',num2str(alpha),',f=',num2str(f)]);
    