clear all
close all
clc

printFlag = true;
printOnlyFlag = true;

if (isunix)
    addpath(genpath('/mnt/DATA/liggghts/work/shearCell/matlab'));
else
    addpath(genpath('E:\liggghts\work\shearCell\matlab'));
end

%%  1) import data fixed values

matFile1 = 'R:\simulations\shearCell\testPolidispersity20160209SCTFinal.mat';
matFile2 = 'R:\simulations\aor\20160210AoRpolidispersity.mat';

load(matFile1, 'gloria*');
load(matFile2, 'gloria*');

if ~printOnlyFlag
    [ expList, gloriaSCT, gloriaAOR, Cia, ia, ib ] = gloriaIntersectFun( gloriaAugustaSchulzeNNDens, gloriaAugustaAor );
else
    matFile3 = 'R:\simulations\intersection\testMerge20160210Final.mat';
    load(matFile3);
end

numFig = 237;
coeffPirker = 1;

if (printFlag)
    
    for i = 1:33
        %%  7) print
        exp_file_name = expList{i, 1};
        if length(ia{i}) > 3 && printFlag
            aorFlag = 2;
            %         numFig = numFig + 1;
            %         af{numFig} = radarPrintVectorialFun( Cia{i}', aorFlag, numFig, dataNN2, exp_file_name, coeffPirker);
            numFig = numFig + 1;
            af{numFig} = boxPlotFun( Cia{i}', aorFlag, numFig, exp_file_name, coeffPirker);
            numFig = numFig + 1;
            legend = 'CoR' ;
            af{numFig} = tilePlotFun2( Cia{i}', aorFlag, numFig, exp_file_name, legend, coeffPirker);
        else
            warning(['no valid values for ', exp_file_name]);
        end
        
    end
end
if ~printOnlyFlag
    save -v7.3 testMerge20160210Final.mat
end
