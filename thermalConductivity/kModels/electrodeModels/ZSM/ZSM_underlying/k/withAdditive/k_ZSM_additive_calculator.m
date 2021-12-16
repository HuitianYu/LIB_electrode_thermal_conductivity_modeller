%% K_ZSM_ADDITIVE_CALCULATOR This function calculates the effective thermal conductivity with additive
% via thermal conductivities of solid and fluid material, form factor B and the radius of additive RAdditive,
% using Zehner Schlunder model.

function keff = k_ZSM_additive_calculator(kMatrix,kFiller,kAdditive,curveName,R,B,alpha,RAdditive)
%% Explanations of input & output arguments:

    % kMatrix: e.g. 180: numeric variable, the thermal conductivity of solid material.
    % kFiller: e.g. 0.1874: numeric variable, the thermal conductivity of fluid material.
    % kAdditive: e.g. 2: numeric variable, the thermal conductivity of additive.
    % curveName: e.g. 'curveRAreaContact': char array, the name of a function handle with variables (r,B,alpha).
    % R: e.g. 1.1: numeric variable, R >= 1.
    % B: e.g. 1: numeric variable, B >= 0.
    % alpha: e.g. 0.002: numeric variable, alpha >= 0.
    % RAdditive: e.g. 0.25: numeric variable for additive.
    
%% To calculate the effective thermal conductivity with additive using infinitesimal method

    % check whether RAdditive is in range
    RS = sqrt(1 - 1 / ( alpha * B + 1 )^2);
    if (RAdditive < RS && RAdditive > R)
        error(['RAdditive is out of range of [',num2str(RS),',',num2str(R),'].'])
    end
    
    
    N = 1e6; % number of steps
    deltaRM = 1 / N; % step length
    kMFTemp = 0; % initial value
    
    % summation of infinitesimal method for middle part, where all solid, additive and fluid exist 
    eval(['curveRBalpha = @(r,B,alpha)',curveName,'(r,B,alpha);'])
    
    % calculation all without pi
    if B == 0
        kMF = RAdditive^2 * kAdditive + ( 1 - RAdditive^2) * kFiller;
    elseif B == Inf
        kMF = kMatrix;
    else
        for iR = 0 : N -1
            ZMatrixR = curveRBalpha(deltaRM * (iR + 0.5),B,alpha);
            if deltaRM * iR < RAdditive % for additive-matrix part, 2 * iR + 1 = (iR + 1)^2 - iR^2, where deltaRM^2 is omiited.
                kMFTemp = kMFTemp + 1 / (ZMatrixR / kMatrix + (1 - ZMatrixR) / kAdditive) * (2 * iR + 1); % series --> parallel
            else % for filler-matrix part, 2 * iR + 1 = (iR + 1)^2 - iR^2, where deltaRM^2 is omiited.
                kMFTemp = kMFTemp + 1 / (ZMatrixR / kMatrix + (1 - ZMatrixR) / kFiller)* (2 * iR + 1); % series --> parallel
            end
        end
        kMF = kMFTemp * deltaRM^2;
    end
    
    % combine the middle part with free liquid surrounding the middle part with series model
    kTemp = 1 / R^2 * kMF + (1 - 1 / R^2) * kFiller;
    
    if kTemp > max(kMatrix,kFiller) % if statement to avoid rounding error
        keff = max(kMatrix,kFiller);
    elseif kTemp < min(kMatrix,kFiller)
        keff = min(kMatrix,kFiller);
    else
        keff = kTemp;
    end