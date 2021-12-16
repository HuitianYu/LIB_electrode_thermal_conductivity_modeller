%% VOLUME8TH This function calculates the volume of Rotator for additive in the first octant (one eighth) inside a radius RMax.

function eighthV = volume8th(curveR,RMax)
%% Explanations of input & output arguments:

    % curveR: e.g. @(r)curveRAreaContact(r,B,alpha)
    %               a function handle in form: @(r)function(r,a,b,...) and a, b and other variables must be specified.
    % RMax: the upper limit of approximated integration (Lower limit is 0).

%% Calculation of one eighth volume using infinitesimal method
    if RMax < 0 
        eighthV = NaN;
    else
        N = 1e5; % number of steps
        sumI = 0; % initial value of summation
        deltaR = RMax / N; % step size

        % summation for approximated integration
        for iR = 0 : N-1
            sumI = sumI + ( 2 * iR + 1 ) * curveR(deltaR * iR); % 2 * iR + 1 = (iR + 1)^2 - iR^2
        end
        eighthV = 0.25 * pi * deltaR^2 * sumI;
    end
