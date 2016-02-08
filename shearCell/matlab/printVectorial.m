clear all
close all
clc

if (isunix)
    addpath(genpath('/mnt/DATA/liggghts/work/shearCell/matlab'));
else
    addpath(genpath('E:\liggghts\work\shearCell\matlab'));
end

%%  1
matFile = 'R:\simulations\shearCell\sinterFineMatlabData\radarPlot1068sinterfine0_1rangePirker0dot8.mat';
load(matFile, 'gloriaAugustaSchulzeNN');
aorFlag = 0;
numFig = 1;
load(matFile, 'dataNN2');
load(matFile, 'exp_file');
exp_file_name = exp_file;
coeffPirker = 0.8;
a{numFig} = radarPrintVectorialFun( gloriaAugustaSchulzeNN, aorFlag, numFig, dataNN2, exp_file_name, coeffPirker);
numFig = numFig + 1;
%a{numFig} = boxPlotFun( gloriaAugustaSchulzeNN, aorFlag, numFig, exp_file_name, coeffPirker);
numFig = numFig + 1;
legend = 'CoR' ;
%a{numFig} = tilePlotFun2( gloriaAugustaSchulzeNN, aorFlag, numFig, exp_file_name, legend, coeffPirker);

clearvars matFile gloriaAugustaSchulzeNN aorFlag dataNN2 exp_file_name coeffPirker

%%  2
matFile = 'R:\simulations\shearCell\sinterFineMatlabData\radarPlot1068sinterfine0_1range.mat';
load(matFile, 'gloriaAugustaSchulzeNN');
aorFlag = 0;
numFig = numFig + 1;
load(matFile, 'dataNN2');
load(matFile, 'exp_file');
exp_file_name = exp_file;
coeffPirker = 1;
a{numFig} = radarPrintVectorialFun( gloriaAugustaSchulzeNN, aorFlag, numFig, dataNN2, exp_file_name, coeffPirker);
numFig = numFig + 1;
%a{numFig} = boxPlotFun( gloriaAugustaSchulzeNN, aorFlag, numFig, exp_file_name, coeffPirker);
numFig = numFig + 1;
legend = 'CoR' ;
%a{numFig} = tilePlotFun2( gloriaAugustaSchulzeNN, aorFlag, numFig, exp_file_name, legend, coeffPirker);

clearvars matFile gloriaAugustaSchulzeNN aorFlag dataNN2 exp_file_name coeffPirker

%%  3
matFile = 'R:\simulations\shearCell\sinterFineMatlabData\radarPlot1068sinterfine0_1rangePirker1dot2.mat';
load(matFile, 'gloriaAugustaSchulzeNN');
aorFlag = 0;
numFig = numFig + 1;
load(matFile, 'dataNN2');
load(matFile, 'exp_file');
exp_file_name = exp_file;
coeffPirker = 1.2;
a{numFig} = radarPrintVectorialFun( gloriaAugustaSchulzeNN, aorFlag, numFig, dataNN2, exp_file_name, coeffPirker);
numFig = numFig + 1;
%a{numFig} = boxPlotFun( gloriaAugustaSchulzeNN, aorFlag, numFig, exp_file_name, coeffPirker);
numFig = numFig + 1;
legend = 'CoR' ;
%a{numFig} = tilePlotFun2( gloriaAugustaSchulzeNN, aorFlag, numFig, exp_file_name, legend, coeffPirker);

clearvars matFile gloriaAugustaSchulzeNN aorFlag dataNN2 exp_file_name coeffPirker

%%  4
matFile = 'R:\simulations\shearCell\sinterFineMatlabData\radarPlot10070sinterfine0_1rangePirker0dot8.mat';
load(matFile, 'gloriaAugustaSchulzeNN');
aorFlag = 0;
numFig = numFig + 1;
load(matFile, 'dataNN2');
load(matFile, 'exp_file');
exp_file_name = exp_file;
coeffPirker = 0.8;
a{numFig} = radarPrintVectorialFun( gloriaAugustaSchulzeNN, aorFlag, numFig, dataNN2, exp_file_name, coeffPirker);
numFig = numFig + 1;
%a{numFig} = boxPlotFun( gloriaAugustaSchulzeNN, aorFlag, numFig, exp_file_name, coeffPirker);
numFig = numFig + 1;
legend = 'CoR' ;
% a{numFig} = tilePlotFun2( gloriaAugustaSchulzeNN, aorFlag, numFig, exp_file_name, legend, coeffPirker);

clearvars matFile gloriaAugustaSchulzeNN aorFlag dataNN2 exp_file_name coeffPirker

%%  5
matFile = 'R:\simulations\shearCell\sinterFineMatlabData\radarPlot10070sinterfine0_1range.mat';
load(matFile, 'gloriaAugustaSchulzeNN');
aorFlag = 0;
numFig = numFig + 1;
load(matFile, 'dataNN2');
load(matFile, 'exp_file');
exp_file_name = exp_file;
coeffPirker = 1;
a{numFig} = radarPrintVectorialFun( gloriaAugustaSchulzeNN, aorFlag, numFig, dataNN2, exp_file_name, coeffPirker);
numFig = numFig + 1;
% a{numFig} = boxPlotFun( gloriaAugustaSchulzeNN, aorFlag, numFig, exp_file_name, coeffPirker);
numFig = numFig + 1;
legend = 'CoR' ;
% a{numFig} = tilePlotFun2( gloriaAugustaSchulzeNN, aorFlag, numFig, exp_file_name, legend, coeffPirker);

clearvars matFile gloriaAugustaSchulzeNN aorFlag dataNN2 exp_file_name coeffPirker

%%
matFile = 'R:\simulations\shearCell\sinterFineMatlabData\radarPlot10070sinterfine0_1rangePirker1dot2.mat';
load(matFile, 'gloriaAugustaSchulzeNN');
aorFlag = 0;
numFig = numFig + 1;
load(matFile, 'dataNN2');
load(matFile, 'exp_file');
exp_file_name = exp_file;
coeffPirker = 1.2;
a{numFig} = radarPrintVectorialFun( gloriaAugustaSchulzeNN, aorFlag, numFig, dataNN2, exp_file_name, coeffPirker);
numFig = numFig + 1;
% a{numFig} = boxPlotFun( gloriaAugustaSchulzeNN, aorFlag, numFig, exp_file_name, coeffPirker);
numFig = numFig + 1;
legend = 'CoR' ;
% a{numFig} = tilePlotFun2( gloriaAugustaSchulzeNN, aorFlag, numFig, exp_file_name, legend, coeffPirker);

clearvars matFile gloriaAugustaSchulzeNN aorFlag dataNN2 exp_file_name coeffPirker

%%
matFile = 'R:\simulations\aor\matlab\radarPlotAORSinterfine0_1rangePirker1dot0EntireRange2Plot.mat';
load(matFile, 'gloriaAugustaSchulzeNN');
aorFlag = 1;
numFig = numFig + 1;
load(matFile, 'dataNN2');
load(matFile, 'exp_file');
exp_file_name = 'AoRSinterFine';
coeffPirker = 1.2;
a{numFig} = radarPrintVectorialFun( gloriaAugustaSchulzeNN, aorFlag, numFig, dataNN2, exp_file_name, coeffPirker);
numFig = numFig + 1;
% a{numFig} = boxPlotFun( gloriaAugustaSchulzeNN, aorFlag, numFig, exp_file_name, coeffPirker);
numFig = numFig + 1;
legend = 'CoR' ;
% a{numFig} = tilePlotFun2( gloriaAugustaSchulzeNN, aorFlag, numFig, exp_file_name, legend, coeffPirker);

clearvars matFile gloriaAugustaSchulzeNN aorFlag dataNN2 exp_file_name coeffPirker

%%
matFile = 'R:\simulations\new\finalSinterFine10070Aor.mat';
load(matFile, 'gloriaAugustaSchulzeNN');
aorFlag = 2;
numFig = numFig + 1;
load(matFile, 'dataNN2');
load(matFile, 'exp_file');
exp_file_name = exp_file;
coeffPirker = 1.2;
dataNN2 = 0;
a{numFig} = radarPrintVectorialFun( gloriaAugustaSchulzeNN, aorFlag, numFig, dataNN2, exp_file_name, coeffPirker);
numFig = numFig + 1;
% a{numFig} = boxPlotFun( gloriaAugustaSchulzeNN, aorFlag, numFig, exp_file_name, coeffPirker);
numFig = numFig + 1;
legend = 'CoR' ;
% a{numFig} = tilePlotFun2( gloriaAugustaSchulzeNN, aorFlag, numFig, exp_file_name, legend, coeffPirker);