clear all
close all
clc

%%  1) import data
matFile = 'R:\simulations\shearCell\20150721shearCellPoliAllDensitiesWithOldShearPerc1ANNsMultiple\20150721shearCellPoliAllDensitiesWithOldShearPerc1ANNsMultipleRes.mat';
load(matFile, 'data');

radius = [6.3, 5.6, 3.55, 2, 1.6, 1.25, 1, 0.8, 0.63, 0.5, 0.315, 0.25, 0.00001]' / 2000;
particleDistro = [0.0857000000000000,0,0.101000000000000,0,0.0349670000000000,0,0.0605510000000000,0;0.136285000000000,0,0.119000000000000,0,0.0489940000000000,0,0.100429000000000,0;0.625096000000000,0,0.520000000000000,0,0.500434000000000,0,0.708732000000000,0;0.0870210000000000,0.0842361060000000,0.260000000000000,0.353979000000000,0.415605000000000,0.175183000000000,0.0962670000000000,0.453900000000000;0,0.0894301400000000,0,0.174765000000000,0,0.138750000000000,0,0.157100000000000;0,0.0770201080000000,0,0.149245000000000,0,0.0981990000000000,0,0.103300000000000;0.0658980000000000,0.0700081620000000,0,0.129140000000000,0,0.0908740000000000,0.0340210000000000,0.226400000000000;0,0.0739222380000000,0,0.0634360000000000,0,0.0746510000000000,0,0.0284000000000000;0,0.0768902570000000,0,0.0513410000000000,0,0.0668060000000000,0,0.0309000000000000;0,0.0980002970000000,0,0.0320990000000000,0,0.0610800000000000,0,0;0,0.138884767000000,0,0.0169930000000000,0,0.0974730000000000,0,0;0,0.0653706310000000,0,0.0290020000000000,0,0.0362320000000000,0,0;0,0.226237293000000,0,0,0,0.160752000000000,0,0];

[rows, columns] = size(particleDistro);
radmu = zeros(columns,1);
radsigma = zeros(columns,1);
for i = 1:columns
    radmu(i) = radius.' * particleDistro(:,i);
    radsigma(i) = std(radius, particleDistro(:,i));
end

exp_file_name_list = {'20131001_1117_Iron_ore',1;'20131001_1157_Iron_ore',2;'20131001_13011_Iron_ore',3;'20131128_0957_PP_test01',4;'20131128_1016_PP_test02',5;'20131128_1058_PP_test03',6;'20131128_1114_PP_test04',7;'20131128_1140_PP_test05',8;'20131128_1158_silibeads2mm_test01',9;'20131128_1218_silibeads2mm_test02',10;'20131128_1238_silibeads2mm_test03',11;'20131128_1443_silibeads4mm_test01',12;'20131128_1517_silibeads4mm_test02',13;'20131128_1612_sinterfine315-10_test01',14;'20131128_1712_sinterfine315-10_test02',15;'20131128_1742_sinterfine315-10_test03',16;'20131128_1824_sinterfine0-315_test01',17;'20131128_1851_sinterfine0-315_test02',18;'20131128_1951_sinterfine0-315_test03',19;'20131129_0841_sinterfine0-315_test04',20;'20131129_0921_limestone315-10_test01',21;'20131129_1000_limestone315-10_test02',22;'20131129_1019_limestone0-315_test01',23;'20131129_1035_limestone0-315_test02',24;'20131129_1059_limestone0-315_test03',25;'20131129_1121_limestone0-315_test04',26;'20131129_1155_coal315-10_test01',27;'20131129_1245_coal315-10_test02',28;'20131129_1356_coal0-315_test02',29;'20131129_1418_coal0-315_test03',30;'20131129_1437_coal0-315_test04',31;'20131129_1514_ironore315-10_test01',32;'20131129_1554_ironore315-10_test02',33;'20131129_1610_ironore0-315_test01',34;'20131129_1629_ironore0-315_test02',35;'20131129_1648_ironore0-315_test03',36;'20131129_1713_ironore0-315_test04',37;'20131129_1733_ironore0-315_test05',38;'20131129_1831_ironore315-10_test03',39;'20131129_1854_saatbau_test01',40;'20131129_1915_perlite_test01',41;'Iron_ore1030-011013',42;'Iron_ore1030-011013.in',43};
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

exp_file_name = exp_file_name_list{25,1};
[coeffShear40, coeffShear60, coeffShear80, coeffShear100, expFtd, expInp, expOut] = experimentalImport(exp_file_name );
coeffPirker = 1.0;
densTolerance = 0.05;
fricTolerance = 0.05;

%%  2) import/generate dataNN
matFile = 'R:\simulations\input\inputDataNN8.mat';
load(matFile, 'dataNN2');

dataNN2.rest = dataNN2.rest(1:2:end);
dataNN2.rf = sort([dataNN2.rf(1:2:end)', 0.025:0.05:0.975]');
dataNN2.sf = sort([dataNN2.sf(1:2:end)', 0.025:0.05:0.975]');
dataNN2.ctrlStress = 5000; %1068;% [1068,2069,10070];
dataNN2.radmu = 0.001;
dataNN2.dens = dataNN2.dens(1:2:end);
dataNN2.dCylDp = 30;
dataNN2.radsigma = dataNN2.radsigma/10;


%%  3) create NNSave
[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxMax);