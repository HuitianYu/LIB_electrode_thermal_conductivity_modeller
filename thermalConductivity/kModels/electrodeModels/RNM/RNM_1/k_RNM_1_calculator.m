%% K_RNM_1_CALCULATOR This function calculates the effective thermal conductivity of active material, conductive additve, binder filled with filler.
% part 1: only fluid, part 2: only active material,
% part 3: series model for activematerial, additive (conductive additive + binder) and filler.

function keff = k_RNM_1_calculator(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity,modeTortuosity,a)
%% Explanations of input & output arguments:

    % thermalConductivitiesMatrix: e.g. [180;0.1874;2.5]: 3 * 1 numeric array of thermal conductivities for active material, conductive additive andbinder respectively.
    % volumeFractionsMatrix: e.g. [0.9;0.05]: 2 * 1 numeric array for active material and conductive additive respectively.
    %                       The sum should not exceed 1. The last one for binder can be omitted.
    % thermalConductivityFiller: e.g. 0.026: numeric variable.
    % porosity: e.g. 0.2657, numeric variable, the volume fraction of fluid.
    % modeTortuosity: e.g. 1, numeric varible. The mode is from 1 to 3.
    % a: e.g. 0, numeric variable, the volume fraction of active material in part 2 in active material. a is in range of [0,1].
    
%% Calculation of effective thermal conductivity

    % set the maximal difference
    esp = 1e-10;

    % assign values from arrays to variabls for thermal conductivities and volume fractions
    k_activeMaterial = thermalConductivitiesMatrix(1,1);
    k_conductiveAdditive = thermalConductivitiesMatrix(2,1);
    k_binder = thermalConductivitiesMatrix(3,1);
    k_filler = thermalConductivityFiller;
    
    vFrMatrix_activeMaterial = volumeFractionsMatrix(1,1);
    vFrMatrix_conductiveAdditive = volumeFractionsMatrix(2,1);

    % calculate the volume fraction for binder
    vFrMatrix_binder = 1 - vFrMatrix_activeMaterial - vFrMatrix_conductiveAdditive;

    % volume fractions of conductive additive and binder in additive, summing up to 1
    if vFrMatrix_conductiveAdditive + vFrMatrix_binder ~= 0
        vFrAdditive_conductiveAdditive = vFrMatrix_conductiveAdditive / (vFrMatrix_conductiveAdditive + vFrMatrix_binder);
        vFrAdditive_binder = vFrMatrix_binder / (vFrMatrix_conductiveAdditive + vFrMatrix_binder);

        % check whether the sum of all volume fractions in additive is 1
        vFrAdditive_total = vFrAdditive_conductiveAdditive + vFrAdditive_binder;
        if abs(vFrAdditive_total - 1) > esp
            error('The sum of volume fractions in additive should be is 1.')
        end
    else
        vFrAdditive_conductiveAdditive = 0;
        vFrAdditive_binder = 0;
        % check whether the sum of all volume fractions in additive is 0
        vFrAdditive_total = vFrAdditive_conductiveAdditive + vFrAdditive_binder;
        if abs(vFrAdditive_total) > esp
            error('The sum of volume fractions in additive should be is 0.')
        end
    end

    % tortuosity
    tortuosity = tortuosity_calculator(porosity,modeTortuosity);

    % volume fractions in parallel system: 
        % part 1 and 2
        vFr_1 = porosity / tortuosity;
        vFr_2 = a * vFrMatrix_activeMaterial * (1 - porosity);
        % part 3
        vFr_3_activeMaterial = (1 - a) * vFrMatrix_activeMaterial * (1 - porosity);
        vFr_3_conductiveAdditive = vFrMatrix_conductiveAdditive * (1 - porosity);
        vFr_3_binder = vFrMatrix_binder * (1- porosity);        
        vFr_3_filler = porosity - porosity / tortuosity;
        vFr_3 = vFr_3_activeMaterial + vFr_3_filler + vFr_3_conductiveAdditive + vFr_3_binder;

    % check whether the sum of all volume fractions is 1
    vFr_total = vFr_1 + vFr_2 + vFr_3;
    if abs(vFr_total - 1) > esp
        error('The sum of volume fractions should be 1.')
    end

    % volume fractions in part 3
    if vFr_3 ~= 0
        vFrPart3_activeMaterial = vFr_3_activeMaterial / vFr_3;
        vFrPart3_conductiveAdditive = vFr_3_conductiveAdditive / vFr_3;
        vFrPart3_binder = vFr_3_binder / vFr_3;
        vFrPart3_filler = vFr_3_filler / vFr_3;

        % check whether the sum of all volume fractions is 1
        vFrPart3_total = vFrPart3_activeMaterial + vFrPart3_conductiveAdditive + vFrPart3_binder + vFrPart3_filler;
        if abs(vFrPart3_total - 1) > esp
            error('The sum of volume fractions should be 1.')
        end
    else
        vFrPart3_activeMaterial = 0;
        vFrPart3_conductiveAdditive = 0;
        vFrPart3_binder = 0;
        vFrPart3_filler = 0;
        % check whether the sum of all volume fractions is 0
        vFrPart3_total = vFrPart3_activeMaterial + vFrPart3_conductiveAdditive + vFrPart3_binder + vFrPart3_filler;
        if abs(vFrPart3_total) > esp
            error('The sum of volume fractions should be 0.')
        end        
    end



    % thermal conductivity of each part
    k_1 = k_filler;
    k_2 = k_activeMaterial;
    k_3 = 1 / (vFrPart3_activeMaterial / k_activeMaterial + vFrPart3_conductiveAdditive / k_conductiveAdditive + vFrPart3_binder / k_binder + vFrPart3_filler / k_filler);

    % the effective thermal conductivity: keff
    keff_1 = k_1 * vFr_1;
    keff_2 = k_2 * vFr_2;
    keff_3 = k_3 * vFr_3;
    keff = keff_1 + keff_2 + keff_3;
    % fprintf(' a = %.4f,\n keff_RNM_1 = %.4f.\n',a,keff)
