function a2 = boxPlotFun( gloriaAugustaSchulzeNN, aorFlag, numFig, exp_file_name, coeffPirker)
%UNTITLED4 Summary of this function goes here
%( gloriaAugustaSchulzeNN, aorFlag, numFig, dataNN2, exp_file_name, coeffPirker)
%   Detailed explanation goes here


switch aorFlag
    case 1 %aor
        data2 = gloriaAugustaSchulzeNN([2,3,4,7],:)';
    case 2 %mix
        data2 = gloriaAugustaSchulzeNN([1,2,3,4],:)';
    otherwise %sct
        data2 = gloriaAugustaSchulzeNN([2,3,4,9],:)';
end


data2(:,1) = data2(:,1)/max(data2(:,1));
data2(:,2) = data2(:,2)/max(data2(:,2));
data2(:,3) = data2(:,3)/max(data2(:,3));
data2(:,4) = data2(:,4)/max(data2(:,4));


handler = figure(numFig);
a2 = boxplot(data2, 'labels', {'coefficient of restitution','sliding friction','rolling friction','particle density'});
set(gca,'fontname','times new roman','FontSize',20)  % Set it to times
set(findobj(gca,'Type','text'),'fontname','times new roman','FontSize',20,'VerticalAlignment', 'Middle')
set(handler, 'Position', [100 100 1500 800],'color','w');

formatOut = 'yyyy-mm-dd-HH-MM-SS';
date1 = datestr(now,formatOut);

switch aorFlag
    case 1 %aor
        savefig(['BoxAOR', exp_file_name, date1, '.fig']);
    case 2 %mix
        savefig(['BoxMix', date1, '.fig']);
    otherwise %sct
        savefig(['BoxSCT', exp_file_name, 'coeffP', num2str(coeffPirker),date1, '.fig']);
end

end

