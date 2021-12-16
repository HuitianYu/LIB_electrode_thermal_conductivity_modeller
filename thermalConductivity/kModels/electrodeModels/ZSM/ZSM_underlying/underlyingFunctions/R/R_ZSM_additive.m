%% R_ZSM_ADDITIVE This function calculates RAdditive out of B0, alpha0 and phi0.
% RAdditive is the outer radius of addtive, which accumulates around the neck of
% of two connected particles and forms a ring. 
% RAdditive > RS and RAdditive < R_UpperLimit.
% phi is the volume fraction of filling fluid and additive. phi is in range of [0,1].

function RAdditive = R_ZSM_additive(curveRBalpha,B0,alpha0,phi0,eighthVolumeAdditive) 
%% Explanations of input & output arguments:

    % curveRBalpha: e.g. @(r,B,alpha)curveRAreaContact(r,B,alpha)
    %               a function handle in form: @(r,B,alpha)function(r,B,alpha,a,b,...) and a, b and other variables must be specified.
    % B0: e.g. 1: numeric variable, B >= 0.
    % alpha0: e.g. 0.002: numeric variable, alpha >= 0.
    % phi0: e.g. 0.5: numeric variable, phi is in range of [0,1].
    % eighthVolumeAdditive: one eighth volume of additive.

%% To calculate the outer radius of additive
    
    % calculate RS (contact radius) and R_UpperLimit (outer radius of fluid surrounding the particle)
    RS = sqrt(1 - 1 / ( alpha0 * B0 + 1 )^2);
    R_UpperLimit = R_ZSM(curveRBalpha,B0,alpha0,phi0);
    
    % set some error ranges
    VEsp = 1e-3;
    V_8thEsp = 1e-10;
    REsp = 1e-5;
    
    % classified calculation for R to simplify some calculation
    if eighthVolumeAdditive < 0
        error('There is no result because the eighthVolumeAdditive is non-positive.')
    elseif eighthVolumeAdditive >= 0 && eighthVolumeAdditive < V_8thEsp
        if alpha0 ~= 0
            fprintf('At the edge: RAdd = RS = %.4f.\n',RS)
        end
        RAdditive = RS;
    else
        
        % calculate RAdditive using fsolve iteratively
        f = @(RMax)volume8th_additive(@(r,B,alpha)curveRBalpha(r,B0,alpha0),RMax) - eighthVolumeAdditive;
        
        options = optimoptions('fsolve','Display','none','TolFun',1e-20);
        RAdditive_iter = fsolve(f,...
            (RS + R_UpperLimit)/2,options);
        
        %{
        RAdditive_iter = fzero(f,(RS + R_UpperLimit) / 2);
        %}
        % verify whether the RAdditive_iter is meaningful
        if RAdditive_iter - R_UpperLimit > REsp
            error(['Calculated RAdditive (RAdditive_iter = %.4f) ',...
                'for additive exceeds the boundary (R_UpperLimit = %.4f).'],...
                RAdditive_iter,R_UpperLimit)
        elseif RAdditive_iter <  RS
            error('RAdditive_iter (RAdditive_iter = %.4f) cannot be smaller than RS (RS = %.4f).',...
                RAdditive_iter,RS)
        else
            if RAdditive_iter > R_UpperLimit
                RAdditive_iter = R_UpperLimit;
            end
            % calculate V_iter with the above iterated RAdditive_iter to test the accuracy of B_iter with the input eighthVolumeAdditive
            VAdditive_iter = volume8th_additive(@(r,B,alpha)curveRBalpha(r,B0,alpha0),RAdditive_iter);
            if abs(VAdditive_iter - eighthVolumeAdditive)/eighthVolumeAdditive >= VEsp
                error(['Failed to find an accurate RAdditive (RAdditive_iter = %.4f) for additive,',...
                    ' because of the inaccuracy ratio (value: %.4f , VAdditive_iter = %.4f) ',...
                    'of the calculated VAdditive using this RAdditive_iter (value: %.4f) ',...
                    'at eighthVolumeAdditive = % .4f, alpha = %.4f, phi = %.4f and RS = %.4f. \n'],...
                    RAdditive_iter,abs(VAdditive_iter - eighthVolumeAdditive)/eighthVolumeAdditive,...
                    VAdditive_iter,RAdditive_iter,eighthVolumeAdditive,alpha0,phi0,RS);
            else
                RAdditive = RAdditive_iter; % the final result
            end
        end
    end