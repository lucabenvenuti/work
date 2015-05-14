trainFcn = 'trainscg';

clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2 col norm avgMuR2mean avgMuR1mean avgMuR2std avgMuR1std rhoBShearMaxmean rhoBShearMaxstd rhoBPreShearMaxmean rhoBPreShearMaxstd startMinAvgMuR2Min startMinAvgMuR2Index startMinAvgMuR1Min startMinAvgMuR1Index ...
    startMinRhoPreMin startMinRhoPreIndex  startMinRhoPostMin startMinRhoPostIndex

if (isunix)
load /mnt/scratchPFMDaten/Luca/testPolidispersityShearCellCokeCoarseCokeFineSinterFineLimestoneFineMatlab/inputRadSigma.mat
else
 load S:\Luca\testPolidispersityShearCellCokeCoarseCokeFineSinterFineLimestoneFineMatlab\inputRadSigma.mat
end

dataNN2.rf = sort([dataNN2.rf', 0.025:0.05:0.975]');
dataNN2.sf = sort([dataNN2.sf', 0.025:0.05:0.975]');
dataNN2.ctrlStress = 5000; %1068;% [1068,2069,10070];
dataNN2.radmu = 0.001;
dataNN2.dens = 2500;
dataNN2.dCylDp= 30;
dataNN2.radsigma = dataNN2.radsigma/10;

 
% 
% dataNN2.rest = [0.511688111024859;0.534206318836018;0.546967060342322;0.604992893879333;0.618670349287331;0.627511320770353;0.669666703885523;0.703143313864447;0.820405849107896;0.871541655791218];
% 
% dataNN2.sf = [0.0647127693542180;0.0772404448409008;0.0790138989894048;0.0858519229275745;0.0903095806257046;0.100043147796753;0.106637924200657;0.107447620211399;0.117873191370610;0.129296324115968;0.141893524491824;0.143776664722796;0.150905527682231;0.151423768526879;0.176512457226804;0.179725480487601;0.192372170354069;0.208809989418923;0.209530788398144;0.214719182463055;0.223776345944168;0.237919335351633;0.238212482415826;0.270014667373098;0.275419400782945;0.277935410040282;0.298777624677180;0.305663455078628;0.327384875963629;0.367454900100621;0.368588997964657;0.372518742721220;0.399064816117253;0.403789253052760;0.421390912207549;0.425739454885163;0.429294882082897;0.445959494534248;0.460068611736284;0.460771928594289;0.481107823290574;0.485906386770935;0.497533955814842;0.505926034088758;0.514178525113400;0.514452856724159;0.515203256115223;0.515406319086613;0.519465239807307;0.525021313810691;0.525448042947101;0.542665195385011;0.545079039263801;0.545567350341070;0.550532038982881;0.569465432802020;0.597885439833951;0.599598807972267;0.629373316001431;0.636783070109032;0.642857083765005;0.646574691230599;0.666541918076738;0.671069481235132;0.674016896425022;0.676624990262892;0.695178763822460;0.695741553808471;0.697873308941610;0.713808540718055;0.727059748094968;0.729285224480659;0.735166123652653;0.736317612748500;0.743814319712680;0.750965190741147;0.756870547349089;0.790099137069711;0.806374679905952;0.810314046584782;0.813196172022318;0.815214953303201;0.826669737475322;0.827241126166644;0.834048105631943;0.839810755697116;0.866470190363902;0.890909607792352;0.892186336422296;0.896376379114250;0.908534532528501;0.909486126163995;0.917622486257277;0.924315437844736;0.954048941538841;0.964934112322567;0.974325827025669;0.979746617159101;0.984860538160196;0.988582903003551];
% 
% dataNN2.rf = [0.0713869631032202;0.0809707795040016;0.0819236442631080;0.114593130046510;0.115365794162149;0.136282121498068;0.139517871943348;0.150347743162571;0.152380564481556;0.164581032632304;0.171613679734164;0.195973881711741;0.198584704615235;0.203410507096162;0.212565013038610;0.219225831680321;0.219827877414750;0.230911603820956;0.231377510474488;0.262838029283008;0.264878295765042;0.278671683706152;0.289215816348697;0.292050648767155;0.297691599102691;0.302016864319528;0.303147916240119;0.316955037407177;0.324611343090753;0.325918631063130;0.336382201276462;0.347082942479585;0.353619748421471;0.358888397729532;0.376683153909234;0.377239290735990;0.400470718760700;0.407458599764890;0.415388168150940;0.437238237189095;0.446856899100829;0.451693834258367;0.451741404645080;0.452280273014601;0.453996354203428;0.456840343330417;0.468080882051635;0.484553147403290;0.487689640397391;0.497378043540417;0.507920957980264;0.542149502943049;0.550785604672620;0.554321066659420;0.554767211237391;0.562170141790714;0.570477356154103;0.583139803074177;0.603837063610290;0.604865866614530;0.610032110460306;0.614638438131114;0.618597485318904;0.630410725808891;0.636236340173562;0.655823643168565;0.656604220358246;0.662526310026584;0.671723422369213;0.683021909005204;0.683201517732458;0.684441090663031;0.685716539307674;0.688217757143504;0.692316188670564;0.710383474574150;0.711151847636528;0.713200244171293;0.714893457431877;0.716043818105880;0.732440996045590;0.743736352654218;0.789862129732888;0.826872531402110;0.828982161642844;0.833157453354393;0.852172548700844;0.862746665553616;0.881603018673976;0.885671038257810;0.887773175429219;0.910992743117246;0.945600135063088;0.946441493320969;0.959809242849504;0.970216863719539;0.982556053422212;0.983530229735853;0.983899843146363;0.999126375023293];
% 
% dataNN2.radsigma = [2.72737906913502e-05;2.81967469992842e-05;3.30149100778908e-05;3.44565660526202e-05;3.76309110709825e-05;4.21960647314000e-05;4.26450086587167e-05;4.46318683178180e-05;4.52786362616327e-05;4.68572559261145e-05;4.68873960470765e-05;5.01182498430951e-05;5.19632562360178e-05;5.24150836080150e-05;5.62555613811175e-05;5.83766639444983e-05;5.88880945633623e-05;5.89350520192714e-05;6.17393846845710e-05;6.33552648217049e-05;6.62669785223687e-05;6.73648910155851e-05;6.96193271993973e-05;7.05655169642332e-05;7.10023763722972e-05;7.17127346152332e-05;7.47708541659977e-05;7.98425503590749e-05;8.05720123663576e-05;8.36659957513199e-05;8.47587733188821e-05;8.51743402624494e-05;8.77616439778510e-05;9.12375015981940e-05;9.23463857780742e-05;9.41914889806961e-05;9.61120573708939e-05;9.74706263752589e-05;9.76994973579923e-05;0.000101455522055051;0.000101748251039282;0.000103172728889614;0.000103536133997298;0.000103790381979892;0.000105267971783119;0.000105621087311722;0.000106612544711240;0.000107506614587321;0.000113345176951390;0.000113750376247819;0.000114232915126598;0.000115052293675895;0.000116776556246528;0.000117298489603610;0.000117436192918955;0.000117747535957481;0.000122660055033964;0.000123661888059707;0.000124299319287441;0.000126966284342957;0.000127817782173202;0.000127831926618167;0.000128839024295719;0.000131233498010555;0.000132542285585952;0.000133127856468227;0.000133978088242642;0.000134162056173147;0.000134453926008572;0.000134504707802601;0.000136881180874917;0.000136891937107286;0.000138454710122820;0.000139101765821955;0.000139712953665392;0.000140433915959067;0.000142574182197400;0.000144733071227361;0.000146684545573391;0.000146802549274402;0.000149567443070743;0.000150037044802623;0.000153727156347121;0.000154058133976904;0.000154831051264037;0.000154851915713364;0.000155133047874792;0.000156549476022884;0.000157249397880501;0.000165240716120002;0.000166735612900846;0.000169922129631681;0.000171382008665020;0.000179020464615469;0.000179258175907067;0.000181817457952497;0.000182974566754338;0.000183861095105787;0.000188433654664239;0.000191910964071378];
% 
% dataNN2.dCylDp = 30;
% 
% dataNN2.ctrlStress = 5000;
% 
% dataNN2.radmu = 1e-3;
% 
% dataNN2.dens = 2500;

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxMax);
avgMuR2Pos = 9;
avgMuR1Pos = 10;
densityBulkBoxMeanPos = 11;
% save -v7.3testPolidispersityDensityBulkBoxMax.mat
newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);

bulkValue(1).avgMuR2 = newY2(avgMuR2Pos,:);
bulkValue(1).avgMuR1 = newY2(avgMuR1Pos,:);
bulkValue(1).densityBulkBox = newY2(densityBulkBoxMeanPos,:);
bulkValue(1).name = 'DensityBulkBoxMax';
bulkValue(1).NNSave2 = NNSave2 ;
bulkValue(1).errorNN2 = errorNN2;
bulkValue(1).x2 =  x2 ;
bulkValue(1).zz2 = zz2;
bulkValue(1).errorEstSum2 =  errorEstSum2;
bulkValue(1).errorEstIndex2 = errorEstIndex2;
bulkValue(1).errorEstSumMaxIndex2 = errorEstSumMaxIndex2;
bulkValue(1).yy2 = yy2;
bulkValue(1).corrMat2 = corrMat2;


clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxMean);
avgMuR2Pos = 9;
avgMuR1Pos = 10;
densityBulkBoxMeanPos = 11;
newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);
% save -v7.3testPolidispersityDensityBulkBoxMean.mat

bulkValue(2).avgMuR2 = newY2(avgMuR2Pos,:);
bulkValue(2).avgMuR1 = newY2(avgMuR1Pos,:);
bulkValue(2).densityBulkBox = newY2(densityBulkBoxMeanPos,:);
bulkValue(2).name = 'DensityBulkBoxMean';
bulkValue(2).NNSave2 = NNSave2 ;
bulkValue(2).errorNN2 = errorNN2;
bulkValue(2).x2 =  x2 ;
bulkValue(2).zz2 = zz2;
bulkValue(2).errorEstSum2 =  errorEstSum2;
bulkValue(2).errorEstIndex2 = errorEstIndex2;
bulkValue(2).errorEstSumMaxIndex2 = errorEstSumMaxIndex2;
bulkValue(2).yy2 = yy2;
bulkValue(2).corrMat2 = corrMat2;


clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxMin);
avgMuR2Pos = 9;
avgMuR1Pos = 10;
densityBulkBoxMeanPos = 11;
newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);
% save -v7.3testPolidispersityDensityBulkBoxMin.mat

bulkValue(3).avgMuR2 = newY2(avgMuR2Pos,:);
bulkValue(3).avgMuR1 = newY2(avgMuR1Pos,:);
bulkValue(3).densityBulkBox = newY2(densityBulkBoxMeanPos,:);
bulkValue(3).name = 'DensityBulkBoxMin';
bulkValue(3).NNSave2 = NNSave2 ;
bulkValue(3).errorNN2 = errorNN2;
bulkValue(3).x2 =  x2 ;
bulkValue(3).zz2 = zz2;
bulkValue(3).errorEstSum2 =  errorEstSum2;
bulkValue(3).errorEstIndex2 = errorEstIndex2;
bulkValue(3).errorEstSumMaxIndex2 = errorEstSumMaxIndex2;
bulkValue(3).yy2 = yy2;
bulkValue(3).corrMat2 = corrMat2;

clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxPreShearMax);
avgMuR2Pos = 9;
avgMuR1Pos = 10;
densityBulkBoxMeanPos = 11;
newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);
% save -v7.3testPolidispersityDensityBulkBoxPreShearMax.mat

bulkValue(4).avgMuR2 = newY2(avgMuR2Pos,:);
bulkValue(4).avgMuR1 = newY2(avgMuR1Pos,:);
bulkValue(4).densityBulkBox = newY2(densityBulkBoxMeanPos,:);
bulkValue(4).name = 'DensityBulkBoxPreShearMax';
bulkValue(4).NNSave2 = NNSave2 ;
bulkValue(4).errorNN2 = errorNN2;
bulkValue(4).x2 =  x2 ;
bulkValue(4).zz2 = zz2;
bulkValue(4).errorEstSum2 =  errorEstSum2;
bulkValue(4).errorEstIndex2 = errorEstIndex2;
bulkValue(4).errorEstSumMaxIndex2 = errorEstSumMaxIndex2;
bulkValue(4).yy2 = yy2;
bulkValue(4).corrMat2 = corrMat2;

clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxPreShearMean);
avgMuR2Pos = 9;
avgMuR1Pos = 10;
densityBulkBoxMeanPos = 11;
newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);
% save -v7.3testPolidispersityDensityBulkBoxPreShearMean.mat

bulkValue(5).avgMuR2 = newY2(avgMuR2Pos,:);
bulkValue(5).avgMuR1 = newY2(avgMuR1Pos,:);
bulkValue(5).densityBulkBox = newY2(densityBulkBoxMeanPos,:);
bulkValue(5).name = 'DensityBulkBoxPreShearMean';
bulkValue(5).NNSave2 = NNSave2 ;
bulkValue(5).errorNN2 = errorNN2;
bulkValue(5).x2 =  x2 ;
bulkValue(5).zz2 = zz2;
bulkValue(5).errorEstSum2 =  errorEstSum2;
bulkValue(5).errorEstIndex2 = errorEstIndex2;
bulkValue(5).errorEstSumMaxIndex2 = errorEstSumMaxIndex2;
bulkValue(5).yy2 = yy2;
bulkValue(5).corrMat2 = corrMat2;

clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxPreShearMin);
avgMuR2Pos = 9;
avgMuR1Pos = 10;
densityBulkBoxMeanPos = 11;
newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);
% save -v7.3testPolidispersityDensityBulkBoxPreShearMin.mat

bulkValue(6).avgMuR2 = newY2(avgMuR2Pos,:);
bulkValue(6).avgMuR1 = newY2(avgMuR1Pos,:);
bulkValue(6).densityBulkBox = newY2(densityBulkBoxMeanPos,:);
bulkValue(6).name = 'DensityBulkBoxPreShearMin';
bulkValue(6).NNSave2 = NNSave2 ;
bulkValue(6).errorNN2 = errorNN2;
bulkValue(6).x2 =  x2 ;
bulkValue(6).zz2 = zz2;
bulkValue(6).errorEstSum2 =  errorEstSum2;
bulkValue(6).errorEstIndex2 = errorEstIndex2;
bulkValue(6).errorEstSumMaxIndex2 = errorEstSumMaxIndex2;
bulkValue(6).yy2 = yy2;
bulkValue(6).corrMat2 = corrMat2;

clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxShearMax);
avgMuR2Pos = 9;
avgMuR1Pos = 10;
densityBulkBoxMeanPos = 11;
newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);
% save -v7.3testPolidispersityDensityBulkBoxShearMax.mat

bulkValue(7).avgMuR2 = newY2(avgMuR2Pos,:);
bulkValue(7).avgMuR1 = newY2(avgMuR1Pos,:);
bulkValue(7).densityBulkBox = newY2(densityBulkBoxMeanPos,:);
bulkValue(7).name = 'DensityBulkBoxShearMax';
bulkValue(7).NNSave2 = NNSave2 ;
bulkValue(7).errorNN2 = errorNN2;
bulkValue(7).x2 =  x2 ;
bulkValue(7).zz2 = zz2;
bulkValue(7).errorEstSum2 =  errorEstSum2;
bulkValue(7).errorEstIndex2 = errorEstIndex2;
bulkValue(7).errorEstSumMaxIndex2 = errorEstSumMaxIndex2;
bulkValue(7).yy2 = yy2;
bulkValue(7).corrMat2 = corrMat2;

clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxShearMean);
avgMuR2Pos = 9;
avgMuR1Pos = 10;
densityBulkBoxMeanPos = 11;
newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);
% save -v7.3testPolidispersityDensityBulkBoxShearMean.mat

bulkValue(8).avgMuR2 = newY2(avgMuR2Pos,:);
bulkValue(8).avgMuR1 = newY2(avgMuR1Pos,:);
bulkValue(8).densityBulkBox = newY2(densityBulkBoxMeanPos,:);
bulkValue(8).name = 'DensityBulkBoxShearMean';
bulkValue(8).NNSave2 = NNSave2 ;
bulkValue(8).errorNN2 = errorNN2;
bulkValue(8).x2 =  x2 ;
bulkValue(8).zz2 = zz2;
bulkValue(8).errorEstSum2 =  errorEstSum2;
bulkValue(8).errorEstIndex2 = errorEstIndex2;
bulkValue(8).errorEstSumMaxIndex2 = errorEstSumMaxIndex2;
bulkValue(8).yy2 = yy2;
bulkValue(8).corrMat2 = corrMat2;

clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2

[NNSave2, errorNN2, x2, zz2, errorEstSum2, errorEstIndex2, errorEstSumMaxIndex2, yy2, corrMat2] =   myNeuNetFunPolidispersity(nSimCases,data,trainFcn,hiddenLayerSizeVector, avgMuR2,avgMuR1, densityBulkBoxShearMin);
avgMuR2Pos = 9;
avgMuR1Pos = 10;
densityBulkBoxMeanPos = 11;
newY2 = myNewInputPolidispersity(NNSave2, errorEstSumMaxIndex2, dataNN2);
% save -v7.3testPolidispersityDensityBulkBoxShearMin.mat

bulkValue(9).avgMuR2 = newY2(avgMuR2Pos,:);
bulkValue(9).avgMuR1 = newY2(avgMuR1Pos,:);
bulkValue(9).densityBulkBox = newY2(densityBulkBoxMeanPos,:);
bulkValue(9).name = 'DensityBulkBoxShearMin';
bulkValue(9).NNSave2 = NNSave2 ;
bulkValue(9).errorNN2 = errorNN2;
bulkValue(9).x2 =  x2 ;
bulkValue(9).zz2 = zz2;
bulkValue(9).errorEstSum2 =  errorEstSum2;
bulkValue(9).errorEstIndex2 = errorEstIndex2;
bulkValue(9).errorEstSumMaxIndex2 = errorEstSumMaxIndex2;
bulkValue(9).yy2 = yy2;
bulkValue(9).corrMat2 = corrMat2;

%clearvars NNSave2 errorNN2 x2 zz2 errorEstSum2 errorEstIndex2 errorEstSumMaxIndex2 yy2 corrMat2 newY2

% for i=1:9
% startMinAvgMuR2(i) = bulkValue(i).avgMuR2(1)/max(bulkValue(i).avgMuR2(:));
% startMinAvgMuR1(i) = bulkValue(i).avgMuR1(1)/max(bulkValue(i).avgMuR1(:));
% %startMinRho(i) = bulkValue(i).densityBulkBox(1);
%
% endMaxAvgMuR2(i) = bulkValue(i).avgMuR2(end)/max(bulkValue(i).avgMuR2(:));
% endMaxAvgMuR1(i) = bulkValue(i).avgMuR1(end)/max(bulkValue(i).avgMuR1(:));
% %endMaxRho(i) = bulkValue(i).densityBulkBox(end);
%
% end
%
% for i=4:6
%
% startMinRhoPre(i) = bulkValue(i).densityBulkBox(1)/max(bulkValue(i).densityBulkBox(:));
% endMaxRhoPre(i) = bulkValue(i).densityBulkBox(end)/max(bulkValue(i).densityBulkBox(:));
%
% end
%
% for i=7:9
%
% startMinRhoPost(i) = bulkValue(i).densityBulkBox(1)/max(bulkValue(i).densityBulkBox(:));
% endMaxRhoPost(i) = bulkValue(i).densityBulkBox(end)/max(bulkValue(i).densityBulkBox(:));
%
% end
%
%
% [startMinAvgMuR2Min, startMinAvgMuR2Index] = min(startMinAvgMuR2);
% [startMinAvgMuR1Min, startMinAvgMuR1Index] = min(startMinAvgMuR1);
% [startMinRhoPreMin, startMinRhoPreIndex] = min(startMinRhoPre);
% [startMinRhoPostMin, startMinRhoPostIndex] = min(startMinRhoPost);
% startMinRhoPostIndex = startMinRhoPostIndex+3;
%
% [endMaxAvgMuR2Max, endMaxAvgMuR2Index] = max(endMaxAvgMuR2);
% [endMaxAvgMuR1Max, endMaxAvgMuR1Index] = max(endMaxAvgMuR1);
% [endMaxRhoPreMax, endMaxRhoPreIndex] = max(endMaxRhoPre);
% [startMinRhoPostMin, startMinRhoPostIndex] = min(startMinRhoPost);
% startMinRhoPostIndex = startMinRhoPostIndex+6; %%%BEWARE
% INVERTED!!!!!!!!!!!!!!!!!!
%
% lim = max(dataNN2.radsigma);
% x = [dataNN2.radmu-lim:(lim/499.5):dataNN2.radmu+lim];
%
% for i=1:length(dataNN2.radsigma)
% norm(i,:) = normpdf(x,dataNN2.radmu,dataNN2.radsigma(i)');
% norm(i,:) = norm(i,:)/max(norm(i,:));
% col(i,:)=find(newY2(7,:)==dataNN2.radsigma(i)');
%
% avgMuR2mean(i)= mean(bulkValue(endMaxAvgMuR2Index).avgMuR2(1,col(i,:)));
% avgMuR2std(i)= std(bulkValue(endMaxAvgMuR2Index).avgMuR2(1,col(i,:)));
%
% avgMuR1mean(i)= mean(bulkValue(startMinAvgMuR1Index).avgMuR1(1,col(i,:)));
% avgMuR1std(i)= std(bulkValue(startMinAvgMuR1Index).avgMuR1(1,col(i,:)));
%
% rhoBShearMaxmean(i)= mean(bulkValue(startMinRhoPostIndex).densityBulkBox(1,col(i,:)));
% rhoBShearMaxstd(i)= std(bulkValue(startMinRhoPostIndex).densityBulkBox(1,col(i,:)));
%
% rhoBPreShearMaxmean(i)= mean(bulkValue(startMinRhoPreIndex).densityBulkBox(1,col(i,:)));
% rhoBPreShearMaxstd(i)= std(bulkValue(startMinRhoPreIndex).densityBulkBox(1,col(i,:)));
%
% end
%
% avgMuR2mean = avgMuR2mean./max(avgMuR2mean);
% avgMuR1mean = avgMuR1mean./max(avgMuR1mean);
% rhoBShearMaxmean = rhoBShearMaxmean./max(rhoBShearMaxmean);
% rhoBPreShearMaxmean = rhoBPreShearMaxmean./max(rhoBPreShearMaxmean);
%
% avgMuR2std = avgMuR2std./max(avgMuR2std);
% avgMuR1std = avgMuR1std./max(avgMuR1std);
% rhoBShearMaxstd = rhoBShearMaxstd./max(rhoBShearMaxstd);
% rhoBPreShearMaxmean = rhoBPreShearMaxmean./max(rhoBPreShearMaxmean);

lim = max(dataNN2.radsigma);
x = [dataNN2.radmu-lim:(lim/499.5):dataNN2.radmu+lim];
for j = 1:9
    
    for i=1:length(dataNN2.radsigma)
        norm(i,:) = normpdf(x,dataNN2.radmu,dataNN2.radsigma(i)');
        norm(i,:) = norm(i,:)/max(norm(i,:));
        col(i,:)=find(newY2(7,:)==dataNN2.radsigma(i)');
        
        avgMuR2mean(i,j)= mean(bulkValue(j).avgMuR2(1,col(i,:)));
        avgMuR2std(i,j)= std(bulkValue(j).avgMuR2(1,col(i,:)));
        
        avgMuR1mean(i,j)= mean(bulkValue(j).avgMuR1(1,col(i,:)));
        avgMuR1std(i,j)= std(bulkValue(j).avgMuR1(1,col(i,:)));
        
        rhoBShearMaxmean(i,j)= mean(bulkValue(j).densityBulkBox(1,col(i,:)));
        rhoBShearMaxstd(i,j)= std(bulkValue(j).densityBulkBox(1,col(i,:)));
        
        rhoBPreShearMaxmean(i,j)= mean(bulkValue(j).densityBulkBox(1,col(i,:)));
        rhoBPreShearMaxstd(i,j)= std(bulkValue(j).densityBulkBox(1,col(i,:)));
        
    end
    
    avgMuR2mean(:,j) = avgMuR2mean(:,j)./max(avgMuR2mean(:,j));
    avgMuR1mean(:,j) = avgMuR1mean(:,j)./max(avgMuR1mean(:,j));
    rhoBShearMaxmean(:,j) = rhoBShearMaxmean(:,j)./max(rhoBShearMaxmean(:,j));
    rhoBPreShearMaxmean(:,j) = rhoBPreShearMaxmean(:,j)./max(rhoBPreShearMaxmean(:,j));
    
    avgMuR2std(:,j) = avgMuR2std(:,j)./max(avgMuR2std(:,j));
    avgMuR1std(:,j) = avgMuR1std(:,j)./max(avgMuR1std(:,j));
    rhoBShearMaxstd(:,j) = rhoBShearMaxstd(:,j)./max(rhoBShearMaxstd(:,j));
    rhoBPreShearMaxmean(:,j) = rhoBPreShearMaxmean(:,j)./max(rhoBPreShearMaxmean(:,j));
    
    
    
    
    
end

[startMinAvgMuR2Min, startMinAvgMuR2Index] = min(avgMuR2mean(1,:));
[startMinAvgMuR1Min, startMinAvgMuR1Index] = min(avgMuR1mean(1,:));
[startMinRhoPreMin, startMinRhoPreIndex] = min(rhoBPreShearMaxmean(1,4:6));
startMinRhoPreIndex = startMinRhoPreIndex + 3;
[startMinRhoPostMin, startMinRhoPostIndex] = min(rhoBShearMaxmean(1,7:9));
startMinRhoPostIndex = startMinRhoPostIndex + 6;

formatOut = 'yyyy-mm-dd-HH-MM-SS';
date1 = datestr(now,formatOut);

h2=figure(6);
%plot(dataNN2.radsigma',avgMuR2mean,dataNN2.radsigma',avgMuR1mean,dataNN2.radsigma',rhoBShearMaxmean,dataNN2.radsigma',rhoBPreShearMaxmean)
plot(dataNN2.radsigma',avgMuR2mean(:,startMinAvgMuR2Index),dataNN2.radsigma',avgMuR1mean(:, startMinAvgMuR1Index),dataNN2.radsigma',rhoBShearMaxmean(:,startMinRhoPostIndex ),dataNN2.radsigma',rhoBPreShearMaxmean(:, startMinRhoPreIndex))
xlabel('std dev radius [m]', 'FontSize', 20);
set(gca,'fontname','times new roman','FontSize',20)  % Set it to times
set(h1, 'Position', [100 100 1500 800])
legend('avgMuR2mean [-]','avgMuR1mean [-]', 'rhoBShearMaxmean [-]', 'rhoBPreShearMaxmean [-]','Location', 'SouthEast' );

addpath('/mnt/DATA/liggghts/work/shearCell/matlab/exportFig');
export_fig(['0',num2str(41+i),'simulationRadiusDistribution',num2str(i),date1],'-jpg', '-nocrop', h1);

save -v7.3 testPolidispersityDensityBulkBoxBis.mat
