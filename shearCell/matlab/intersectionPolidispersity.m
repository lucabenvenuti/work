clear all
close all
clc

if (isunix)
    load ('/mnt/benvenutiPFMDaten/simulations/shearCell/20150721shearCellPoliAllDensitiesWithOldShearPerc1ANNsMultiple/20150721shearCellPoliAllDensitiesWithOldShearPerc1ANNsMultipleRes.mat', 'res');
    load('/mnt/benvenutiPFMDaten/simulations/aor/20150721AoRMatlabAndFigures/20150721AoRpolidispersityMultipleANNsTris.mat','resAoR');
    load /mnt/benvenutiPFMDaten/simulations/input/testPolidispersityCokeCoarseCokeFineSinterFineLimestoneFineMatlab/inputRadSigma.mat
    addpath('/mnt/DATA/liggghts/work/shearCell/matlab/exportFig');
else
    load ('R:\simulations\shearCell\20150721shearCellPoliAllDensitiesWithOldShearPerc1ANNsMultiple\20150721shearCellPoliAllDensitiesWithOldShearPerc1ANNsMultipleRes.mat', 'res');
    load('R:\simulations\aor\20150721AoRMatlabAndFigures\20150721AoRpolidispersityMultipleANNsTris.mat','resAoR');
    load R:\simulations\input\testPolidispersityCokeCoarseCokeFineSinterFineLimestoneFineMatlab\inputRadSigma.mat
    addpath('E:\liggghts\work\shearCell\matlab\exportFig');
end



%aa = [2:3:39];

resMix{1} = res{5 + 13};

resMix{2} = res{10 + 13};

resMix{3} = res{7 + 13};

resMix{4} = res{9 + 13};

resMix{5} = res{6 + 13};

resMix{6} = res{4 + 13};

resMix{7} = res{8 + 13};

resMix{8} = resAoR;

resMix{9} = res{11 + 13};



for i = [1:7,9]
    
    resMix{i}.angleExp = resAoR{i}.angleExp;
    resMix{i}.material = resAoR{i}.material;
    resMix{i}.gloriaAugustaAorNN01 = resAoR{i}.gloriaAugustaAorNN01;
    resMix{i}.a01 = resAoR{i}.a01;
    
    if (resMix{i}.cond == 1)
        
        int1 = resMix{i}.gloriaAugustaSchulzeNN([2,3,4,5],:)'; %2057
        
        int2 = resMix{i}.gloriaAugustaAorNN01([2,3,4,8],:)';
        
        [resMix{i}.Cia,resMix{i}.ia,resMix{i}.ib] = intersect(int1, int2, 'rows');
        if length(resMix{i}.ia>0)
            disp(['there are valid cases: ',resAoR{i}.material]);
        else
            disp(['no valid: ',resAoR{i}.material]);
        end
        
    else
        resMix{i}.Cia = 0;
        resMix{i}.ia = 0;
        resMix{i}.ib = 0;
        disp(['no valid: ',resAoR{i}.material]);
    end
    
    if resMix{i}.ia > 0
        [ resMix{i}.h1 , resMix{i}.a2 ] = intersectionPlotRadarFun( resMix{i} , i);
    end
    
end

clearvars int*

save -v7.3 20150721IntersectionPolidispersity.mat resMix