function [ yReg, handler ] = plotRegressionAorFun( numFig, titleName, xOrig, yOrig, mReg, qReg )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

handler = figure(numFig);
yReg = xOrig * mReg + qReg;
plot(xOrig, yOrig, 'ok', xOrig, yReg, 'b');
xlim([min(xOrig),max(xOrig)]);
ylim([min(yOrig),max(yOrig)]);
legend('training values','regression line','Location', 'NorthWest');
xlabel('AoR_{DEM} [-]','fontname','times new roman','FontSize',36);
ylabel(['AoR_{, ', titleName, '} [-]'],'fontname','times new roman','FontSize',36);
set(gca,'fontname','times new roman','FontSize',20)
set(handler, 'Position', [100 100 1500 800],'color','w');
export_fig(['AoR',titleName],'-png', '-nocrop', '-painters', handler);
matlab2tikz( ['AoR',titleName, '.tikz'] );
end

