%% Import data from text file.
% Script for importing data from the following text file:
%
%    /mnt/scratchPFMDaten/Luca/20150714/workTest/sinterChuteJSPLdevelopDistroSimpli/postMass/countRate1.txt
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2015/07/15 13:26:57
%%
clear all
close all
clc
%% Initialize variables.
%filename = '/mnt/scratchPFMDaten/Luca/20150714/workTest/sinterChuteJSPLdevelopDistroSimpli/postMass/countRate1.txt';

if (isunix)
    filename =  '/mnt/scratchPFMDaten/Luca/20150714/postMass/countRate1.txt';
    addpath('/mnt/DATA/liggghts/work/shearCell/matlab/exportFig');
else
    filename = 'S:\Luca\20150714\workTest\sinterChuteJSPLdevelopDistroSimpli\postMass\countRateLayer1.txt';
    addpath('E:\liggghts\work\shearCell\matlab\exportFig');
end

delimiter = ' ';
startRow = 2;

%% Format string for each line of text:
%   column1: double (%f)
%	column2: double (%f)
%   column3: double (%f)
%	column4: double (%f)
%   column5: double (%f)
%	column10: double (%f)
%   column11: double (%f)
%	column12: double (%f)
%   column13: double (%f)
%	column25: double (%f)
%   column26: double (%f)
%	column27: double (%f)
%   column28: double (%f)
%	column33: double (%f)
%   column34: double (%f)
%	column35: double (%f)
%   column40: double (%f)
%	column41: double (%f)
%   column42: double (%f)
%	column43: double (%f)
%   column47: double (%f)
%	column48: double (%f)
%   column49: double (%f)
%	column74: double (%f)
%   column75: double (%f)
%	column76: double (%f)
%   column77: double (%f)
%	column81: double (%f)
%   column82: double (%f)
%	column83: double (%f)
%   column95: double (%f)
%	column96: double (%f)
%   column97: double (%f)
%	column98: double (%f)
%   column102: double (%f)
%	column103: double (%f)
%   column104: double (%f)
%	column110: double (%f)
%   column111: double (%f)
%	column112: double (%f)
%   column113: double (%f)
%	column117: double (%f)
%   column118: double (%f)
%	column119: double (%f)
%   column126: double (%f)
%	column127: double (%f)
%   column128: double (%f)
%	column129: double (%f)
%   column133: double (%f)
%	column134: double (%f)
%   column135: double (%f)
%	column142: double (%f)
%   column143: double (%f)
%	column144: double (%f)
%   column145: double (%f)
%	column149: double (%f)
%   column150: double (%f)
%	column151: double (%f)
%   column158: double (%f)
%	column159: double (%f)
%   column160: double (%f)
%	column161: double (%f)
%   column165: double (%f)
%	column166: double (%f)
%   column167: double (%f)
%	column174: double (%f)
%   column175: double (%f)
%	column176: double (%f)
%   column177: double (%f)
%	column181: double (%f)
%   column182: double (%f)
%	column183: double (%f)
%   column190: double (%f)
%	column191: double (%f)
%   column192: double (%f)
%	column193: double (%f)
%   column197: double (%f)
%	column198: double (%f)
%   column199: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%f%f%f%f%f%*s%*s%*s%*s%f%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%f%f%f%f%*s%*s%*s%*s%f%f%f%*s%*s%*s%*s%f%f%f%f%*s%*s%*s%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%f%f%f%f%*s%*s%*s%f%f%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%f%f%f%f%*s%*s%*s%f%f%f%*s%*s%*s%*s%*s%f%f%f%f%*s%*s%*s%f%f%f%*s%*s%*s%*s%*s%*s%f%f%f%f%*s%*s%*s%f%f%f%*s%*s%*s%*s%*s%*s%f%f%f%f%*s%*s%*s%f%f%f%*s%*s%*s%*s%*s%*s%f%f%f%f%*s%*s%*s%f%f%f%*s%*s%*s%*s%*s%*s%f%f%f%f%*s%*s%*s%f%f%f%*s%*s%*s%*s%*s%*s%f%f%f%f%*s%*s%*s%f%f%f%*s%*s%*s%*s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,0,'HeaderLines' ,startRow-1, 'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Allocate imported array to column variable names
asimulatedTime = dataArray{:, 1};
dumpMassRate = dataArray{:, 2};
rS0percBottom = dataArray{:, 3};
rS1percBottom = dataArray{:, 4};
rS2percBottom = dataArray{:, 5};
rS3percBottom = dataArray{:, 6};
rS4percBottom = dataArray{:, 7};
rS5percBottom = dataArray{:, 8};
rS6percBottom = dataArray{:, 9};
rS0percCentral = dataArray{:, 10};
rS1percCentral = dataArray{:, 11};
rS2percCentral = dataArray{:, 12};
rS3percCentral = dataArray{:, 13};
rS4percCentral = dataArray{:, 14};
rS5percCentral = dataArray{:, 15};
rS6percCentral = dataArray{:, 16};
rS0percTop = dataArray{:, 17};
rS1percTop = dataArray{:, 18};
rS2percTop = dataArray{:, 19};
rS3percTop = dataArray{:, 20};
rS4percTop = dataArray{:, 21};
rS5percTop = dataArray{:, 22};
rS6percTop = dataArray{:, 23};
rS0percLay8 = dataArray{:, 24};
rS1percLay8 = dataArray{:, 25};
rS2percLay8 = dataArray{:, 26};
rS3percLay8 = dataArray{:, 27};
rS4percLay8 = dataArray{:, 28};
rS5percLay8 = dataArray{:, 29};
rS6percLay8 = dataArray{:, 30};
rS0percLay7 = dataArray{:, 31};
rS1percLay7 = dataArray{:, 32};
rS2percLay7 = dataArray{:, 33};
rS3percLay7 = dataArray{:, 34};
rS4percLay7 = dataArray{:, 35};
rS5percLay7 = dataArray{:, 36};
rS6percLay7 = dataArray{:, 37};
rS0percLay6 = dataArray{:, 38};
rS1percLay6 = dataArray{:, 39};
rS2percLay6 = dataArray{:, 40};
rS3percLay6 = dataArray{:, 41};
rS4percLay6 = dataArray{:, 42};
rS5percLay6 = dataArray{:, 43};
rS6percLay6 = dataArray{:, 44};
rS0percLay5 = dataArray{:, 45};
rS1percLay5 = dataArray{:, 46};
rS2percLay5 = dataArray{:, 47};
rS3percLay5 = dataArray{:, 48};
rS4percLay5 = dataArray{:, 49};
rS5percLay5 = dataArray{:, 50};
rS6percLay5 = dataArray{:, 51};
rS0percLay4 = dataArray{:, 52};
rS1percLay4 = dataArray{:, 53};
rS2percLay4 = dataArray{:, 54};
rS3percLay4 = dataArray{:, 55};
rS4percLay4 = dataArray{:, 56};
rS5percLay4 = dataArray{:, 57};
rS6percLay4 = dataArray{:, 58};
rS0percLay3 = dataArray{:, 59};
rS1percLay3 = dataArray{:, 60};
rS2percLay3 = dataArray{:, 61};
rS3percLay3 = dataArray{:, 62};
rS4percLay3 = dataArray{:, 63};
rS5percLay3 = dataArray{:, 64};
rS6percLay3 = dataArray{:, 65};
rS0percLay2 = dataArray{:, 66};
rS1percLay2 = dataArray{:, 67};
rS2percLay2 = dataArray{:, 68};
rS3percLay2 = dataArray{:, 69};
rS4percLay2 = dataArray{:, 70};
rS5percLay2 = dataArray{:, 71};
rS6percLay2 = dataArray{:, 72};
rS0percLay1 = dataArray{:, 73};
rS1percLay1 = dataArray{:, 74};
rS2percLay1 = dataArray{:, 75};
rS3percLay1 = dataArray{:, 76};
rS4percLay1 = dataArray{:, 77};
rS5percLay1 = dataArray{:, 78};
rS6percLay1 = dataArray{:, 79};

%% Clear temporary variables
clearvars filename delimiter startRow formatSpec fileID dataArray ans;

%%
cg = 1;

rS0 = 0.0020;
rS1 = 0.0025;
rS2 = 0.0050;
rS3 = 0.0100;
rS4 = 0.0250;
rS5 = 0.1000;
rS6 = 0.2500;

rS0Mass = 4*pi*rS0^3/3;
rS1Mass = 4*pi*rS1^3/3;
rS2Mass = 4*pi*rS2^3/3;
rS3Mass = 4*pi*rS3^3/3;
rS4Mass = 4*pi*rS4^3/3;
rS5Mass = 4*pi*rS5^3/3;
rS6Mass = 4*pi*rS6^3/3;

%%

%rS6percLay8 = data(:,8);
rS5percLay8 = rS5percLay8 - rS6percLay8;
rS4percLay8 = rS4percLay8 - (rS5percLay8 + rS6percLay8) ;
rS3percLay8 = rS3percLay8 - (rS4percLay8 + rS5percLay8 + rS6percLay8) ;
rS2percLay8 = rS2percLay8 - (rS3percLay8 + rS4percLay8 + rS5percLay8 + rS6percLay8) ;
rS1percLay8 = rS1percLay8 - (rS2percLay8 + rS3percLay8 + rS4percLay8 + rS5percLay8 + rS6percLay8) ;
rS0percLay8 = rS0percLay8 - (rS1percLay8 + rS2percLay8 + rS3percLay8 + rS4percLay8 + rS5percLay8 + rS6percLay8) ;

% rS6percLay7 = data(:,15);
rS5percLay7 = rS5percLay7 - rS6percLay7;
rS4percLay7 = rS4percLay7 - (rS5percLay7 + rS6percLay7) ;
rS3percLay7 = rS3percLay7 - (rS4percLay7 + rS5percLay7 + rS6percLay7) ;
rS2percLay7 = rS2percLay7 - (rS3percLay7 + rS4percLay7 + rS5percLay7 + rS6percLay7) ;
rS1percLay7 = rS1percLay7 - (rS2percLay7 + rS3percLay7 + rS4percLay7 + rS5percLay7 + rS6percLay7) ;
rS0percLay7 = rS0percLay7 - (rS1percLay7 + rS2percLay7 + rS3percLay7 + rS4percLay7 + rS5percLay7 + rS6percLay7) ;

% rS6percLay6 = data(:,22);
rS5percLay6 = rS5percLay6 - rS6percLay6;
rS4percLay6 = rS4percLay6 - (rS5percLay6 + rS6percLay6) ;
rS3percLay6 = rS3percLay6 - (rS4percLay6 + rS5percLay6 + rS6percLay6) ;
rS2percLay6 = rS2percLay6 - (rS3percLay6 + rS4percLay6 + rS5percLay6 + rS6percLay6) ;
rS1percLay6 = rS1percLay6 - (rS2percLay6 + rS3percLay6 + rS4percLay6 + rS5percLay6 + rS6percLay6) ;
rS0percLay6 = rS0percLay6 - (rS1percLay6 + rS2percLay6 + rS3percLay6 + rS4percLay6 + rS5percLay6 + rS6percLay6) ;

rS5percLay5 = rS5percLay5 - rS6percLay5;
rS4percLay5 = rS4percLay5 - (rS5percLay5 + rS6percLay5) ;
rS3percLay5 = rS3percLay5 - (rS4percLay5 + rS5percLay5 + rS6percLay5) ;
rS2percLay5 = rS2percLay5 - (rS3percLay5 + rS4percLay5 + rS5percLay5 + rS6percLay5) ;
rS1percLay5 = rS1percLay5 - (rS2percLay5 + rS3percLay5 + rS4percLay5 + rS5percLay5 + rS6percLay5) ;
rS0percLay5 = rS0percLay5 - (rS1percLay5 + rS2percLay5 + rS3percLay5 + rS4percLay5 + rS5percLay5 + rS6percLay5) ;

rS5percLay4 = rS5percLay4 - rS6percLay4;
rS4percLay4 = rS4percLay4 - (rS5percLay4 + rS6percLay4) ;
rS3percLay4 = rS3percLay4 - (rS4percLay4 + rS5percLay4 + rS6percLay4) ;
rS2percLay4 = rS2percLay4 - (rS3percLay4 + rS4percLay4 + rS5percLay4 + rS6percLay4) ;
rS1percLay4 = rS1percLay4 - (rS2percLay4 + rS3percLay4 + rS4percLay4 + rS5percLay4 + rS6percLay4) ;
rS0percLay4 = rS0percLay4 - (rS1percLay4 + rS2percLay4 + rS3percLay4 + rS4percLay4 + rS5percLay4 + rS6percLay4) ;

rS5percLay3 = rS5percLay3 - rS6percLay3;
rS4percLay3 = rS4percLay3 - (rS5percLay3 + rS6percLay3) ;
rS3percLay3 = rS3percLay3 - (rS4percLay3 + rS5percLay3 + rS6percLay3) ;
rS2percLay3 = rS2percLay3 - (rS3percLay3 + rS4percLay3 + rS5percLay3 + rS6percLay3) ;
rS1percLay3 = rS1percLay3 - (rS2percLay3 + rS3percLay3 + rS4percLay3 + rS5percLay3 + rS6percLay3) ;
rS0percLay3 = rS0percLay3 - (rS1percLay3 + rS2percLay3 + rS3percLay3 + rS4percLay3 + rS5percLay3 + rS6percLay3) ;

rS5percLay2 = rS5percLay2 - rS6percLay2;
rS4percLay2 = rS4percLay2 - (rS5percLay2 + rS6percLay2) ;
rS3percLay2 = rS3percLay2 - (rS4percLay2 + rS5percLay2 + rS6percLay2) ;
rS2percLay2 = rS2percLay2 - (rS3percLay2 + rS4percLay2 + rS5percLay2 + rS6percLay2) ;
rS1percLay2 = rS1percLay2 - (rS2percLay2 + rS3percLay2 + rS4percLay2 + rS5percLay2 + rS6percLay2) ;
rS0percLay2 = rS0percLay2 - (rS1percLay2 + rS2percLay2 + rS3percLay2 + rS4percLay2 + rS5percLay2 + rS6percLay2) ;

rS5percLay1 = rS5percLay1 - rS6percLay1;
rS4percLay1 = rS4percLay1 - (rS5percLay1 + rS6percLay1) ;
rS3percLay1 = rS3percLay1 - (rS4percLay1 + rS5percLay1 + rS6percLay1) ;
rS2percLay1 = rS2percLay1 - (rS3percLay1 + rS4percLay1 + rS5percLay1 + rS6percLay1) ;
rS1percLay1 = rS1percLay1 - (rS2percLay1 + rS3percLay1 + rS4percLay1 + rS5percLay1 + rS6percLay1) ;
rS0percLay1 = rS0percLay1 - (rS1percLay1 + rS2percLay1 + rS3percLay1 + rS4percLay1 + rS5percLay1 + rS6percLay1) ;

%%
rS6percLay8 = rS6percLay8 * rS6Mass;
rS5percLay8 = rS5percLay8 * rS5Mass;
rS4percLay8 = rS4percLay8 * rS4Mass;
rS3percLay8 = rS3percLay8 * rS3Mass;
rS2percLay8 = rS2percLay8 * rS2Mass;
rS1percLay8 = rS1percLay8 * rS1Mass;
rS0percLay8 = rS0percLay8 * rS0Mass;

rS6percLay7 = rS6percLay7 * rS6Mass;
rS5percLay7 = rS5percLay7 * rS5Mass;
rS4percLay7 = rS4percLay7 * rS4Mass;
rS3percLay7 = rS3percLay7 * rS3Mass;
rS2percLay7 = rS2percLay7 * rS2Mass;
rS1percLay7 = rS1percLay7 * rS1Mass;
rS0percLay7 = rS0percLay7 * rS0Mass;

rS6percLay6 = rS6percLay6 * rS6Mass;
rS5percLay6 = rS5percLay6 * rS5Mass;
rS4percLay6 = rS4percLay6 * rS4Mass;
rS3percLay6 = rS3percLay6 * rS3Mass;
rS2percLay6 = rS2percLay6 * rS2Mass;
rS1percLay6 = rS1percLay6 * rS1Mass;
rS0percLay6 = rS0percLay6 * rS0Mass;

rS6percLay5 = rS6percLay5 * rS6Mass;
rS5percLay5 = rS5percLay5 * rS5Mass;
rS4percLay5 = rS4percLay5 * rS4Mass;
rS3percLay5 = rS3percLay5 * rS3Mass;
rS2percLay5 = rS2percLay5 * rS2Mass;
rS1percLay5 = rS1percLay5 * rS1Mass;
rS0percLay5 = rS0percLay5 * rS0Mass;

rS6percLay4 = rS6percLay4 * rS6Mass;
rS5percLay4 = rS5percLay4 * rS5Mass;
rS4percLay4 = rS4percLay4 * rS4Mass;
rS3percLay4 = rS3percLay4 * rS3Mass;
rS2percLay4 = rS2percLay4 * rS2Mass;
rS1percLay4 = rS1percLay4 * rS1Mass;
rS0percLay4 = rS0percLay4 * rS0Mass;

rS6percLay3 = rS6percLay3 * rS6Mass;
rS5percLay3 = rS5percLay3 * rS5Mass;
rS4percLay3 = rS4percLay3 * rS4Mass;
rS3percLay3 = rS3percLay3 * rS3Mass;
rS2percLay3 = rS2percLay3 * rS2Mass;
rS1percLay3 = rS1percLay3 * rS1Mass;
rS0percLay3 = rS0percLay3 * rS0Mass;

rS6percLay2 = rS6percLay2 * rS6Mass;
rS5percLay2 = rS5percLay2 * rS5Mass;
rS4percLay2 = rS4percLay2 * rS4Mass;
rS3percLay2 = rS3percLay2 * rS3Mass;
rS2percLay2 = rS2percLay2 * rS2Mass;
rS1percLay2 = rS1percLay2 * rS1Mass;
rS0percLay2 = rS0percLay2 * rS0Mass;

rS6percLay1 = rS6percLay1 * rS6Mass;
rS5percLay1 = rS5percLay1 * rS5Mass;
rS4percLay1 = rS4percLay1 * rS4Mass;
rS3percLay1 = rS3percLay1 * rS3Mass;
rS2percLay1 = rS2percLay1 * rS2Mass;
rS1percLay1 = rS1percLay1 * rS1Mass;
rS0percLay1 = rS0percLay1 * rS0Mass;

%%
rS8totalVolume = rS6percLay8 + rS5percLay8 + rS4percLay8 + rS3percLay8 + rS2percLay8 + rS1percLay8 + rS0percLay8;
rS7totalVolume = rS6percLay7 + rS5percLay7 + rS4percLay7 + rS3percLay7 + rS2percLay7 + rS1percLay7 + rS0percLay7;



%% Clear temporary variables
clearvars data raw cellVectors;

%% Plot
% figure(1)
% plot(asimulatedTime,rS0percLay6,'DisplayName','rS0percLay6');
% hold all;
% plot(asimulatedTime,rS1percLay6,'DisplayName','rS1percLay6');
% plot(asimulatedTime,rS2percLay6,'DisplayName','rS2percLay6');
% plot(asimulatedTime,rS3percLay6,'DisplayName','rS3percLay6');
% plot(asimulatedTime,rS4percLay6,'DisplayName','rS4percLay6');
% plot(asimulatedTime,rS5percLay6,'DisplayName','rS5percLay6');
% plot(asimulatedTime,rS6percLay6,'DisplayName','rS6percLay6');
% hold off;
% 
% figure(2)
% plot(asimulatedTime,rS0percLay8,'DisplayName','rS0percLay8');
% hold all;
% plot(asimulatedTime,rS1percLay8,'DisplayName','rS1percLay8');
% plot(asimulatedTime,rS2percLay8,'DisplayName','rS2percLay8');
% plot(asimulatedTime,rS3percLay8,'DisplayName','rS3percLay8');
% plot(asimulatedTime,rS4percLay8,'DisplayName','rS4percLay8');
% plot(asimulatedTime,rS5percLay8,'DisplayName','rS5percLay8');
% plot(asimulatedTime,rS6percLay8,'DisplayName','rS6percLay8');
% hold off;
% 
% figure(3)
% plot(asimulatedTime,rS0percLay7,'DisplayName','rS0percLay7');
% hold all;
% plot(asimulatedTime,rS1percLay7,'DisplayName','rS1percLay7');
% plot(asimulatedTime,rS2percLay7,'DisplayName','rS2percLay7');
% plot(asimulatedTime,rS3percLay7,'DisplayName','rS3percLay7');
% plot(asimulatedTime,rS4percLay7,'DisplayName','rS4percLay7');
% plot(asimulatedTime,rS5percLay7,'DisplayName','rS5percLay7');
% plot(asimulatedTime,rS6percLay7,'DisplayName','rS6percLay7');
% hold off;
% 
% 
% % figure(4)
% % h01 = plot(asimulatedTime(1185:1215),rS0percLay8(1185:1215),'b','LineWidth',2,'DisplayName','r =  2.5 mm, bottom layer');
% % hold all;
% % h02 = plot(asimulatedTime(1185:1215),rS1percLay8(1185:1215),'m','LineWidth',2,'DisplayName','r =  3.0 mm, bottom layer');
% % h03 = plot(asimulatedTime(1185:1215),rS2percLay8(1185:1215),'g','LineWidth',2,'DisplayName','r =  5.0 mm, bottom layer');
% % h04 = plot(asimulatedTime(1185:1215),rS3percLay8(1185:1215),'r','LineWidth',2,'DisplayName','r =  8.0 mm, bottom layer');
% % h05 = plot(asimulatedTime(1185:1215),rS4percLay8(1185:1215),'c','LineWidth',2,'DisplayName','r = 12.5 mm, bottom layer');
% % h06 = plot(asimulatedTime(1185:1215),rS5percLay8(1185:1215),'y','LineWidth',2,'DisplayName','r = 20.0 mm, bottom layer');
% % h07 = plot(asimulatedTime(1185:1215),rS6percLay8(1185:1215),'k','LineWidth',2,'DisplayName','r = 25.0 mm, bottom layer');
% % 
% % h08 = plot(asimulatedTime(1185:1215),rS0percLay7(1185:1215),'b','LineWidth',2,'DisplayName','r =  2.5 mm, central layer');
% % h09 = plot(asimulatedTime(1185:1215),rS1percLay7(1185:1215),'m','LineWidth',2,'DisplayName','r =  3.0 mm, central layer');
% % h10 = plot(asimulatedTime(1185:1215),rS2percLay7(1185:1215),'g','LineWidth',2,'DisplayName','r =  5.0 mm, central layer');
% % %  plot(asimulatedTime(1185:1215),rS3percLay7(1185:1215),'r','DisplayName','rS3percLay7');
% % %  plot(asimulatedTime(1185:1215),rS4percLay7(1185:1215),'c','DisplayName','rS4percLay7');
% % %  plot(asimulatedTime(1185:1215),rS5percLay7(1185:1215),'y','DisplayName','rS5percLay7');
% % %  plot(asimulatedTime(1185:1215),rS6percLay7(1185:1215),'k','DisplayName','rS6percLay7');
% % 
% % h11 = plot(asimulatedTime(1185:3:1215),rS0percLay8(1185:3:1215),'b*','markers',18,'DisplayName','r =  2.5 mm, bottom layer');
% % 
% % h12 = plot(asimulatedTime(1185:3:1215),rS1percLay8(1185:3:1215),'m*','markers',18,'DisplayName','r =  3.0 mm, bottom layer');
% % h13 = plot(asimulatedTime(1185:3:1215),rS2percLay8(1185:3:1215),'g*','markers',18,'DisplayName','r =  5.0 mm, bottom layer');
% % h14 = plot(asimulatedTime(1185:3:1215),rS3percLay8(1185:3:1215),'r*','markers',18,'DisplayName','r =  8.0 mm, bottom layer');
% % h15 = plot(asimulatedTime(1185:3:1215),rS4percLay8(1185:3:1215),'c*','markers',18,'DisplayName','r = 12.5 mm, bottom layer');
% % %  h16 = plot(asimulatedTime(1185:3:1215),rS5percLay8(1185:3:1215),'y*','DisplayName','r = 20.0 mm, bottom layer');
% % h17 = plot(asimulatedTime(1185:3:1215),rS6percLay8(1185:3:1215),'k*','markers',18,'DisplayName','r = 25.0 mm, bottom layer');
% % 
% % h18 = plot(asimulatedTime(1185:3:1215),rS0percLay7(1185:3:1215),'bo','markers',18,'DisplayName','r =  2.5 mm, central layer');
% % 
% % h19 = plot(asimulatedTime(1185:3:1215),rS1percLay7(1185:3:1215),'mo','markers',18,'DisplayName','r =  3.0 mm, central layer');
% % h20 = plot(asimulatedTime(1185:3:1215),rS2percLay7(1185:3:1215),'go','markers',18,'DisplayName','r =  5.0 mm, central layer');
% % %  plot(asimulatedTime(1185:3:1215),rS3percLay7(1185:3:1215),'ro','DisplayName','rS3percLay7');
% % %  plot(asimulatedTime(1185:3:1215),rS4percLay7(1185:3:1215),'co','DisplayName','rS4percLay7');
% % %  plot(asimulatedTime(1185:3:1215),rS5percLay7(1185:3:1215),'yo','DisplayName','rS5percLay7');
% % %  plot(asimulatedTime(1185:3:1215),rS6percLay7(1185:3:1215),'ko','DisplayName','rS6percLay7');
% % %legend('rS0percLay8', 'rS1percLay8', 'rS2percLay8', , , , , , , , , , ,)
% % legend([h11 h12 h13 h14 h15 h17 h18 h19 h20], 'Location', 'NorthWest');  %
% % xlabel('time (s)','FontSize',20)
% % ylabel('volume (m^3)','FontSize',20)
% % set(gca,'fontname','times new roman','FontSize',20)  % Set it to times
% % xlim([-0.01 0.31])
% % hold off;

h5 = figure(5);
plot(asimulatedTime,rS8totalVolume,'DisplayName','rS0percLay8');
hold all;
plot(asimulatedTime,rS7totalVolume,'DisplayName','rS1percLay8');
legend('Location','SouthWest' )
xlabel('time (s)','FontSize',20)
ylabel('volume (m^3)','FontSize',20)
set(gca,'fontname','times new roman','FontSize',20)  % Set it to times
hold off;

formatOut = 'yyyy-mm-dd-HH-MM-SS';
date1 = datestr(now,formatOut);


h6 = figure(6);
plot(asimulatedTime,rS6percLay6,'DisplayName','rS6percLay6');hold all;plot(asimulatedTime,rS6percLay7,'DisplayName','rS6percLay7');plot(asimulatedTime,rS6percLay8,'DisplayName','rS6percLay8');
legend('Location','SouthWest' )
title(['rS6: radius = ', num2str(rS6),' m'],'FontSize',20)
xlabel('time (s)','FontSize',20)
ylabel('volume (m^3)','FontSize',20)
set(gca,'fontname','times new roman','FontSize',20)
hold off;
%export_fig(['rS6',date1],'-jpg', '-nocrop', h6);

h7 = figure(7);
plot(asimulatedTime,rS5percLay6,'DisplayName','rS5percLay6');hold all;plot(asimulatedTime,rS5percLay7,'DisplayName','rS5percLay7');plot(asimulatedTime,rS5percLay8,'DisplayName','rS5percLay8');
legend('Location','SouthWest' )
title(['rS5: radius = ', num2str(rS5),' m'],'FontSize',20)
xlabel('time (s)','FontSize',20)
ylabel('volume (m^3)','FontSize',20)
set(gca,'fontname','times new roman','FontSize',20)
hold off;
%export_fig(['rS5',date1],'-jpg', '-nocrop', h7);


h8 = figure(8);
plot(asimulatedTime,rS4percLay6,'DisplayName','rS4percLay6');hold all;plot(asimulatedTime,rS4percLay7,'DisplayName','rS4percLay7');plot(asimulatedTime,rS4percLay8,'DisplayName','rS4percLay8');
legend('Location','SouthWest' )
title(['rS4: radius = ', num2str(rS4),' m'],'FontSize',20)
xlabel('time (s)','FontSize',20)
ylabel('volume (m^3)','FontSize',20)
set(gca,'fontname','times new roman','FontSize',20)
hold off;
%export_fig(['rS4',date1],'-jpg', '-nocrop', h8);


h9 = figure(9);
plot(asimulatedTime,rS3percLay6,'DisplayName','rS3percLay6');hold all;plot(asimulatedTime,rS3percLay7,'DisplayName','rS3percLay7');plot(asimulatedTime,rS3percLay8,'DisplayName','rS3percLay8');
legend('Location','SouthWest' )
title(['rS3: radius = ', num2str(rS3),' m'],'FontSize',20)
xlabel('time (s)','FontSize',20)
ylabel('volume (m^3)','FontSize',20)
set(gca,'fontname','times new roman','FontSize',20)
hold off;
%export_fig(['rS3',date1],'-jpg', '-nocrop', h9);

h10 = figure(10);
plot(asimulatedTime,rS2percLay6,'DisplayName','rS2percLay6');hold all;plot(asimulatedTime,rS2percLay7,'DisplayName','rS2percLay7');plot(asimulatedTime,rS2percLay8,'DisplayName','rS2percLay8');
legend('Location','SouthWest' )
title(['rS2: radius = ', num2str(rS2),' m'],'FontSize',20)
xlabel('time (s)','FontSize',20)
ylabel('volume (m^3)','FontSize',20)
set(gca,'fontname','times new roman','FontSize',20)
hold off;
%export_fig(['rS2',date1],'-jpg', '-nocrop', h10);


h11 = figure(11);
plot(asimulatedTime,rS1percLay6,'DisplayName','rS1percLay6');hold all;plot(asimulatedTime,rS1percLay7,'DisplayName','rS1percLay7');plot(asimulatedTime,rS1percLay8,'DisplayName','rS1percLay8');
legend('Location','SouthWest' )
title(['rS1: radius = ', num2str(rS1),' m'],'FontSize',20)
xlabel('time (s)','FontSize',20)
ylabel('volume (m^3)','FontSize',20)
set(gca,'fontname','times new roman','FontSize',20)
hold off;
%export_fig(['rS1',date1],'-jpg', '-nocrop', h11);


h12 = figure(12);
plot(asimulatedTime,rS0percLay6,'DisplayName','rS0percLay6');hold all;plot(asimulatedTime,rS0percLay7,'DisplayName','rS0percLay7');plot(asimulatedTime,rS0percLay8,'DisplayName','rS0percLay8');
legend('Location','SouthWest' )
title(['rS0: radius = ', num2str(rS0),' m'],'FontSize',20)
xlabel('time (s)','FontSize',20)
ylabel('volume (m^3)','FontSize',20)
set(gca,'fontname','times new roman','FontSize',20)
hold off;
%export_fig(['rS0',date1],'-jpg', '-nocrop', h12);

%%
h13 = figure(13);
plot(asimulatedTime,rS6percLay1,'DisplayName','rS6percLay1');hold all;
plot(asimulatedTime,rS6percLay2,'DisplayName','rS6percLay2');plot(asimulatedTime,rS6percLay3,'DisplayName','rS6percLay3');
plot(asimulatedTime,rS6percLay4,'DisplayName','rS6percLay4');plot(asimulatedTime,rS6percLay5,'DisplayName','rS6percLay5');
plot(asimulatedTime,rS6percLay7,'DisplayName','rS6percLay7');
plot(asimulatedTime,rS6percLay7,'DisplayName','rS6percLay7');plot(asimulatedTime,rS6percLay8,'DisplayName','rS6percLay8');
legend('Location','SouthWest' )
title(['rS6: radius = ', num2str(rS6),' m'],'FontSize',20)
xlabel('time (s)','FontSize',20)
ylabel('volume (m^3)','FontSize',20)
set(gca,'fontname','times new roman','FontSize',20)
hold off;
%export_fig(['rS6',date1],'-jpg', '-nocrop', h6);

h14 = figure(14);
plot(asimulatedTime,rS5percLay1,'DisplayName','rS5percLay1');hold all;
plot(asimulatedTime,rS5percLay2,'DisplayName','rS5percLay2');plot(asimulatedTime,rS5percLay3,'DisplayName','rS5percLay3');
plot(asimulatedTime,rS5percLay4,'DisplayName','rS5percLay4');plot(asimulatedTime,rS5percLay5,'DisplayName','rS5percLay5');
plot(asimulatedTime,rS5percLay7,'DisplayName','rS5percLay7');
plot(asimulatedTime,rS5percLay7,'DisplayName','rS5percLay7');plot(asimulatedTime,rS5percLay8,'DisplayName','rS5percLay8');
legend('Location','SouthWest' )
title(['rS5: radius = ', num2str(rS5),' m'],'FontSize',20)
xlabel('time (s)','FontSize',20)
ylabel('volume (m^3)','FontSize',20)
set(gca,'fontname','times new roman','FontSize',20)
hold off;
%export_fig(['rS5',date1],'-jpg', '-nocrop', h7);


h15 = figure(15);
plot(asimulatedTime,rS4percLay1,'DisplayName','rS4percLay1');hold all;
plot(asimulatedTime,rS4percLay2,'DisplayName','rS4percLay2');plot(asimulatedTime,rS4percLay3,'DisplayName','rS4percLay3');
plot(asimulatedTime,rS4percLay4,'DisplayName','rS4percLay4');plot(asimulatedTime,rS4percLay5,'DisplayName','rS4percLay5');
plot(asimulatedTime,rS4percLay7,'DisplayName','rS4percLay7');
plot(asimulatedTime,rS4percLay7,'DisplayName','rS4percLay7');plot(asimulatedTime,rS4percLay8,'DisplayName','rS4percLay8');
legend('Location','SouthWest' )
title(['rS4: radius = ', num2str(rS4),' m'],'FontSize',20)
xlabel('time (s)','FontSize',20)
ylabel('volume (m^3)','FontSize',20)
set(gca,'fontname','times new roman','FontSize',20)
hold off;
%export_fig(['rS4',date1],'-jpg', '-nocrop', h8);


h16 = figure(16);
plot(asimulatedTime,rS3percLay1,'DisplayName','rS3percLay1');hold all;
plot(asimulatedTime,rS3percLay2,'DisplayName','rS3percLay2');plot(asimulatedTime,rS3percLay3,'DisplayName','rS3percLay3');
plot(asimulatedTime,rS3percLay4,'DisplayName','rS3percLay4');plot(asimulatedTime,rS3percLay5,'DisplayName','rS3percLay5');
plot(asimulatedTime,rS3percLay7,'DisplayName','rS3percLay7');
plot(asimulatedTime,rS3percLay7,'DisplayName','rS3percLay7');plot(asimulatedTime,rS3percLay8,'DisplayName','rS3percLay8');
legend('Location','SouthWest' )
title(['rS3: radius = ', num2str(rS3),' m'],'FontSize',20)
xlabel('time (s)','FontSize',20)
ylabel('volume (m^3)','FontSize',20)
set(gca,'fontname','times new roman','FontSize',20)
hold off;
%export_fig(['rS3',date1],'-jpg', '-nocrop', h9);

h17 = figure(17);
plot(asimulatedTime,rS2percLay1,'DisplayName','rS2percLay1');hold all;
plot(asimulatedTime,rS2percLay2,'DisplayName','rS2percLay2');plot(asimulatedTime,rS2percLay3,'DisplayName','rS2percLay3');
plot(asimulatedTime,rS2percLay4,'DisplayName','rS2percLay4');plot(asimulatedTime,rS2percLay5,'DisplayName','rS2percLay5');
plot(asimulatedTime,rS2percLay7,'DisplayName','rS2percLay7');
plot(asimulatedTime,rS2percLay7,'DisplayName','rS2percLay7');plot(asimulatedTime,rS2percLay8,'DisplayName','rS2percLay8');
legend('Location','SouthWest' )
title(['rS2: radius = ', num2str(rS2),' m'],'FontSize',20)
xlabel('time (s)','FontSize',20)
ylabel('volume (m^3)','FontSize',20)
set(gca,'fontname','times new roman','FontSize',20)
hold off;
%export_fig(['rS2',date1],'-jpg', '-nocrop', h10);


h18 = figure(18);
plot(asimulatedTime,rS1percLay1,'DisplayName','rS1percLay1');hold all;
plot(asimulatedTime,rS1percLay2,'DisplayName','rS1percLay2');plot(asimulatedTime,rS1percLay3,'DisplayName','rS1percLay3');
plot(asimulatedTime,rS1percLay4,'DisplayName','rS1percLay4');plot(asimulatedTime,rS1percLay5,'DisplayName','rS1percLay5');
plot(asimulatedTime,rS1percLay7,'DisplayName','rS1percLay7');
plot(asimulatedTime,rS1percLay7,'DisplayName','rS1percLay7');plot(asimulatedTime,rS1percLay8,'DisplayName','rS1percLay8');
legend('Location','SouthWest' )
title(['rS1: radius = ', num2str(rS1),' m'],'FontSize',20)
xlabel('time (s)','FontSize',20)
ylabel('volume (m^3)','FontSize',20)
set(gca,'fontname','times new roman','FontSize',20)
hold off;
%export_fig(['rS1',date1],'-jpg', '-nocrop', h11);


h19 = figure(19);
plot(asimulatedTime,rS0percLay1,'DisplayName','rS0percLay1');hold all;
plot(asimulatedTime,rS0percLay2,'DisplayName','rS0percLay2');plot(asimulatedTime,rS0percLay3,'DisplayName','rS0percLay3');
plot(asimulatedTime,rS0percLay4,'DisplayName','rS0percLay4');plot(asimulatedTime,rS0percLay5,'DisplayName','rS0percLay5');
plot(asimulatedTime,rS0percLay7,'DisplayName','rS0percLay7');
plot(asimulatedTime,rS0percLay7,'DisplayName','rS0percLay7');plot(asimulatedTime,rS0percLay8,'DisplayName','rS0percLay8');
legend('Location','SouthWest' )
title(['rS0: radius = ', num2str(rS0),' m'],'FontSize',20)
xlabel('time (s)','FontSize',20)
ylabel('volume (m^3)','FontSize',20)
set(gca,'fontname','times new roman','FontSize',20)
hold off;
%export_fig(['rS0',date1],'-jpg', '-nocrop', h12);


