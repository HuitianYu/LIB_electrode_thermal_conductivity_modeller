%% K_ZSM_3_ADDINFILLER_UNDERLYING This function calculates the effective thermal conductivity of active material, conductive additve, binder filled with filler.
% part 1: only filler (up-part & down-part), part 2: active material (up-part) + extra additive (conductive additive + binder, down part)
% part 3:   up-part: point contact Zehner-Schlunder model with activematerial,
%           additive (conductive additive + binder) accumulated around the
%           neck (1-e) and homogeneously dispersed in filler (e)
%           down-part: additive + filler
% upper-part: 1 - c, down-part: c.

function [deviation_vFr_matrixPassage,keff] = k_ZSM_3_addInFiller_underlying(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,allPorosity,curveName,modelAdditiveName,modeTortuosity,a,c,e,g,modelAddInFiller)
%% Explanations of input & output arguments:

    % thermalConductivitiesMatrix: e.g. [180;0.1874;2.5]: 3 * 1 numeric array of thermal conductivities for active material, conductive additive andbinder respectively.
    % volumeFractionsMatrix: e.g. [0.9;0.05]: 2 * 1 numeric array for active material and conductive additive respectively.
    %                       The sum should not exceed 1. The last one for binder can be omitted.
    % thermalConductivityFillingFluid: e.g. 0.026: numeric variable.
    % allPorosity: e.g. 0.2657, numeric variable, the volume fraction of fluid.
    % curveName: e.g. 'curveRAreaContact': char array, the name of a function handle with variables (r,B,alpha).
    % modelAdditiveName:     e.g. 'parallelModel','EMTN','EMTN,f=6','krischerModel,a=0.5','LNM,kE=2.5,phiM=0.637','MEM1,f=3': char array, which contains the following input parameters:
    %                   whose corresponding k_model_calculator contains the following input arguments:
    %                   (thermalconductivities,volumeFractions,n).
    % modeTortuosity: e.g. 1, numeric varible. The mode is from 1 to 3.
    % a: e.g. 0, numeric variable, the volume fraction of active material in part 2 in active material. a is in range of [0,1].
    % c: e.g. 0.002, numeric variable, the volume ratio of down-part in range of [0,1].
    % deviation_vFr_matrixPassage: numeric variable.
    % keff: effecitive thermal conductivity: numeric variable > 0.
    % e: e.g. 0.1: numeric variable in range of [0,1], disperse level in part 3, upper part.
    % g: e.g. 0.2: numeric variable. ratio of inner porosity to additive volume.
    % modelAddInFillerName: e.g. 'EMT,f=6': char array, model for additive system in filler.
    
%% Calculation of effective thermal conductivity

    % set the maximal difference
    esp = 1e-5;
    VEsp = 1e-5;

    % assign values from arrays to variabls for thermal conductivities and volume fractions
    k_activeMaterial = thermalConductivitiesMatrix(1,1);
    k_conductiveAdditive = thermalConductivitiesMatrix(2,1);
    k_binder = thermalConductivitiesMatrix(3,1);
    k_filler = thermalConductivityFiller;
    
    vFrMatrix_activeMaterial_pure = volumeFractionsMatrix(1,1);
    vFrMatrix_conductiveAdditive_pure = volumeFractionsMatrix(2,1);
    

    % calculate the volume fraction for binder
    vFrMatrix_binder_pure = 1 - vFrMatrix_activeMaterial_pure - vFrMatrix_conductiveAdditive_pure;
    
    % inner porosity calculation
    innerPorosity_in_additive = g;
    
    v_activeMaterial = vFrMatrix_activeMaterial_pure * (1 - allPorosity);
    v_conductiveAdditive = vFrMatrix_conductiveAdditive_pure * (1 - allPorosity) / (1 - innerPorosity_in_additive);
    v_binder = vFrMatrix_binder_pure * (1 - allPorosity) / (1 - innerPorosity_in_additive);
    v_total = v_activeMaterial + v_conductiveAdditive + v_binder;
    
    vFrMatrix_activeMaterial = v_activeMaterial / v_total;
    vFrMatrix_conductiveAdditive = v_conductiveAdditive / v_total;
    vFrMatrix_binder = v_binder / v_total;
    vFrMatrix_additive = vFrMatrix_conductiveAdditive + vFrMatrix_binder;
    
    vFrMatrix_total = vFrMatrix_activeMaterial + vFrMatrix_conductiveAdditive + vFrMatrix_binder;
    
    % check whether the sum of all volume fractions in matrix is 1
    if abs(vFrMatrix_total - 1) >esp
       error('The sum of volume fraction should be 1.') 
    end
   
    porosity = allPorosity - (1 - allPorosity) * (vFrMatrix_conductiveAdditive_pure + vFrMatrix_binder_pure) / (1 - innerPorosity_in_additive)* innerPorosity_in_additive;
    % check whether the porosity is valid
    if porosity < 0
        error('Porosity should be non-negative.')
    end
    
    % volume fractions of conductive additive and binder in additive, summing up to 1
    if vFrMatrix_conductiveAdditive + vFrMatrix_binder ~= 0
        vFrAdditive_conductiveAdditive = vFrMatrix_conductiveAdditive / vFrMatrix_additive;
        vFrAdditive_binder = vFrMatrix_binder / vFrMatrix_additive;

        % check whether the sum of all volume fractions in additive is 1
        vFrAdditive_total = vFrAdditive_conductiveAdditive + vFrAdditive_binder;
        if abs(vFrAdditive_total - 1) > esp
            error('The sum of volume fractions in additive should be is 1.')
        end
    else
        vFrAdditive_conductiveAdditive = 0;
        vFrAdditive_binder = 0;

        % check whether the sum of all volume fractions in additive is 1
        vFrAdditive_total = vFrAdditive_conductiveAdditive + vFrAdditive_binder;
        if abs(vFrAdditive_total) > esp
            error('The sum of volume fractions in additive should be is 0.')
        end
    end
        
    % thermal conductivity of additive, that combins conductive additive and binder via the following model
    % fprintf(['vFrAdditive_conductiveAdditive: ',num2str(vFrAdditive_conductiveAdditive),'.\n'])
    k_additive_pure = k_model_out_of_name_calculator(k_binder,[],k_conductiveAdditive,vFrAdditive_conductiveAdditive,modelAdditiveName);
    
    % thermal conductivity with inner porosity: additive + inner porosity
    k_additive = k_model_out_of_name_calculator([k_additive_pure;k_filler],1 - innerPorosity_in_additive,'none',0,modelAddInFiller);
    
    % tortuosity
    tortuosity = tortuosity_calculator(porosity,modeTortuosity);

    % calculate volume fractions of part 1 and those of its components: fluid
    vFr_1_down = porosity / tortuosity * c;
    vFr_1_up = porosity / tortuosity * (1 - c);
    vFr_1 = vFr_1_down + vFr_1_up;
    
    % calculate the outer radius of part 2
    if vFr_1 > 1 + esp
        error('Negative value is under square.')
    elseif vFr_1 > 1 && vFr_1 <= 1 + esp
        R2 = 0;
    else
        R2 = sqrt(1 - vFr_1);
    end
    
    % calculate volume fractions of part 2 and those of its components
    vFr_2_up = vFrMatrix_activeMaterial * (1 - porosity) * a; % only active material
    if a == 0
        vFr_2_down = 0;
        vFr_2 = 0;
    else
        if c == 1 
            error('c cannor be 1, when a is non-zero.')
        else
            vFr_2 = vFr_2_up / (1 - c);
            vFr_2_down = vFr_2 * c; % only additive
            if vFr_2_down > (vFrMatrix_conductiveAdditive + vFrMatrix_binder) * (1 - porosity)
                error('a or c is too big that additive cannot accumulate in part 3!')
            end
        end
    end
    
    % calculate the outer radius of part 3
    if R2^2 - vFr_2 < -esp
        error('Value pair of a and c is inadequate, negative value is under square.')
    elseif 2^2 - vFr_2 >= -esp && 2^2 - vFr_2 < 0
        R3 = 0;
    else
        R3 = sqrt(R2^2 - vFr_2);
    end
    
    % calculate volume fractions of part 3
    vFr_3_down = c - vFr_1_down - vFr_2_down; % only non-additive (additive + fluid)
    if vFr_3_down < -esp 
        error('vFr_3_down is negative.')
    elseif vFr_3_down > -esp && vFr_3_down < 0
        vFr_3_down = 0;
    end
    vFr_3_up_activeMaterial = vFrMatrix_activeMaterial * (1 - porosity) * (1 - a); % active material in part 3, up-part
    if c == 0
        vFr_3 = R3^2;
        vFr_3_up = vFr_3;
    else
        vFr_3 = vFr_3_down / c;
        if abs(vFr_3 - R3^2) > esp
            error('The rounding error is too big!')
        end
        vFr_3_up = vFr_3 * (1 - c); % ZSM
    end
    
    vFr_3_up_nonActiveMaterial = vFr_3_up - vFr_3_up_activeMaterial; % non-active material in part 3 up-part
    if vFr_3_up_nonActiveMaterial < -esp
        error('c is too big or a is too small that vFr_3_up_NA is negative.')
    elseif vFr_3_up_nonActiveMaterial >= -esp && vFr_3_up_nonActiveMaterial < 0
        vFr_3_up_nonActiveMaterial = 0;
    end
    
    % calculate volume fractions in upper part of part 3
    if vFr_3_up ~= 0
        vFrPart3UpPart_activeMaterial = vFr_3_up_activeMaterial / vFr_3_up;
        vFrPart3UpPart_nonActiveMaterial = vFr_3_up_nonActiveMaterial / vFr_3_up;

        % check whether the sum of all volume fractions is 1
        vFrPart3UpPart_total = vFrPart3UpPart_activeMaterial + vFrPart3UpPart_nonActiveMaterial;
        if abs(vFrPart3UpPart_total - 1) > esp
            error('The sum of volume fractions should be 1.')
        end
    else
        vFrPart3UpPart_activeMaterial = 0;
        vFrPart3UpPart_nonActiveMaterial = 0;
        % check whether the sum of all volume fractions in part 3 is 0
        vFrPart3UpPart_total = vFrPart3UpPart_activeMaterial + vFrPart3UpPart_nonActiveMaterial;
        if abs(vFrPart3UpPart_total) > esp
            error('The sum of volume fractions in part 3 should be 0.')
        end
    end
    

    
    % phi
    phi = vFrPart3UpPart_nonActiveMaterial;
    
    % B0 
    eval(['B0 = B_ZSM(@(r,B,alpha)',curveName,'(r,B,alpha),1,0,',num2str(phi),');'])
    
    % calculate RAdditive_1_part3
    vFr_additive = vFrMatrix_additive * (1 - porosity);
    if e == 1
        RAdditive_1_part3 = 0;
    else
        eval(['Func_VAdditive_1 = @(RAdditive_1_part3) volume8th_additive(@(r,B,alpha)',curveName,'(r,B0,0),RAdditive_1_part3);'])
        f_RAdditive_1_part3 = @(RAdditive_1_part3) ( Func_VAdditive_1(RAdditive_1_part3) / (pi / 4) / (1 - e) * (1 - c)  + RAdditive_1_part3^2 * c ) * R3^2 + vFr_2_down - vFr_additive;


        % calculate RAdditive using fsolve iteratively
        options = optimoptions('fsolve','Display','none','TolFun',1e-20);
        RAdditive_1_part3_iter = fsolve(f_RAdditive_1_part3,R3/2,options);
        
        % check whether RAdditive_1_part3_iter is valid
        if abs(f_RAdditive_1_part3(RAdditive_1_part3_iter))/ vFr_additive > VEsp
            error('Failed to find an accurate RAdditive_1_part3 (RAdditive_1_part3_iter = %.4f) for additive because of the inaccuracy (value: %.4f) of the calculated VAdditive_1_part3 using this RAdditive_1_part3_iter (value: %.4f) at RAdditive_1_part3_iter = % .4f. \n',RAdditive_1_part3_iter,abs(f_RAdditive_1_part3(RAdditive_1_part3_iter)) / vFr_additive,RAdditive_1_part3_iter);
        else
            RAdditive_1_part3 = RAdditive_1_part3_iter;
        end
    end
    
    % evaluate RAdditive_1_part3 using a corresponding definition as in part 1
    if c == 0
        vFr_matrixPassage = (1 - innerPorosity_in_additive) * (RAdditive_1_part3 * R3)^2  + (R2^2 - R3^2);
    else
        vFr_matrixPassage = (1 - innerPorosity_in_additive) * ((RAdditive_1_part3 * R3)^2  + (R2^2 - R3^2));
    end
    
    vFr_matrix = 1 - allPorosity;
    tortuosity_matrix = tortuosity_calculator(vFr_matrix,modeTortuosity);
    vFr_matrixPassage_theory = vFr_matrix / tortuosity_matrix;
    
    deviation_vFr_matrixPassage = (vFr_matrixPassage - vFr_matrixPassage_theory) / vFr_matrixPassage_theory;
    
    % calculate RAdditive_2_part3
    if e == 1
        vFr_additive_2 = vFr_additive - vFr_2_down;
    elseif e == 0
        vFr_additive_2 = 0;
    else
        vFr_additive_2 = vFr_additive - (( Func_VAdditive_1(RAdditive_1_part3) / (pi / 4) * (1 - c)  + RAdditive_1_part3^2 * c ) * R3^2 + vFr_2_down);
    end
    if vFr_additive_2 < 0 
        error('vFr_additive_2 is negative.')
    end   
    % dispersed additive in part 3, up-part
    vFr_additive_2_real = vFr_additive_2 * (1-innerPorosity_in_additive);   % volume fraction of the additive without inner porosity
    vFr_filler_in_additive_2 = vFr_additive_2 * innerPorosity_in_additive;  % volume fraction of filler in the inner porosity in additive 2
    vFr_3_up_filler = porosity - vFr_1 - R3^2 * c * (1 - RAdditive_1_part3^2) + vFr_filler_in_additive_2;
    if vFr_3_up_filler < 0 || vFr_3_up_filler > porosity
        error('vFr_3_up_filler is negative or bigger than the whole porosity')
    end
    vFrDispersed_additive_2_real = vFr_additive_2_real / (vFr_additive_2_real + vFr_3_up_filler);
    % calculating the thermal conductivity of the homogeneously dispersed additive system in filler (fluid) using EMT model
    k_dispersed = k_model_out_of_name_calculator([k_additive_pure;k_filler],vFrDispersed_additive_2_real,'none',0,modelAddInFiller);
    
    % thermal conductivity of each part
    k_1 = k_filler;
    if c == 0
        k_2 = k_activeMaterial;
    else
        k_2 = 1 / ( c / k_additive + (1 - c) / k_activeMaterial);
    end
    k_3_down = RAdditive_1_part3^2 * k_additive + (1 - RAdditive_1_part3^2) * k_filler;
    k_3_up = k_ZSM_additive_calculator(k_activeMaterial,k_dispersed,k_additive,curveName,1,B0,0,RAdditive_1_part3);
    if c == 0
        k_3 = k_3_up;
    else
        k_3 = 1 / (c / k_3_down + (1 - c) / k_3_up);
    end
    % check whether the sum of all volume fractions is 1
    vFr_total = vFr_1 + vFr_2 + vFr_3;
    if abs(vFr_total - 1) > esp
        error('The sum of the volume fractions should be 1.')
    end
    
    % the effective thermal conductivity: keff
    keff_1 = k_1 * vFr_1;
    keff_2 = k_2 * vFr_2;
    keff_3 = k_3 * vFr_3;
    keff = keff_1 + keff_2 + keff_3;
    % fprintf(' a = %.4f,\n B = %.4f,\n c = %.4f,\n RAdditive_1_part3 = %.4f,\n RAdditive_2_part3 = %.4f,\n R2 = %.4f.\n R3 = %.4f,\n RAdditive_1 = %.4f,\n RAdditive_2 = %.4f,\n deviation_vFr_matrixPassage = %.4f,\n k_additive = %.4f,\n keff_ZSM_3 = %.4f,\n\n',a,B0,c,RAdditive_1_part3,RAdditive_2_part3,R2,R3,R3 * RAdditive_1_part3,R3 * RAdditive_2_part3,deviation_vFr_matrixPassage,k_additive,keff)