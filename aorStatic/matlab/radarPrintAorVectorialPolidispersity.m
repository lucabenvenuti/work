     clear all
     close all
     clc
     
     load testPolidispersityAorCokeCoarseCokeFineSinterFineNew.mat
     load /mnt/scratchPFMDaten/Luca/testPolidispersityShearCellCokeCoarseCokeFineSinterFineLimestoneFineMatlab/testInputNNpolidispersity.mat
    addpath('../../shearCell/matlab');
%      exp_flag = true;
     
dataNN2 = rmfield(dataNN2, {'ctrlStress'});


dataNN2.radmu = 0.00184;
dataNN2.radsigma = 0.00192;
angleExp = 39.0500; %sintercoarse
[ gloriaAugustaAorNN01, a01 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 1);

dataNN2.radmu = 0.00155;
dataNN2.radsigma = 0.00147;
angleExp = 37.7500; %limestonecoarse
[ gloriaAugustaAorNN02, a02 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, angleExp, 2);
