% Solve an Input-Output Fitting problem with a Neural Network
% Script generated by Neural Fitting app
% Created Sat Aug 01 09:43:59 CEST 2015
%
% This script assumes these variables are defined:
%
%   chemicalInputs - input data.
%   chemicalTargets - target data.

clear all
close all
clc
if (isunix)
    addpath('/mnt/DATA/liggghts/work/shearCell/matlab/exportFig');
    addpath(genpath('/mnt/DATA/liggghts/work/shearCell/matlab/tapas'));
    addpath(genpath('/mnt/DATA/liggghts/work/shearCell/matlab/gpml'));
else
    addpath('E:\liggghts\work\shearCell\matlab\exportFig');
    addpath(genpath('E:\liggghts\work\shearCell\matlab\tapas'));
    addpath(genpath('E:\liggghts\work\shearCell\matlab\gpml'));
end

load R:\simulations\shearCell\sinterFineMatlabData\radarPlot10070sinterfine0_1range.mat
tr2=NNSave2{errorEstSumMaxIndex2(2),2}.tr;
tr = tr2;

chemicalInputs = x2;
chemicalTargets = zz2(2,:);
x = chemicalInputs;
t = chemicalTargets;
ys4 = t(tr.testInd);

clearvars x2 zz2

if (false)
    % Choose a Training Function
    % For a list of all training functions type: help nntrain
    % 'trainlm' is usually fastest.
    % 'trainbr' takes longer but may be better for challenging problems.
    % 'trainscg' uses less memory. NFTOOL falls back to this in low memory situations.
    trainFcn = 'trainscg';  % Levenberg-Marquardt
    
    % Create a Fitting Network
    hiddenLayerSize = 30;
    net = fitnet(hiddenLayerSize,trainFcn);
    
    % Choose Input and Output Pre/Post-Processing Functions
    % For a list of all processing functions type: help nnprocess
    net.input.processFcns = {'removeconstantrows','mapminmax'};
    net.output.processFcns = {'removeconstantrows','mapminmax'};
    
    % Setup Division of Data for Training, Validation, Testing
    % For a list of all data division functions type: help nndivide
    net.divideFcn = 'dividerand';  % Divide data randomly
    net.divideMode = 'sample';  % Divide up every sample
    net.divideParam.trainRatio = 70/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;
    
    % Choose a Performance Function
    % For a list of all performance functions type: help nnperformance
    net.performFcn = 'mse';  % Mean squared error
    
    % Choose Plot Functions
    % For a list of all plot functions type: help nnplot
    net.plotFcns = {'plotperform','plottrainstate','ploterrhist', ...
        'plotregression', 'plotfit'};
    
    % Train the Network
    [net,tr] = train(net,x,t);
    
    % Test the Network
    y = net(x);
    e = gsubtract(t,y);
    performance = perform(net,t,y)
    
    % Recalculate Training, Validation and Test Performance
    trainTargets = t .* tr.trainMask{1};
    valTargets = t  .* tr.valMask{1};
    testTargets = t  .* tr.testMask{1};
    trainPerformance = perform(net,trainTargets,y);
    valPerformance = perform(net,valTargets,y);
    testPerformance = perform(net,testTargets,y);
    
    % View the Network
    %view(net)
    
    % Plots
    % Uncomment these lines to enable various plots.
    h1 = figure(1); plotperform(tr);
    h2 = figure(2); plottrainstate(tr);
    %h3 = figure(3); plotfit(net,x,t);
    
    h4 = figure(4); plotregression(ys4, y(tr.testInd));
    %h5 = figure(5); ploterrhist(e);
end
%% Bayesian linear regressor (tapas)

X = chemicalInputs(:,tr.trainInd);
y2 = chemicalTargets(:,tr.trainInd);
q = tapas_vblm(y2', X');
X2 = chemicalInputs(:,tr.testInd);
[m_new, y2_new] = tapas_vblm_predict(X2', q);
ys3 = ys4';
[q.r2 q.rmse] = rsquare(ys3, m_new);
q.mae = mae(ys3, m_new);
q.mse = mse(ys3, m_new);
h6 = figure(6); plotregression(ys3, m_new,'Bayesian linear regressor (tapas)');
set(gca,'fontname','times new roman','FontSize',20)  % Set it to times
set(h6, 'Position', [100 100 1500 800])
export_fig('BayesianLinearRegression','-jpg', '-nocrop', h6);

%% Gaussian process (a non-parametric probabilistic regressor)

x3 = chemicalInputs(:,tr.trainInd)';
y3 = chemicalTargets(:,tr.trainInd)';
covfunc = @covSEiso ;% { 'covSum', { 'covSEiso' } };
likfunc = @likGauss; 
%sn = 0.1; hyp.lik = log(sn);
hyp2.cov = [0 ; 0];
hyp2.lik = log(0.1);
hyp2 = minimize(hyp2, @gp, -100, @infExact, [], covfunc, likfunc, x3, y3);
exp(hyp2.lik);
nlml2 = gp(hyp2, @infExact, [], covfunc, likfunc, x3, y3);
%[m s2] = gp(hyp2, @infExact, [], covfunc, likfunc, x3, y3, x3);
xs = chemicalInputs(:,tr.testInd)';
% ys = chemicalTargets(:,tr.testInd)';
[g.nlZ g.dnlZ] = gp(hyp2, @infExact, [], covfunc, likfunc, x3, y3);
[ymu g.ys2 g.fmu g.fs2 g.lp] = gp(hyp2, @infExact, [], covfunc, likfunc, x3, y3, xs);
g.ymu = ymu;
[g.r2 g.rmse] = rsquare(ys3, ymu);
g.mae = mae(ys3, ymu);
g.mse = mse(ys3, ymu);
h7 = figure(7); plotregression(ys3, ymu,'Gaussian process (a non-parametric probabilistic regressor)');
set(gca,'fontname','times new roman','FontSize',20)  % Set it to times
set(h7, 'Position', [100 100 1500 800])
export_fig('GaussianNonLinearRegression','-jpg', '-nocrop', h7);

%% ANNs
% z = avgMuR1';
% iijj=1;
% for iijj=1:nSimCases
%     inputNN3(iijj,3)=data(iijj).rest;
%     inputNN3(iijj,1)=data(iijj).fric;
%     inputNN3(iijj,2)=data(iijj).rf;
%     
% 
%         inputNN3(iijj,4)=data(iijj).dt;
% 
%     
% 
%         inputNN3(iijj,5)=data(iijj).dCylDp;
% 
% 
%         inputNN3(iijj,6)=data(iijj).ctrlStress;
% 
% 
%  
%         inputNN3(iijj,7)=data(iijj).shearperc;
% 
%         inputNN3(iijj,8)=data(iijj).dens;
% 
% end   
% 
% inputNN4 = inputNN3';
% 
net2=NNSave2{errorEstSumMaxIndex2(2),2}.net;
% tr2=NNSave2{errorEstSumMaxIndex2(2),2}.tr;

yy = net2(x);

[n.r2 n.rmse] = rsquare(ys4,yy(tr.testInd));
n.mae = mae(ys4,yy(tr.testInd));
n.mse = mse(ys4,yy(tr.testInd));

h9 = figure(9);
% plotregression(z(tr.testInd),yy(tr.testInd),'ANNs Regression');
plotregression(ys4,yy(tr.testInd),'ANNs Regression');
set(gca,'fontname','times new roman','FontSize',20)  % Set it to times
set(h9, 'Position', [100 100 1500 800])
export_fig('ANNsRegression','-jpg', '-nocrop', h9);

%% Statistics on test samples errors

qNames = fieldnames(q);
i = 1;
for loopIndex = 9:numel(qNames) 
    StatMatrix(i,1) = q.(qNames{loopIndex});
    i = i + 1;
end

i = 1;
gNames = fieldnames(g); 
for loopIndex = 8:numel(gNames) 
    StatMatrix(i,2) = g.(gNames{loopIndex});
    i = i + 1;
end

nNames = fieldnames(n); 
for loopIndex = 1:numel(nNames) 
    StatMatrix(loopIndex,3) = n.(nNames{loopIndex});
end
