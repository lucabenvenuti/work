clear all
close all
clc

cd R:\Materials2Simulation2Application_RnR\BS\Luca_final
addpath('E:\liggghts\work\shearCell\matlab');
listing = dir('*.*')

k = 1

for i = 1:length(listing)
    filename = listing(i).name;
    
    if length(filename) > 3 & strcmp(filename(end-2:end) ,'out') % == ''
        exp(k) = importOut(filename);
        k = k + 1;
    end
end

filename2 = 'testdata.xlsx';
xlswrite(exp, filename2, 1,'E1:I5')