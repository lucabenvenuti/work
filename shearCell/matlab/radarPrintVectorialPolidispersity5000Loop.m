clear all
close all
clc

if (isunix)
    %load /mnt/scratchPFMDaten/Luca/testPolidispersityShearCellCokeCoarseCokeFineSinterFineLimestoneFineMatlab/inputRadSigma.mat
    %load /mnt/scratchPFMDaten/Luca\testShearCellPoli20150428/testPolidispersityDensityBulkBoxSepties.mat
    load 20150721shearCellPoliAllDensitiesWithOldShearPerc1ANNsMultiple.mat
    load /mnt/scratchPFMDaten/Luca/testShearCellPoli20150428/expRes5000.mat
    addpath('/mnt/DATA/liggghts/work/shearCell/matlab/exportFig');
else
    %load S:\Luca\testShearCellPoli20150428\testPolidispersityDensityBulkBoxSepties.mat
    load R:\simulations\shearCell\20150721shearCellPoliAllDensitiesWithOldShearPerc1ANNsMultiple\20150721shearCellPoliAllDensitiesWithOldShearPerc1ANNsMultiple.mat
    load S:\Luca\testShearCellPoli20150428\expRes5000.mat
    addpath('E:\liggghts\work\shearCell\matlab\exportFig');
end



clearvars newY3

prob = mode([startMinAvgMuR2Index startMinAvgMuR1Index startMinRhoPreIndex startMinRhoPostIndex]);

cP = [0.8, 1.0, 1.2];

kkk = 1;

for i = 1:3
    
    coeffPirker = cP(i);
    
    for j = 1 : length(exp2)
        
        res{kkk}.coeffPirker = coeffPirker;
        %res{kkk}.gloriaAugustaSchulzeNNDens res{kkk}.gca
        [res{kkk} ] = radarPrintVectorialPolidispersity5000Fun( exp2{j,1}.coeffShear40, ...
            exp2{j,1}.coeffShear60, exp2{j,1}.coeffShear80, exp2{j,1}.coeffShear100, exp2{j,1}.expFtd, exp2{j,1}.expInp, ...
            exp2{j,1}.expOut, coeffPirker, newY2 , bulkValue(startMinAvgMuR2Index).avgMuR2, bulkValue(startMinAvgMuR1Index).avgMuR1, ...
            bulkValue(startMinRhoPostIndex).densityBulkBox, bulkValue(startMinRhoPreIndex).densityBulkBox, ...
            kkk, exp2{j,1}.exp_file_name, dataNN2);
        
        if (isfield (res{kkk}, 'gloriaAugustaSchulzeNN') & length(res{kkk}.gloriaAugustaSchulzeNN(:,1)>2))
%             X=gloriaAugustaSchulzeNN(2,:); %cor
%             Y=; %sf
%             Z=; %rf
%             S=; %rad_sigma
            clearvars merge
            merge(:,1)=[res{kkk}.gloriaAugustaSchulzeNN(3,:)]';%(sf) %X'; (sf)
            merge(:,2)=[res{kkk}.gloriaAugustaSchulzeNN(4,:)]';%(rf) %Y'; (rf)
            merge(:,3)=[res{kkk}.gloriaAugustaSchulzeNN(5,:)]';%(rad_sigma) %S'; (cor)
            
            [ h7 ] = tilePlotFun( merge,  length(exp2) + kkk + 100,  exp2{j,1}.exp_file_name, dataNN2, coeffPirker );
        end
        
        kkk = kkk + 1;
        
    end
    
end

% save -v7.3 20150721shearCellPoliAllDensitiesWithOldShearPerc1ANNsMultipleRes.mat