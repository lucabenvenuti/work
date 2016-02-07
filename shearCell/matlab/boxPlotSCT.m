
if (isunix)
    addpath(genpath('/mnt/DATA/liggghts/work/shearCell/matlab'));
else
    addpath(genpath('E:\liggghts\work\shearCell\matlab'));
end

data2 = gloriaAugustaSchulzeNN([2,3,4,9],:)';

data2(:,1) = data2(:,1)/max(data2(:,1));

data2(:,2) = data2(:,2)/max(data2(:,2));

data2(:,3) = data2(:,3)/max(data2(:,3));

data2(:,4) = data2(:,4)/max(data2(:,4));


h11 = figure(11);
H = boxplot(data2, 'labels', {'coefficient of restitution','sliding friction','rolling friction','particle density'});
%title('Box plot, normalized over the maximum value: radarPlot10070sinterfine0_1range','fontname','times new roman','FontSize',20);
set(gca,'fontname','times new roman','FontSize',20)  % Set it to times
set(findobj(gca,'Type','text'),'fontname','times new roman','FontSize',20,'VerticalAlignment', 'Middle')
%set(text(3:end),'VerticalAlignment', 'Middle');
set(h11, 'Position', [100 100 1500 800],'color','w');
export_fig('SCTBoxPlot','-png', '-nocrop', '-painters', h11);
