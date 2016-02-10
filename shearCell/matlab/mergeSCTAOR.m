clear all
close all
clc

printFlag = true;
printOnlyFlag = false;

%%  1) import data fixed values

matFile1 = 'R:\simulations\shearCell\testPolidispersity20160209SCTFinal.mat';
matFile2 = 'R:\simulations\aor\20160210AoRpolidispersity.mat';

load(matFile1, 'gloria*');
load(matFile2, 'gloria*');

[ expList, gloriaSCT, gloriaAOR, Cia, ia, ib ] = gloriaIntersectFun( gloriaAugustaSchulzeNNDens, gloriaAugustaAor );

numFig = 237;
coeffPirker = 1;

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

save -v7.3 testMerge20160210Final.mat

