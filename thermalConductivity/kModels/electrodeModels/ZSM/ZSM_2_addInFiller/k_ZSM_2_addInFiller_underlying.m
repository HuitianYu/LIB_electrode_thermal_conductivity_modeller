%% K_ZSM_2_ADDINFILLER_UNDERLYING This function calculates the effective thermal conductivity of active material, conductive additve, binder filled with filler.
% part 1: only filler (up-part & down-part),
% part 2:   area contact Zehner-Schlunder model with activematerial, additives(1 and 2) and filler as up-part;
%           with extra additive and filler correspondently in down-part.
% upper-part: 1 - c, down-part: c.
% neck part of additive in upper part of part 3: 1 - e, side part of additive: e.

function [deviation_vFr_matrixPassage,keff] = k_ZSM_2_addInFiller_underlying(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,allPorosity,curveName,modelAdditiveName,modeTortuosity,alpha0,c,e,g,modelAddInFillerName)
%% Explanations of input & output arguments:

    % thermalConductivitiesMatrix: e.g. [180;0.1874;2.5]: 3 * 1 numeric array of thermal conductivities for active material, conductive additive andbinder respectively.
    % volumeFractionsMatrix: e.g. [0.9;0.05]: 2 * 1 numeric array for active material and conductive additive respectively.
    %                       The sum should not exceed 1. The last one for binder can be omitted.
    % thermalConductivityFiller: e.g. 0.026: numeric variable.
    % allPorosity: e.g. 0.2657, numeric variable, the volume fraction of fluid.
    % curveName: e.g. 'curveRAreaContact': char array, the name of a function handle with variables (r,B,alpha).
    % modelAdditiveName:     e.g. 'parallelModel','EMTN','EMTN,f=6','krischerModel,a=0.5','LNM,kE=2.5,phiM=0.637','MEM1,f=3': char array, which contains the following input parameters:
    %                   whose corresponding k_model_calculator contains the following input arguments:
    %                   (thermalconductivities,volumeFractions,n).
    % modeTortuosity: e.g. 1, numeric varible. The mode is from 1 to 3.
    % alpha0: e.g. 0, numeric variable, the contact area factor. 0 is point contact.
    % c: e.g. 0.002, numeric variable, the volume ratio of down-part in range of [0,1].
    % deviation_vFr_matrixPassage: numeric variable.
    % keff: effecitive thermal conductivity: numeric variable > 0.
    % e: e.g. 0.1: numeric variable in range of [0,1].
    % g: e.g. 0.2: numeric variable. ratio of inner porosity to additive volume.
    % modelAddInFillerName: e.g. 'EMT,f=6': char array, model for additive system in filler.
    
%% Calculation of effective thermal conductivity

    % set the maximal difference
    esp = 1e-5;
    VEsp = 1e-10;

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
   
    porosity = allPorosity - (1 - allPorosity) * (vFrMatrix_conductiveAdditive_pure + vFrMatrix_binder_pure) / (1 - innerPorosity_in_additive) * innerPorosity_in_additive;
    
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
    k_additive = k_model_out_of_name_calculator([k_additive_pure;k_filler],1 - innerPorosity_in_additive,'none',0,modelAddInFillerName);
    
    % tortuosity
    tortuosity = tortuosity_calculator(porosity,modeTortuosity);

    % calculate volume fractions of part 1 and those of its components: fluid
    vFr_1_down = porosity / tortuosity * c;
    vFr_1_up = porosity / tortuosity * (1 - c);
    vFr_1 = vFr_1_down + vFr_1_up;
    
    % calculate the outer radius of part 2
    if vFr_1 > 1 + esp
        error('Negative value is under square.')
    elseif vFr_1 > 1 && vFr_1 <= 1 + esp4
        R2 = 0;
    else
        R2 = sqrt(1 - vFr_1);
    end
    
    % calculate volume fractions of part 2
    vFr_2_down = c - vFr_1_down; % only non-additive (additive + fluid)
    if vFr_2_down < -esp 
        error('vFr_2_down is negative.')
    elseif vFr_2_down >= -esp && vFr_2_down < 0 
        vFr_2_down = 0;
    end
    vFr_2_up_activeMaterial = vFrMatrix_activeMaterial * (1 - porosity); % active material in part 2, up-part
    if c == 0
        vFr_2 = R2^2;
        vFr_2_up = vFr_2;
    else
        vFr_2 = vFr_2_down / c;
        if abs(vFr_2 - R2^2) > esp
            error('The rounding error is too big!')
        end
        vFr_2_up = vFr_2 * (1 - c); % ZSM
    end
    
    vFr_2_up_nonActiveMaterial = vFr_2_up - vFr_2_up_activeMaterial; % non-active material in part 2 up-part
    if vFr_2_up_nonActiveMaterial < -esp
        error('c is too big or a is too small that vFr_2_up_NA is negative.')
    elseif vFr_2_up_nonActiveMaterial >= -esp && vFr_2_up_nonActiveMaterial < 0
        vFr_2_up_nonActiveMaterial = 0;
    end
    
    % calculate volume fractions in upper part of part 2
    if vFr_2_up ~= 0
        vFrPart2UpPart_activeMaterial = vFr_2_up_activeMaterial / vFr_2_up;
        vFrPart2UpPart_nonActiveMaterial = vFr_2_up_nonActiveMaterial / vFr_2_up;

        % check whether the sum of all volume fractions is 1
        vFrPart2UpPart_total = vFrPart2UpPart_activeMaterial + vFrPart2UpPart_nonActiveMaterial;
        if abs(vFrPart2UpPart_total - 1) > esp
            error('The sum of volume fractions should be 1.')
        end
    else
        vFrPart2UpPart_activeMaterial = 0;
        vFrPart2UpPart_nonActiveMaterial = 0;
        % check whether the sum of all volume fractions in part 2 is 0
        vFrPart2UpPart_total = vFrPart2UpPart_activeMaterial + vFrPart2UpPart_nonActiveMaterial;
        if abs(vFrPart2UpPart_total) > esp
            error('The sum of volume fractions in part 2 should be 0.')
        end
    end
    
    % phi
    phi = vFrPart2UpPart_nonActiveMaterial;
    
    % B0 
    eval(['B0 = B_ZSM(@(r,B,alpha)',curveName,'(r,B,alpha),1,alpha0,',num2str(phi),');'])
    
    % calculate RAdditive_1
    vFr_additive = vFrMatrix_additive * (1 - porosity);
    if e == 1
        RAdditive_1_part2 = 0;
    else
        eval(['Func_VAdditive_1 = @(RAdditive_1_part2) volume8th_additive(@(r,B,alpha)',curveName,'(r,B0,alpha0),RAdditive_1_part2);'])
        f_RAdditive_1_part2 = @(RAdditive_1_part2) (Func_VAdditive_1(RAdditive_1_part2) / (pi / 4) / (1 - e) * (1 - c) + RAdditive_1_part2^2 * c) * R2^2 - vFr_additive;


        % calculate RAdditive_1_part2 using fsolve iteratively
        options = optimoptions('fsolve','Display','none','TolFun',1e-20);
        RAdditive_1_part2_iter = fsolve(f_RAdditive_1_part2,R2/2,options);

        % check whether RAdditive_1_part2_iter is valid
        if abs(f_RAdditive_1_part2(RAdditive_1_part2_iter))/ vFr_additive > VEsp
            error('Failed to find an accurate RAdditive_1_part2 (RAdditive_1_part2_iter = %.4f) for additive because of the inaccuracy (value: %.4f) of the calculated VAdditive_1 using this RAdditive_1_part2_iter (value: %.4f) at RAdditive_1_part2_iter = % .4f. \n',RAdditive_1_part2_iter,abs(f_RAdditive_1_part2(RAdditive_1_part2_iter)) / vFr_additive,RAdditive_1_part2_iter);
        else
            RAdditive_1_part2 = RAdditive_1_part2_iter;
        end
    end
    % evaluate RAdditive_1_part2 using a corresponding definition as in part 1
    RS_1_part2 = sqrt(1 - 1 / (alpha0 * B0 + 1)^2);
    if c == 0
        vFr_matrixPassage = (1 - innerPorosity_in_additive) * ((RAdditive_1_part2 - RS_1_part2) * R2)^2 + (RS_1_part2 * R2)^2;
    else
        vFr_matrixPassage = (1 - innerPorosity_in_additive) * (RAdditive_1_part2 * R2)^2;
    end
    
    vFr_matrix = 1 - allPorosity;
    tortuosity_matrix = tortuosity_calculator(vFr_matrix,modeTortuosity);
    vFr_matrixPassage_theory = vFr_matrix / tortuosity_matrix;
    
    deviation_vFr_matrixPassage = (vFr_matrixPassage - vFr_matrixPassage_theory) / vFr_matrixPassage_theory;    

    % calculate RAdditive_2_part2
    if e == 0
        RAdditive_2_part2 = 1;
    else
        if e == 1
            vFr_additive_2 = vFr_additive;
        else
            vFr_additive_2 = vFr_additive - ((Func_VAdditive_1(RAdditive_1_part2) / (pi / 4) * (1 - c) + RAdditive_1_part2^2 * c) * R2^2);
        end
        if vFr_additive_2 < 0 
            error('vFr_additive_2 is negative.')
        end
        eval(['Func_VAdditive_2 = @(RAdditive_2_part2) volume8th_additive_2(@(r,B,alpha)',curveName,'(r,B0,0),RAdditive_2_part2);'])
        f_RAdditive_2_part2 = @(RAdditive_2_part2) Func_VAdditive_2(RAdditive_2_part2) / (pi / 4) * (1 - c) * R2^2 - vFr_additive_2;

        % calculate RAdditive_2_part2 using fsolve iteratively
        options = optimoptions('fsolve','Display','none','TolFun',1e-20);
        RAdditive_2_part2_iter = fsolve(f_RAdditive_2_part2,R2/2,options);

        % check whether RAdditive_2_part2_iter is valid
        if abs(f_RAdditive_2_part2(RAdditive_2_part2_iter))/ vFr_additive_2 > VEsp
            error('Failed to find an accurate RAdditive_2_part2 (RAdditive_2_part2_iter = %.4f) for additive because of the inaccuracy (value: %.4f) of the calculated VAdd using this RAdditive_2_part2_iter (value: %.4f) at RAdditive_2_part2_iter = % .4f. \n',RAdditive_2_part2_iter,abs(f_RAdditive_2_part2(RAdditive_2_part2_iter)) / vFr_additive_2,RAdditive_2_part2_iter);
        else
            RAdditive_2_part2 = RAdditive_2_part2_iter;
        end
    end
    % thermal conductivity of each part
    k_1 = k_filler;
    k_2_down = RAdditive_1_part2^2 * k_additive + (1 - RAdditive_1_part2^2) * k_filler;
    k_2_up = k_ZSM_additives_calculator(k_activeMaterial,k_filler,k_additive,curveName,1,B0,alpha0,RAdditive_1_part2,RAdditive_2_part2);
    if c == 0
        k_2 = k_2_up;
    else
        k_2 = 1 / (c / k_2_down + (1 - c) / k_2_up);
    end
    
    % check whether the sum of all volume fractions is 1
    vFr_total = vFr_1 + vFr_2;
    if abs(vFr_total - 1) > esp
        error('The sum of the volume fractions should be 1.')
    end
    
    % the effective thermal conductivity: keff
    keff_1 = k_1 * vFr_1;
    keff_2 = k_2 * vFr_2;
    keff = keff_1 + keff_2;
    % fprintf(' alpha = %.4f,\n B = %.4f,\n c = %.4f,\n RAdditive_1_Part2 = %.4f,\n RAdditive_2_Part2 = %.4f,\n R2 = %.4f,\n RAdditive_1 = %.4f,\n RAdditive_2 = %.4f,\n deviation_vFr_matrixPassage = %.4f,\n k_additive = %.4f,\n keff_ZSM_3 = %.4f,\n\n',alpha0,B0,c,RAdditive_1_part2,RAdditive_2_part2,R2,R2 * RAdditive_1_part2,R2 * RAdditive_2_part2,deviation_vFr_matrixPassage,k_additive,keff)