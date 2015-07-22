clear all
close all
clc

% load testPolidispersityAorCokeCoarseCokeFineSinterFineNew.mat
% load /mnt/scratchPFMDaten/Luca/testPolidispersityShearCellCokeCoarseCokeFineSinterFineLimestoneFineMatlab/testInputNNpolidispersity.mat
% addpath('../../shearCell/matlab');
%      exp_flag = true;

trainFcn = 'trainscg';


% clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2 col norm avgMuR2mean avgMuR1mean avgMuR2std avgMuR1std rhoBShearMaxmean rhoBShearMaxstd rhoBPreShearMaxmean rhoBPreShearMaxstd startMinAvgMuR2Min startMinAvgMuR2Index startMinAvgMuR1Min startMinAvgMuR1Index ...
%     startMinRhoPreMin startMinRhoPreIndex  startMinRhoPostMin startMinRhoPostIndex dataNN2

if (isunix)
    %load /mnt/scratchPFMDaten/Luca/testPolidispersityShearCellCokeCoarseCokeFineSinterFineLimestoneFineMatlab/inputRadSigma.mat
    load 20150721AoRpolidispersity
    addpath('/mnt/DATA/liggghts/work/shearCell/matlab/exportFig');
    addpath('../../shearCell/matlab');
else
    %load S:\Luca\testPolidispersityShearCellCokeCoarseCokeFineSinterFineLimestoneFineMatlab\inputRadSigma.mat
    load 20150721AoRpolidispersity
    load S:\Luca\testPolidispersityShearCellCokeCoarseCokeFineSinterFineLimestoneFineMatlab\inputRadSigma.mat
    addpath('E:\liggghts\work\shearCell\matlab\exportFig');
    addpath('..\..\shearCell\matlab');
end

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,dataAOR,trainFcn,hiddenLayerSizeVector, angleLi, angleMa);

dataNN2.rest = dataNN2.rest(1:2:end);
dataNN2.rf = sort([dataNN2.rf(1:2:end)', 0.025:0.05:0.975]');
dataNN2.sf = sort([dataNN2.sf(1:2:end)', 0.025:0.05:0.975]');
dataNN2.ctrlStress = 5000; %1068;% [1068,2069,10070];
dataNN2.radmu = 0.001;
dataNN2.dens = [1000:500:4000]; %2500;
dataNN2.dCylDp= 30;
dataNN2.radsigma = dataNN2.radsigma/10;

dataNN2 = rmfield(dataNN2, {'ctrlStress'});


% dataNN2.radmu = 0.00184;
% dataNN2.radsigma = 0.00192;
% angleExp = 39.05; %sintercoarse
% [ gloriaAugustaAorNN01, a01 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 1);

angleExp = 38.85;
material = 'sinter fine';
[ gloriaAugustaAorNN02, a02 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 2, material);

angleExp = 43.00;
material = 'ironore fine';
[ gloriaAugustaAorNN03, a03 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 3, material);

angleExp = 44.50;
material = 'limestone fine';
[ gloriaAugustaAorNN04, a04 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 4, material);

angleExp = 42.60;
material = 'coke fine';
[ gloriaAugustaAorNN05, a05 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 5, material);

angleExp = 37.7500;
material = 'limestone coarse';
[ gloriaAugustaAorNN06, a06 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 6, material);

angleExp = 39.0500;
material = 'sinter coarse';
[ gloriaAugustaAorNN07, a07 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 7, material);

angleExp = 40.90;
material = 'coke coarse';
[ gloriaAugustaAorNN08, a08 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 8, material);

angleExp = 33.85;
material = 'pellets';
[ gloriaAugustaAorNN09, a09 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 9, material);

angleExp = 44.15;
material = 'ironore coarse';
[ gloriaAugustaAorNN10, a10 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 10, material);


