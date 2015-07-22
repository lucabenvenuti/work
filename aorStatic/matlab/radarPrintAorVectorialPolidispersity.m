clear all
close all
clc

trainFcn = 'trainscg';

if (isunix)
    load /mnt/benvenutiPFMDaten/simulations/aor/20150721AoRMatlabAndFigures/20150721AoRpolidispersity.mat
    load /mnt/scratchPFMDaten/Luca/testPolidispersityShearCellCokeCoarseCokeFineSinterFineLimestoneFineMatlab/inputRadSigma.mat
    addpath('/mnt/DATA/liggghts/work/shearCell/matlab/exportFig');
    addpath('../../shearCell/matlab');
else
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

resAoR{1}.angleExp = 38.85;
resAoR{1}.material = 'sinter fine';
resAoR{2}.angleExp = 43.00;
resAoR{2}.material = 'ironore fine';
resAoR{3}.angleExp = 44.50;
resAoR{3}.material = 'limestone fine';
resAoR{4}.angleExp = 42.60;
resAoR{4}.material = 'coke fine';
resAoR{5}.angleExp = 37.7500;
resAoR{5}.material = 'limestone coarse';
resAoR{6}.angleExp = 39.0500;
resAoR{6}.material = 'sinter coarse';
resAoR{7}.angleExp = 40.90;
resAoR{7}.material = 'coke coarse';
resAoR{8}.angleExp = 33.85;
resAoR{8}.material = 'pellets';
resAoR{9}.angleExp = 44.15;
resAoR{9}.material = 'ironore coarse';

for ijk = 1:9
[ resAoR{ijk}.gloriaAugustaAorNN01, resAoR{ijk}.a01 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, resAoR{ijk}.angleExp, ijk, resAoR{ijk}.material);
end

% save -v7.3 20150721AoRpolidispersityMultipleANNsTris.mat