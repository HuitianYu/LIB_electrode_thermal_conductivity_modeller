%% R_ZSM_ADDITIVE_2 This function calculates RAdd out of B0, alpha0 and phi0.
% RAdd is the outer radius of addtive, which accumulates around the neck of
% of two connected particles and forms a ring. 
% RAdd > RS.
% phi is the volume fraction of filling fluid and additive. phi is in range of [0,1].

function RAdditive_2 = R_ZSM_additive_2(curveRBalpha,B0,alpha0,eighthVolumeAdditive_2) 
%% Explanations of input & output arguments:

    % curveRBalpha: e.g. @(r,B,alpha)curveRAreaContact(r,B,alpha)
    %               a function handle in form: @(r,B,alpha)function(r,B,alpha,a,b,...) and a, b and other variables must be specified.
    % B0: e.g. 1: numeric variable, B >= 0.
    % alpha0: e.g. 0.002: numeric variable, alpha >= 0.
    % eighthVolumeAdditive_2: one eighth volume of additive 2.

%% To calculate the outer radius of additive
    
    % calculate RS (contact radius)
    RS = sqrt(1 - 1 / ( alpha0 * B0 + 1 )^2);
    
    % set some error ranges
    VEsp = 1e-3;
    V_8thEsp = 1e-10;
    REsp = 1e-5;
    
    % check whether eighthVolumeAdditive_2 is valid
    eighthVolumeAdditive_2_max =...
        volume8th_additive(@(r)curveRBalpha(r,B0,alpha0),1);
    if eighthVolumeAdditive_2 > eighthVolumeAdditive_2_max
        error('eighthVolumeAdditive_2 is too big')
    elseif eighthVolumeAdditive_2 < 0
        error('There is no result because the eighthVolumeAdditive_2 is non-positive.')
    elseif eighthVolumeAdditive_2 >= 0 && eighthVolumeAdditive_2 < V_8thEsp
         RAdditive_2 = 1;
    else
        % calculate RAdditive_2 using fsolve iteratively
        f = @(RMin) volume8th_additive_2(@(r)curveRBalpha(r,B0,alpha0),RMin) - eighthVolumeAdditive_2;       
        options = optimoptions('fsolve','Display','none','TolFun',1e-20);
        RAdditive_2_iter = fsolve(f,(RS + 1)/2,options);
        
        if RAdditive_2_iter - 1 > REsp
            error(['Calculated RAdditive (RAdditive_iter_2 = %.4f) ',...
                'for additive exceeds the boundary 1.'],...
                RAdditive_2_iter)
        elseif RAdditive_2_iter <  RS
            error('RAdditive_2_iter (RAdditive_iter_2 = %.4f) cannot be smaller than RS (RS = %.4f).',...
                RAdditive_2_iter,RS)
        else
            if RAdditive_2_iter > 1
                RAdditive_2_iter = 1;
            end
            % calcultate VAdditive_2_iter to test whether RAdditive_iter is valid
            VAdditive_2_iter = volume8th_additive_2(@(r)curveRBalpha(r,B0,alpha0),RAdditive_2_iter);
            if abs(VAdditive_2_iter - eighthVolumeAdditive_2) / eighthVolumeAdditive_2 > VEsp 
                error(['Failed to find an accurate RAdditive_2 (RAdditive_2_iter = %.4f) for additive,',...
                    ' because of the inaccuracy ratio (value: %.4f , VAdditive_2_iter = %.4f) ',...
                    'of the calculated VAdditive_2 using this RAdditive_2_iter (value: %.4f) ',...
                    'at eighthVolumeAdditive_2 = % .4f, alpha = %.4f and RS = %.4f. \n'],...
                    RAdditive_2_iter,abs(VAdditive_2_iter - eighthVolumeAdditive_2)/eighthVolumeAdditive_2,...
                    VAdditive_2_iter,RAdditive_2_iter,eighthVolumeAdditive_2,alpha0,RS);
            else
                RAdditive_2 = RAdditive_2_iter; % the final value
            end
        end 
    end
    
