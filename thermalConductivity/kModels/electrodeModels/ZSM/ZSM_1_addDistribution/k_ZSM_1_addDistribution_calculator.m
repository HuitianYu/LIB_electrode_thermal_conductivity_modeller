%% K_ZSM_1_ADDDISTRIBUTION_CALCULATOR This function calculates the effective thermal conductivity of active material, conductive additve, binder filled with filler,
%  where the flowing mixture of additive system is not homogenoeous distributed perpendicular through the electrode layer.
% part 1: only filler (up-part & down-part), part 2: active material (up-part) + extra additive (conductive additive, down part)
% part 3:   point contact Zehner-Schlunder model with activematerial, additive and filler as up-part;
%           with extra additive and filler correspondently in down-part.
% upper-part: 1 - c, down-part: c.
% neck part of additive in upper part of part 3: 1 - e, side part of additive: e.

function keff = k_ZSM_1_addDistribution_calculator(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity,curveName,modelAdditiveName,modeTortuosity,a,c,e,g,addDistribution,addDisPar)
%% Explanations of input & output arguments:

    % thermalConductivitiesMatrix: e.g. [180;0.1874;2.5]: 3 * 1 numeric array of thermal conductivities for active material, conductive additive andbinder respectively.
    % volumeFractionsMatrix: e.g. [0.9;0.05]: 2 * 1 numeric array for active material and conductive additive respectively.
    %                       The sum should not exceed 1. The last one for binder can be omitted.
    % thermalConductivityFiller: e.g. 0.026: numeric variable.
    % porosity: e.g. 0.2657, numeric variable, the volume fraction of fluid.
    % curveName: e.g. 'curveRAreaContact': char array, the name of a function handle with variables (r,B,alpha).
    % modelAdditiveName:     e.g. 'parallelModel','EMTN','EMTN,f=6','krischerModel,a=0.5','LNM,kE=2.5,phiM=0.637','MEM1,f=3': char array, which contains the following input parameters:
    %                   whose corresponding k_model_calculator contains the following input arguments:
    %                   (thermalconductivities,volumeFractions,n).
    % modeTortuosity: e.g. 1, numeric varible. The mode is from 1 to 3.
    % a: e.g. 0, numeric variable, the volume fraction of active material in part 2 in active material. a is in range of [0,1].
    % c:  e.g. 0.002, numeric variable, the volume ratio of down-part in range of [0,1].
    %     or 'automatic': char array.
    % e: e.g. 0.1: numeric variable in range of [0,1].
    % g: e.g. 0.2: numeric variable. ratio of inner porosity to additive volume. 
    % addDistribution: e.g. 'linear' or [0.1;0.2;0.3;0.4]: char array or n * 1 numeric array, which represents the distribution from the current collector to the interphase.
    % addDisPar: e.g. 0.1 or 'none': numeric variable or char array.
    % keff: effecitive thermal conductivity: numeric variable > 0.
    
%% Calculation of effective thermal conductivity

    vFr_porosity_avg = porosity;
    vFr_add_avg = (1 - volumeFractionsMatrix(1,1)) * (1 - porosity);
    vFr_moveable = vFr_porosity_avg + vFr_add_avg;
    vFr_add_inMoveable_avg = vFr_add_avg / vFr_moveable;
    if ischar(addDistribution)
        if strcmp(addDistribution,'linear')
                try
                    f_vFr_add_inMoveable = @(x) addDisPar * (x - 0.5) + vFr_add_inMoveable_avg;
                catch
                    error('''addDisPar'' doesn''t match ''addDistribution''.')
                end
        end
        deltaX = 0.1;
        x = (0:deltaX:1)';    
        x_avg = 0.5 * (x(1:size(x,1) - 1,1) + x(2:size(x,1),1));    
        vFr_add_inMoveable = arrayfun(f_vFr_add_inMoveable,x_avg);
        vFr_add = vFr_add_inMoveable * vFr_moveable;
        vFr_porosity = (1 - vFr_add_inMoveable) * vFr_moveable;
    elseif isnumeric(addDistribution)
        try
            n_addDistribution = size(addDistribution,1);
            x = linspace(0,1,n_addDistribution + 1)';
            deltaX = 1.0 / n_addDistribution;
            x_avg = 0.5 * (x(1:size(x,1) - 1,1) + x(2:size(x,1),1));
            vFr_add = addDistribution / mean(addDistribution) * vFr_add_avg;
            vFr_porosity = vFr_moveable - vFr_add;
        catch
            error('''addDisPar'' may not match ''addDistribution'' or vFr_porosity may be negative.')
        end
    else
        error('Invalid input of variable for ''addDistribution''.')
        
    end
    keff_layers = zeros(size(x_avg,1),1);
    ratio_add = volumeFractionsMatrix(2,1) / (1 - volumeFractionsMatrix(1,1));
   for ii = 1 : size(x_avg,1)
       vFr_matrix_tmp = [volumeFractionsMatrix(1,1) * (1 - porosity);vFr_add(ii,1) * ratio_add; vFr_add(ii,1) * (1 - ratio_add)] / sum([volumeFractionsMatrix(1,1) * (1 - porosity);vFr_add(ii,1) * ratio_add; vFr_add(ii,1) * (1 - ratio_add)],1);
       if any(vFr_matrix_tmp <= 0)
           error('''vFr_matrix_tmp'' contains non-positive element.')
       end
       keff_layers(ii,1) = k_ZSM_1_calculator(thermalConductivitiesMatrix,vFr_matrix_tmp,thermalConductivityFiller,vFr_porosity(ii,1),curveName,modelAdditiveName,modeTortuosity,a,c,e,g);
   end
   clear ii
   keff = k_seriesModel_calculator(keff_layers,deltaX * ones(size(x_avg,1),1),'none',0);