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
    load 20150721AoRpolidispersity.mat
    addpath('/mnt/DATA/liggghts/work/shearCell/matlab/exportFig');
    addpath('../../shearCell/matlab');
else
    %load S:\Luca\testPolidispersityShearCellCokeCoarseCokeFineSinterFineLimestoneFineMatlab\inputRadSigma.mat
    load R:\simulations\aor\20150721AoRMatlabAndFigures\20150721AoRpolidispersity.mat
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

% angleExp = 
% material = 
resAoR{1}.angleExp = 38.85;
resAoR{1}.material = 'sinter fine';


% gloriaAugustaAorNN = gloriaAugustaAorNN01;
% a = a01;

% angleExp = 
% material = 
%[ gloriaAugustaAorNN02, a02 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 2, material);
resAoR{2}.angleExp = 43.00;
resAoR{2}.material = 'ironore fine';
%resAoR{2}.gloriaAugustaAorNN = gloriaAugustaAorNN02;
%resAoR{2}.a = a02;

% angleExp = 
% material = 
%[ gloriaAugustaAorNN03, a03 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 3, material);
resAoR{3}.angleExp = 44.50;
resAoR{3}.material = 'limestone fine';
%resAoR{3}.gloriaAugustaAorNN = gloriaAugustaAorNN03;
%resAoR{3}.a = a03;


% angleExp = 
% material = 
%[ gloriaAugustaAorNN04, a04 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 4, material);
resAoR{4}.angleExp = 42.60;
resAoR{4}.material = 'coke fine';
%resAoR{4}.gloriaAugustaAorNN = gloriaAugustaAorNN04;
%resAoR{4}.a = a04;

% angleExp = 
% material = 
%[ gloriaAugustaAorNN05, a05 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 5, material);
resAoR{5}.angleExp = 37.7500;
resAoR{5}.material = 'limestone coarse';
%resAoR{5}.gloriaAugustaAorNN = gloriaAugustaAorNN05;
%resAoR{5}.a = a05;

% angleExp = 
% material = 
%[ gloriaAugustaAorNN06, a06 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 6, material);
resAoR{6}.angleExp = 39.0500;
resAoR{6}.material = 'sinter coarse';
%resAoR{6}.gloriaAugustaAorNN = gloriaAugustaAorNN06;
%resAoR{6}.a = a06;

% angleExp = 
% material = 
% [ gloriaAugustaAorNN07, a07 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 7, material);
resAoR{7}.angleExp = 40.90;
resAoR{7}.material = 'coke coarse';
% resAoR{7}.gloriaAugustaAorNN = gloriaAugustaAorNN07;
% resAoR{7}.a = a07;

% angleExp = 
% material = 
% [ gloriaAugustaAorNN08, a08 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 8, material);
resAoR{8}.angleExp = 33.85;
resAoR{8}.material = 'pellets';
% resAoR{8}.gloriaAugustaAorNN = gloriaAugustaAorNN08;
% resAoR{8}.a = a08;


% angleExp = 
% material = 
% [ gloriaAugustaAorNN9, a9 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 9, material);
resAoR{9}.angleExp = 44.15;
resAoR{9}.material = 'ironore coarse';
% resAoR{9}.gloriaAugustaAorNN = gloriaAugustaAorNN9;
% resAoR{9}.a = a9;

for ijk = 1:9
[ resAoR{ijk}.gloriaAugustaAorNN01, resAoR{ijk}.a01 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, resAoR{ijk}.angleExp, ijk, resAoR{ijk}.material);
end
