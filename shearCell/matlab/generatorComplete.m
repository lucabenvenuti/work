clear all
close all
clc

%%  1) import data fixed values
matFile = 'R:\simulations\shearCell\20150721shearCellPoliAllDensitiesWithOldShearPerc1ANNsMultiple\20150721shearCellPoliAllDensitiesWithOldShearPerc1ANNsMultipleRes.mat';
load(matFile, 'data', 'avgMuR2', 'avgMuR1', 'densityBulkBoxMax');
nSimCases = length(data);

radius = [6.3, 5.6, 3.55, 2, 1.6, 1.25, 1, 0.8, 0.63, 0.5, 0.315, 0.25, 0.00001]' / 2000;
particleDistro = [0.085700000,0,0.10100000,0,0.034967000,0,0.060551000,0;...
    0.13628500,0,0.11900000,0,0.048994000,0,0.10042900,0;...
    0.62509600,0,0.52000000,0,0.50043400,0,0.70873200,0;...
    0.087021000,0.084236106,0.26000000,0.35397900,0.41560500,0.17518300,0.096267000,0.45390000;...
    0,0.089430140,0,0.17476500,0,0.13875000,0,0.15710000;...
    0,0.077020108,0,0.14924500,0,0.098199000,0,0.10330000;
    0.065898000,0.070008162,0,0.12914000,0,0.090874000,0.034021000,0.22640000;...
    0,0.073922238,0,0.063436000,0,0.074651000,0,0.028400000;...
    0,0.076890257,0,0.051341000,0,0.066806000,0,0.030900000;...
    0,0.098000297,0,0.032099000,0,0.061080000,0,0;...
    0,0.138884767000000,0,0.016993000,0,0.097473000,0,0;...
    0,0.065370631,0,0.029002000,0,0.036232000,0,0;...
    0,0.226237293000000,0,0,0,0.16075200,0,0];

[rows, columns] = size(particleDistro);
radmu = zeros(columns,1);
radsigma = zeros(columns,1);
for i = 1:columns
    radmu(i) = radius.' * particleDistro(:,i);
    radsigma(i) = std(radius, particleDistro(:,i));
end

exp_file_name_list = {'20131001_1117_Iron_ore',1;'20131001_1157_Iron_ore',2;'20131001_13011_Iron_ore',3;...
    '20131128_0957_PP_test01',4;'20131128_1016_PP_test02',5;'20131128_1058_PP_test03',6;'20131128_1114_PP_test04',7;...
    '20131128_1140_PP_test05',8;'20131128_1158_silibeads2mm_test01',9;'20131128_1218_silibeads2mm_test02',10;...
    '20131128_1238_silibeads2mm_test03',11;'20131128_1443_silibeads4mm_test01',12;'20131128_1517_silibeads4mm_test02',13;...
    '20131128_1612_sinterfine315-10_test01',14;'20131128_1712_sinterfine315-10_test02',15;'20131128_1742_sinterfine315-10_test03',16;...
    '20131128_1824_sinterfine0-315_test01',17;'20131128_1851_sinterfine0-315_test02',18;'20131128_1951_sinterfine0-315_test03',19;...
    '20131129_0841_sinterfine0-315_test04',20;'20131129_0921_limestone315-10_test01',21;'20131129_1000_limestone315-10_test02',22;...
    '20131129_1019_limestone0-315_test01',23;'20131129_1035_limestone0-315_test02',24;'20131129_1059_limestone0-315_test03',25;...
    '20131129_1121_limestone0-315_test04',26;'20131129_1155_coal315-10_test01',27;'20131129_1245_coal315-10_test02',28;...
    '20131129_1356_coal0-315_test02',29;'20131129_1418_coal0-315_test03',30;'20131129_1437_coal0-315_test04',31;...
    '20131129_1514_ironore315-10_test01',32;'20131129_1554_ironore315-10_test02',33;'20131129_1610_ironore0-315_test01',34;...
    '20131129_1629_ironore0-315_test02',35;'20131129_1648_ironore0-315_test03',36;'20131129_1713_ironore0-315_test04',37;...
    '20131129_1733_ironore0-315_test05',38;'20131129_1831_ironore315-10_test03',39;'20131129_1854_saatbau_test01',40;...
    '20131129_1915_perlite_test01',41;'Iron_ore1030-011013',42;'Iron_ore1030-011013.in',43};

coeffPirker = 1.0;
densTolerance = 0.05;
fricTolerance = 0.05;
trainFcn = 'trainscg';
hiddenLayerSizeVector = [5:40];
matFile = 'R:\simulations\input\inputDataNN8.mat';
load(matFile, 'dataNN2');
dataNN2.rest = dataNN2.rest(1:2:end);
dataNN2.rf = sort([dataNN2.rf(1:2:end)', 0.025:0.05:0.975]');
dataNN2.sf = sort([dataNN2.sf(1:2:end)', 0.025:0.05:0.975]');
dataNN2.ctrlStress = expOut.sigmaAnM; %5000; %1068;% [1068,2069,10070];
dataNN2.dCylDp = 30;
dataNN2.dens = dataNN2.dens(1:2:end);
numFig = 0;


%%  2) import/generate dataNN
%for i = 14:39
%for i = 1:26
% expNumber = i + 13;
expNumber = 25;

switch expNumber
    case {27, 28}
        materialNumber = 1;
        disp('coke coarse')
    case {29, 30, 31}
        materialNumber = 2;
        disp('coke fine')
    case {32, 33, 39}
        materialNumber = 3;
        disp('ironore coarse')
    case {34, 35, 36, 37, 38}
        materialNumber = 4;
        disp('ironore fine')
    case {21, 22}
        materialNumber = 5;
        disp('limestone coarse')
    case {23, 24, 25, 26}
        materialNumber = 6;
        disp('limestone fine')
    case {14, 15, 16}
        materialNumber = 7;
        disp('sinter coarse')
    case {17, 18, 19, 20}
        materialNumber = 8;
        disp('sinter fine')
    otherwise
        warning('Unexpected plot type. No plot created.')
end

exp_file_name = exp_file_name_list{expNumber, 1};
[coeffShear40, coeffShear60, coeffShear80, coeffShear100, expFtd, expInp, expOut] = experimentalImport(exp_file_name);

dataNN2.radmu = radmu(materialNumber); %0.001;
dataNN2.radsigma = radsigma(materialNumber); %dataNN2.radsigma/10;



%%  3) create NNSave and 4) extract weight table

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2, gen{i}.numbersNeuronsWinner, gen{i}.NNSaveNeuronsWinner] =   ...
    myNeuNetFunPolidispersity(nSimCases, data, trainFcn, hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxMax);

%%  5) create new input
newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);
newY3 = newY2([1:3, 8:11],:);
clearvars newY2

%%  6) get gloria Augusta
[ gen{i}.gloriaAugustaSchulzeNNDens, kkk ] = getGLoriaAugustaSCTPoldispersity(coeffShear40, ...
    coeffShear60, coeffShear80, coeffShear100, expFtd, expOut, coeffPirker, newY3, ...
    fricTolerance, densTolerance);

%%  7) print

%gloriaAugustaSchulzeNN = gen{i}.gloriaAugustaSchulzeNNDens';
aorFlag = 3;
numFig = numFig + 1;
af{numFig} = radarPrintVectorialFun( gen{i}.gloriaAugustaSchulzeNNDens', aorFlag, numFig, dataNN2, exp_file_name, coeffPirker);
numFig = numFig + 1;
af{numFig} = boxPlotFun( gen{i}.gloriaAugustaSchulzeNNDens', aorFlag, numFig, exp_file_name, coeffPirker);
numFig = numFig + 1;
legend = 'CoR' ;
af{numFig} = tilePlotFun2( gen{i}.gloriaAugustaSchulzeNNDens', aorFlag, numFig, exp_file_name, legend, coeffPirker);

clearvars exp_file_name coeffShear40  coeffShear60  coeffShear80  coeffShear100  expFtd  expInp  expOut NNSave2  errorNN2  x2  zz2  errorEstSum2  errorEstIndex2  errorEstSumMaxIndex2  yy2  corrMat2 gloriaAugustaSchulzeNN