%% K_RNM_1 This function calculates the effective thermal conductivity of active material, conductive additve, binder filled with filler
% using names out of table statistics.
% part 1: only fluid, part 2: only active material,
% part 3: series model for activematerial, additive (conductive additive + binder) and filler.

function keff = k_RNM_1(namesMatrix,volumeFractionsMatrix,nameFiller,porosity,modeTortuosity,a)
%% Explanations of input & output arguments:

    % namesMatrix: e.g. {'graphiteParallel';'carbonBlack';'PVDF'}: 3 * 1 cell array of names for active material, conductive additive andbinder respectively.
    % volumeFractionsMatrix: e.g. [0.9;0.05]: 2 * 1 numeric array for active material and conductive additive respectively.
    %                       The sum should not exceed 1. The last one for binder can be omitted.
    % nameFiller: e.g. 'air': char array of name for filling fluid.
    % porosity: e.g. 0.2657, numeric variable, the volume fraction of fluid.
    % modeTortuosity: e.g. 1, numeric varible. The mode is from 1 to 3.
    % a: e.g. 0, numeric variable, the volume fraction of active material in part 2 in active material. a is in range of [0,1].
    
    
%% Calculation of effective thermal conductivity
    
    % calculate the effective thermal conductivity
    keff = k_model_out_of_name( namesMatrix,volumeFractionsMatrix,nameFiller,porosity,...
                                ['RNM_1,modeTortuosity=',num2str(modeTortuosity),',a=',num2str(a)]);
    