%/mnt/benvenutiPFMDaten/Materials2Simulation2Application_RnR/BS/Luca_final/20131129_1059_limestone0-315_test03

clear all
close all
clc

load /mnt/scratchPFMDaten/Luca/testPolidispersityShearCellCokeCoarseCokeFineSinterFineLimestoneFineMatlab/DensityBulkBoxPreShearMaxTest.mat

[coeffShear40, coeffShear60, coeffShear80, coeffShear100, expFtd, expInp, expOut] = experimentalImport( '20131129_1059_limestone0-315_test03');
coeffPirker = 1.0;
densTolerance = 0.05;
fricTolerance = 0.05;

coeffPirker = 1.0;
densTolerance = 0.05;
fricTolerance = 0.05;


[nY2rows,nY2column] = size(newY2);

jjj=1;
kkk=1;
ii=1;
meanExpFtdRhoB = mean(expFtd.rhoB);
maxExpFtdRhoB  = max(expFtd.rhoB);
minExpFtdRhoB  = min(expFtd.rhoB);