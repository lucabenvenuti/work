clear all
close all
clc

printFlag = true;
printOnlyFlag = true;

%%  1) import data fixed values
if (isunix)
    matFile1 =  '/mnt/benvenutiPFMDaten/simulations/aor/20150721AoRMatlabAndFigures/old/20150721AoRpolidispersityMultipleANNs.mat';
    matFile2 = '/mnt/benvenutiPFMDaten/simulations/input/inputDataNN8.mat';
    addpath('/mnt/DATA/liggghts/work/shearCell/matlab/exportFig');
    addpath('../../shearCell/matlab');
else
    matFile1 = 'R:\simulations\aor\20150721AoRMatlabAndFigures\old\20150721AoRpolidispersityMultipleANNs.mat';
    matFile2 = 'R:\simulations\input\inputDataNN8.mat';
    addpath('E:\liggghts\work\shearCell\matlab\exportFig');
    addpath('..\..\shearCell\matlab');
    addpath(genpath('E:\liggghts\work\shearCell\matlab'));
end

load(matFile1, 'nSimCases', 'dataAOR', 'angleLi', 'angleMa');

trainFcn = 'trainscg';
hiddenLayerSizeVector = [5:40];

if ~printOnlyFlag
    
    [NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2, numbersNeuronsWinner, NNSaveNeuronsWinner]...
        =   myNeuNetFunPolidispersity(nSimCases, dataAOR, trainFcn, hiddenLayerSizeVector, angleLi, angleMa);
    close all
else
    matFile3 =  'R:\simulations\aor\20160210AoRpolidispersity.mat';
    load(matFile3);
end

load(matFile2, 'dataNN2');
dataNN2.rest = dataNN2.rest(1:2:end);
dataNN2.rf = sort([dataNN2.rf(1:2:end)', 0.025:0.05:0.975]');
dataNN2.sf = sort([dataNN2.sf(1:2:end)', 0.025:0.05:0.975]');
dataNN2.dCylDp = 30;
dataNN2.dens = dataNN2.dens(1:2:end);
dataNN2 = rmfield(dataNN2, {'ctrlStress'});

% dataNN2.radmu = 0.001;
% dataNN2.radsigma = dataNN2.radsigma/10;


[ radius, rows, columns, radmu, radsigma ] = particleDistroFun;
resAoR{1}.angleExp = 40.90;
resAoR{1}.material = 'cokecoarse';
resAoR{2}.angleExp = 42.60;
resAoR{2}.material = 'cokefine';
resAoR{3}.angleExp = 44.15;
resAoR{3}.material = 'ironorecoarse';
resAoR{4}.angleExp = 43.00;
resAoR{4}.material = 'ironorefine';
resAoR{5}.angleExp = 37.7500;
resAoR{5}.material = 'limestonecoarse';
resAoR{6}.angleExp = 44.50;
resAoR{6}.material = 'limestonefine';
resAoR{7}.angleExp = 39.0500;
resAoR{7}.material = 'sintercoarse';
resAoR{8}.angleExp = 38.85;
resAoR{8}.material = 'sinterfine';

coeffPirker = 1.0;
angleTolerance = 0.05;

numFig = 213;
%%
for i = 1:8
    dataNN2.radmu = radmu(i);
    dataNN2.radsigma = radsigma(i);
    
    %%  5) create new input
    if ~printOnlyFlag
        newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);
        newY3 = newY2([1:3, 6, 8, 9],:);
        clearvars newY2
        
        %%  6) get gloria Augusta
        [ gloriaAugustaAor{i}, kkk ] = getGloriaAugustaAorPolidispersity( ...
            newY3, resAoR{i}.angleExp, coeffPirker, angleTolerance );
        clearvars newY3
    else
        kkk = 4;
    end
    
    %%  7) print
    %[ resAoR{i}.gloriaAugustaAorNN01, resAoR{i}.a01 ] = radarPrintAorVectorialPolidispersityFun(NNSave2, errorEstSumMaxIndex2, dataNN2, resAoR{i}.angleExp, i, resAoR{i}.material);
    
    if kkk > 3 && printFlag
        aorFlag = 1;
        %         numFig = numFig + 1;
        %         af{numFig} = radarPrintVectorialFun( gloriaAugustaAor{i}', aorFlag, numFig, dataNN2, resAoR{i}.material, coeffPirker);
        numFig = numFig + 1;
        af{numFig} = boxPlotFun( gloriaAugustaAor{i}', aorFlag, numFig, resAoR{i}.material, coeffPirker);
        numFig = numFig + 1;
        legend = 'CoR' ;
        af{numFig} = tilePlotFun2( gloriaAugustaAor{i}', aorFlag, numFig, resAoR{i}.material, legend, coeffPirker);
    else
        warning(['no valid values for ', resAoR{i}.material]);
    end
    
end

if ~printOnlyFlag
    save -v7.3 20160210AoRpolidispersity.mat
end