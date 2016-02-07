clear all
close all
clc

matFile = 'R:\simulations\shearCell\sinterFineMatlabData\radarPlot1068sinterfine0_1range.mat';
load(matFile, 'gloriaAugustaSchulzeNN');
aorFlag = 0;
numFig = 1;
load(matFile, 'dataNN2');
load(matFile, 'exp_file');
exp_file_name = exp_file;
coeffPirker = 1;
[ a2 ] = radarPrintVectorialFun( gloriaAugustaSchulzeNN, aorFlag, numFig, dataNN2, exp_file_name, coeffPirker);
numFig = 2;

clearvars matFile gloriaAugustaSchulzeNN aorFlag numFig dataNN2 exp_file_name coeffPirker