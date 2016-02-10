clear all
close all
clc

matFile1 = 'R:\simulations\shearCell\testPolidispersity20160209SCTFinal.mat';
matFile2 = 'R:\simulations\aor\20160210AoRpolidispersity.mat';
matFile3 = 'R:\simulations\input\inputDataNN8.mat';

load(matFile1, 'gloria*');
load(matFile2, 'gloria*');
load(matFile3, 'dataNN2');

dataNN2.rest = dataNN2.rest(1:2:end);
dataNN2.rf = sort([dataNN2.rf(1:2:end)', 0.025:0.05:0.975]');
dataNN2.sf = sort([dataNN2.sf(1:2:end)', 0.025:0.05:0.975]');
dataNN2.dens = dataNN2.dens(1:2:end);
rangeRest = max(dataNN2.rest) - min(dataNN2.rest);
rangeRf = max(dataNN2.rf) - min(dataNN2.rf);
rangeSf = max(dataNN2.sf) - min(dataNN2.sf);
rangeDens = max(dataNN2.dens) - min(dataNN2.dens);

totComb = length(dataNN2.rest)*length(dataNN2.rf)*length(dataNN2.sf)*length(dataNN2.dens);

finList = {
    'cokecoarse', [1, 2] , 27, 1;
    'cokefine', [3,4,5], 3, 2;
    'ironorecoarse', [6,7,8], 28, 3;
    'ironorefine', [9,10,11,12,13], 30, 4;
    'limestonecoarse', [14,15], 14, 5;
    'limestonefine', [16,17,18,19], 16, 6;
    'sintercoarse', [20,21,22], 31, 7};

[ expList, gloriaSCT, gloriaAOR, Cia, ia, ib ] = gloriaIntersectFun( gloriaAugustaSchulzeNNDens, gloriaAugustaAor );


for i = 1:7
    lFinList = length(finList{i,2});
    for j = 1 : lFinList
        finTable{i}(1,j) = mean(gloriaSCT{finList{i,2}(j)}(:,2));
        finTable{i}(2,j) = std(gloriaSCT{finList{i,2}(j)}(:,2));
        finTable{i}(3,j) = rangeSf;
        finTable{i}(4,j) = finTable{i}(2,j) / rangeSf;
        
        finTable{i}(5,j) = mean(gloriaSCT{finList{i,2}(j)}(:,3));
        finTable{i}(6,j) = std(gloriaSCT{finList{i,2}(j)}(:,3));
        finTable{i}(7,j) = rangeRf;
        finTable{i}(8,j) = finTable{i}(6,j) / rangeRf;
        
        finTable{i}(9,j) = mean(gloriaSCT{finList{i,2}(j)}(:,1));
        finTable{i}(10,j) = std(gloriaSCT{finList{i,2}(j)}(:,1));
        finTable{i}(11,j) = rangeRest;
        finTable{i}(12,j) = finTable{i}(10,j) / rangeRest;
        
        finTable{i}(13,j) = mean(gloriaSCT{finList{i,2}(j)}(:,4));
        finTable{i}(14,j) = std(gloriaSCT{finList{i,2}(j)}(:,4));
        finTable{i}(15,j) = rangeDens;
        finTable{i}(16,j) = finTable{i}(14,j) / rangeDens;
        
        finTable{i}(17,j) = length(gloriaSCT{finList{i,2}(j)}(:,2));
        finTable{i}(18,j) = finTable{i}(17,j) / totComb;
        
    end
    
    j = j + 1;
    
    finTable{i}(1,j) = mean(gloriaAOR{i}(:,2));
    finTable{i}(2,j) = std(gloriaAOR{i}(:,2));
    finTable{i}(3,j) = rangeSf;
    finTable{i}(4,j) = finTable{i}(2,j) / rangeSf;
    
    finTable{i}(5,j) = mean(gloriaAOR{i}(:,3));
    finTable{i}(6,j) = std(gloriaAOR{i}(:,3));
    finTable{i}(7,j) = rangeRf;
    finTable{i}(8,j) = finTable{i}(6,j) / rangeRf;
    
    finTable{i}(9,j) = mean(gloriaAOR{i}(:,1));
    finTable{i}(10,j) = std(gloriaAOR{i}(:,1));
    finTable{i}(11,j) = rangeRest;
    finTable{i}(12,j) = finTable{i}(10,j) / rangeRest;
    
    finTable{i}(13,j) = mean(gloriaAOR{i}(:,4));
    finTable{i}(14,j) = std(gloriaAOR{i}(:,4));
    finTable{i}(15,j) = rangeDens;
    finTable{i}(16,j) = finTable{i}(14,j) / rangeDens;
    
    finTable{i}(17,j) = length(gloriaAOR{i}(:,2));
    finTable{i}(18,j) = finTable{i}(17,j) / totComb;
    
    j = j + 1;
    
    finTable{i}(1,j) = mean(Cia{finList{i,3}}(:,2));
    finTable{i}(2,j) = std(Cia{finList{i,3}}(:,2));
    finTable{i}(3,j) = rangeSf;
    finTable{i}(4,j) = finTable{i}(2,j) / rangeSf;
    
    finTable{i}(5,j) = mean(Cia{finList{i,3}}(:,3));
    finTable{i}(6,j) = std(Cia{finList{i,3}}(:,3));
    finTable{i}(7,j) = rangeRf;
    finTable{i}(8,j) = finTable{i}(6,j) / rangeRf;
    
    finTable{i}(9,j) = mean(Cia{finList{i,3}}(:,1));
    finTable{i}(10,j) = std(Cia{finList{i,3}}(:,1));
    finTable{i}(11,j) = rangeRest;
    finTable{i}(12,j) = finTable{i}(10,j) / rangeRest;
    
    finTable{i}(13,j) = mean(Cia{finList{i,3}}(:,4));
    finTable{i}(14,j) = std(Cia{finList{i,3}}(:,4));
    finTable{i}(15,j) = rangeDens;
    finTable{i}(16,j) = finTable{i}(14,j) / rangeDens;
    
    finTable{i}(17,j) = length(Cia{finList{i,3}}(:,2));
    finTable{i}(18,j) = finTable{i}(17,j) / totComb;
    
end

save -v7.3 testMerge20160210Tables.mat


