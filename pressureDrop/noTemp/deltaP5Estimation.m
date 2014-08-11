function dP01MMean = deltaP5Estimation(dP1MMean2,dP9MMean2,dP8MMean2,dP5MMean2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    %bedPressure=[corrFunData(j).vTuyKnowMean,corrFunData(j).dP1MMean,corrFunData(j).dP9MMean,corrFunData(j).dP8MMean,corrFunData(j).dP5MMean];
    
    simulationHeight = 0.1; %[m]
    
    sensorsPositions=[1 0.9 0.8 0.5]; %[m]
    deltaPMean = abs([dP1MMean2 dP9MMean2 dP8MMean2 dP5MMean2 ]);
    
    [xData, yData] = prepareCurveData( sensorsPositions, deltaPMean );

    % Set up fittype and options.
    ft = fittype( 'gauss1' );
    opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
    opts.Display = 'Off';
    opts.Lower = [-1e300 -1e300 0];
    opts.StartPoint = [22224.351945706 1 0.097653647094335];

    % Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );


    a1=fitresult.a1;
    b1=fitresult.b1;
    c1=fitresult.c1;
    dP01MMean = a1*exp(-((simulationHeight-b1)/c1)^2);  %if  simulationHeight = 0.1, otherwise you could want to change the name
end

