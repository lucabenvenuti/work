clear all
close all
clc
if (isunix)
   % addpath('/mnt/DATA/liggghts/work/shearCell/matlab/exportFig');
    addpath(genpath('/mnt/DATA/liggghts/work/shearCell/matlab'));
    %addpath(genpath('/mnt/DATA/liggghts/work/shearCell/matlab/gpml'));
    load /mnt/benvenutiPFMDaten/simulations/new/finalSinterFine10070Aor.mat
    graphic = '-opengl';
else
    %addpath('E:\liggghts\work\shearCell\matlab\exportFig');
    addpath(genpath('E:\liggghts\work\shearCell\matlab'));
    %addpath(genpath('E:\liggghts\work\shearCell\matlab\gpml'));
    load R:\simulations\new\finalSinterFine10070Aor.mat
    graphic = '-zbuffer';
end

data2 = gloriaAugustaSchulzeNN';

data2(:,1) = data2(:,1)/max(data2(:,1));

data2(:,2) = data2(:,2)/max(data2(:,2));

data2(:,3) = data2(:,3)/max(data2(:,3));

data2(:,4) = data2(:,4)/max(data2(:,4));


h11 = figure(11);
H = boxplot(data2, 'labels', {'coefficient of restitution','sliding friction','rolling friction','particle density'});
%title('Merge Box plot, normalized over the maximum value: radarPlotAORSinterfine0_1rangePirker1dot0EntireRange2Plot','fontname','times new roman','FontSize',20);
set(gca,'fontname','times new roman','FontSize',20)  % Set it to times
set(findobj(gca,'Type','text'),'fontname','times new roman','FontSize',20,'VerticalAlignment', 'Middle')
%set(text(3:end),'VerticalAlignment', 'Middle');
set(h11, 'Position', [100 100 1500 800],'color','w');
export_fig('MergeBoxPlot','-png', '-nocrop', '-painters', h11);