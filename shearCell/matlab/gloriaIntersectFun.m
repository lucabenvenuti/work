function [ expList, gloriaSCT, gloriaAOR, Cia, ia, ib ] = gloriaIntersectFun( gloriaAugustaSchulzeNNDens, gloriaAugustaAor )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here


expList = {
    'cokecoarse_1', 1 , 14, 1;
    'cokecoarse_2', 1, 15, 2;
    'cokefine_3', 2, 16, 3;
    'cokefine_4', 2, 17, 4;
    'cokefine_5', 2, 18, 5;
    'ironorecoarse_6', 3, 19, 6;
    'ironorecoarse_7', 3, 20, 7;
    'ironorecoarse_8', 3, 26, 8;
    'ironorefine_9', 4, 21, 9;
    'ironorefine_10', 4, 22, 10;
    'ironorefine_11', 4, 23, 11;
    'ironorefine_12', 4, 24, 12;
    'ironorefine_13', 4, 25, 13;
    'limestonecoarse_14', 5, 8, 14;
    'limestonecoarse_15', 5, 9, 15;
    'limestonefine_16', 6, 10, 16;
    'limestonefine_17', 6, 11, 17;
    'limestonefine_18', 6, 12, 18;
    'limestonefine_19', 6, 13, 19;
    'sintercoarse_20', 7, 1, 20;
    'sintercoarse_21', 7, 2, 21;
    'sintercoarse_22', 7, 3, 22;
    'sinterfine_23', 8, 4, 23;
    'sinterfine_24', 8, 5, 24;
    'sinterfine_25', 8, 6, 25;
    'sinterfine_26', 8, 7, 26;
    'cokecoarse_27', 1, 0, 27;
    'ironorecoarse_28', 3, 0, 28;
    'ironorefine_29', 4, 0, 29;
    'ironorefine_30', 4, 0, 30;
    'sintercoarse_31', 7, 0, 31;
    'sinterfine_32', 8, 0, 32;
    'sinterfine_33', 8, 0, 33 };

for i = 1:26
    
    gloriaSCT{i} = gloriaAugustaSchulzeNNDens{expList{i, 3}}(:,[2:5]);
    gloriaAOR{i} = gloriaAugustaAor{expList{i, 2}}(:,[2:5]);
    [Cia{i},ia{i},ib{i}] = intersect(gloriaSCT{i},gloriaAOR{i},'rows');
    
end

[Cia{27},ia{27},ib{27}] = intersect(Cia{1},Cia{2},'rows'); %cokecoarse
[Cia{28},ia{28},ib{28}] = intersect(Cia{7},Cia{8},'rows'); %ironorecoarse
[Cia{29},ia{29},ib{29}] = intersect(Cia{9},Cia{10},'rows');
[Cia{30},ia{30},ib{30}] = intersect(Cia{29},Cia{13},'rows');%ironorefine
[Cia{31},ia{31},ib{31}] = intersect(Cia{21},Cia{22},'rows');%sintercoarse
[Cia{32},ia{32},ib{32}] = intersect(Cia{24},Cia{25},'rows');
[Cia{33},ia{33},ib{33}] = intersect(Cia{32},Cia{26},'rows'); %sinterfine

end

