%% K_ZSM_4_CALCULATOR This function calculates the effective thermal conductivity of active material, conductive additve, binder filled with filler.
% part 1: only filler (up-part & down-part), part 2: active material (up-part) + extra additive (conductive additive + binder, down part)
% part 3:   up-part: point contact Zehner-Schlunder model with activematerial,
%           additive (conductive additive + binder) accumulated around the neck (1-e) and homogeneously dispersed in filler (e) not only in up-part but also in down-part
%           down-part: additive + filler + homogeneously dispered additive in filler from neck
% upper-part: 1 - c, down-part: c.

function keff = k_ZSM_4_calculator(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity,curveName,modelAdditiveName,modeTortuosity,a,c,e,g)
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
    % e: e.g. 0.1: numeric variable in range of [0,1], disperse level in part 3, upper part.
    % g: e.g. 0.2: numeric variable. ratio of inner porosity to additive volume.    
    % keff: effecitive thermal conductivity: numeric variable > 0.
    
%% Calculation of effective thermal conductivity

    if ischar(c) && strcmp(c,'automatic')

        % set the maximal difference
        deviationEsp = 1e-3;
        cEsp = 0.0001;

        % calculate the best c and correspondent keff iteratively
        tic;
        fprintf('keff is being automatically calculated by adjusting the value c for porosity = %6.4f ...\n',porosity)
        if porosity == 1
            keff = thermalConductivityFiller;
        else
            Func_deviation_vFr_matrixPassage = @(c) k_ZSM_4_underlying(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity,curveName,modelAdditiveName,modeTortuosity,a,c,e,g);
            c_left = 0;
            if abs(Func_deviation_vFr_matrixPassage(c_left)) < deviationEsp
                [deviation,keff] = k_ZSM_4_underlying(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity,...
                    curveName,modelAdditiveName,modeTortuosity,a,c_left,e,g);    
                fprintf('IDEAL: Calculation completed with c_left = %6.4f, deviation = %6.4f.\n',c_left,deviation)
            else
                c_right = 1;
                c_middle = (c_left + c_right)/2;
                try
                    [deviation,~] = Func_deviation_vFr_matrixPassage(c_middle);
                    cExist = true;
                catch
                    cExist = false;
                    deviation = deviationEsp + 1;
                end
                while ~(c_right - c_left <= cEsp || (c_right - c_left > cEsp && abs(deviation) < deviationEsp))
                    if ~logical(cExist)
                        c_right = c_middle;
                    else
                        if deviation > 0
                            c_left = c_middle;
                        else
                            c_right = c_middle;   
                        end
                    end
                    c_middle = (c_left + c_right)/2;
                    try
                        [deviation,~] = Func_deviation_vFr_matrixPassage(c_middle);
                        cExist = true;
                    catch
                        cExist = false;
                        deviation = deviationEsp + 1;
                    end
                end

                if cExist
                    [deviation,keff] = k_ZSM_4_underlying(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity,...
                        curveName,modelAdditiveName,modeTortuosity,a,c_middle,e,g); 
                    if abs(deviation) < deviationEsp
                        fprintf('IDEAL')
                    else
                        fprintf('COMPROMISE')
                    end
                    fprintf(': Calculation completed with c_middle = %6.4f, deviation = %6.4f, c_right - c_left = %6.4f,\n',c_middle,deviation,c_right-c_left)
                else
                    [deviation,keff] = k_ZSM_4_underlying(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity,...
                        curveName,modelAdditiveName,modeTortuosity,a,c_left,e,g); 
                    fprintf('COMPROMISE: Calculation completed with c_left = %6.4f, deviation = %6.4f, c_right - c_left = %6.4f,\n',c_left,deviation,c_right-c_left)
                end
            end
            toc
        end

    elseif isnumeric(c)
        c_res = c;
        [~,keff] = k_ZSM_4_underlying(thermalConductivitiesMatrix,volumeFractionsMatrix,thermalConductivityFiller,porosity,curveName,modelAdditiveName,modeTortuosity,a,c_res,e,g);
    else
        error('Invalid input of c.')
    end
