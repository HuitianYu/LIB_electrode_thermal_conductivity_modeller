%% K_LNM This function calculates the effective thermal conductivities of 2 materials with their volume fractions,
% which is organized with Lewis-Nielsen model, using names out of table statistics.
% using names out of table statistics.
% 1: continuous phase (matrix), 2: disperse phase (filler).
% A = 2, phiM = 1, this model reduces to Maxwell-Euken model.

function keff = k_LNM(namesMatrix,volumeFractionsMatrix,nameFiller,porosity,kE,phiM)
%% Explanations of input & output arguments:

    % namesMatrix: e.g. {'PVDF';'carbonBlack'} or {'PVDF'}: n_matrix * 1 numeric array of thermal conductivities
    % volumeFractionsMatrix:   e.g. [0.5] or []: (n_matrix - 1) * 1 numeric array.
    %                   The sum should not exceed 1. The last one can be omitted.
    % thermalConductivityFiller: e.g. 'none' or 'carbonBlack': numeric variable.
    % porosity: e.g. 0 or 0.5: numeric variable.
    % kE:   e.g. 2.5 (for rigid spheres suspended in a matrix with Poisson ratio of 0.5):
    %       numeric variable: Einstein coefficient.
    % phiM: 0.637 (for random close packing of spheres): numeric variable:
    %       maximum packing volume fraction of particles, which ranges 
    %       from 0.32 to 1.0.
       
%% Calculation of effective thermal conductivity
    
    % calculate the effective thermal conductivity
    keff = k_model_out_of_name( namesMatrix,volumeFractionsMatrix,nameFiller,porosity,...
                                ['LNM,kE=',num2str(kE),',phiM=',num2str(phiM)]);
    