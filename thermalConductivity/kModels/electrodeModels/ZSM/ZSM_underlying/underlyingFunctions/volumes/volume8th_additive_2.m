%% VOLUME8TH_ADDITIVE_2 This function calculates the volume of Rotator for additive, which accumulates at the side of active material particle, in the first octant (one eighth) inside a radius RMax.

function eighthV_additive_2 = volume8th_additive_2(curveR,RMin)
%% Explanations of input & output arguments:

    % curveR: e.g. @(r)curveRAreaContact(r,B,alpha)
    %               a function handle in form: @(r)function(r,a,b,...) and a, b and other variables must be specified.
    % RMin: the lower limit of approximated integration (Upper limit is 1) for radius.

%% Calculation of one eighth volume using infinitesimal method
    

    if RMin > 1 || RMin < 0
        eighthV_additive_2 = NaN;
    else
        N = 1e5; % number of steps
        sumI = 0; % initial value of summation
        deltaR = (1 - RMin) / N; % step size

        ZMax = curveR(RMin);
        % summation for approximated integration
        for iR = 0 : N-1
            sumI = sumI + (ZMax - curveR(RMin + deltaR * iR)) * (2 * RMin + deltaR * (2 * iR + 1));
        end
        eighthV_additive_2 = 0.25 * pi * deltaR * sumI;
    end
