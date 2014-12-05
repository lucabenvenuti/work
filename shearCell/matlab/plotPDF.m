close all;

COR10070SFRangeReduced = createFit(S);
figure(1)
xlabel('COR', 'FontSize', 20)
ylabel('Density', 'FontSize', 20)
title (['normal stress = 10070SFRangeReduced'], 'FontSize', 20);
legend('COR','normal distribution','FontSize', '20');
set(gca,'FontSize',20) ;
saveas(1,['COR10070SFRangeReducedPDF','.tif']);
close all;

SF10070SFRangeReduced = createFit(X);
%figure(2)
xlabel('SF', 'FontSize', 20)
ylabel('Density', 'FontSize', 20)
title (['normal stress = 10070SFRangeReduced'], 'FontSize', 20);
legend('SF','normal distribution','FontSize', '20');
set(gca,'FontSize',20) ;
saveas(1,['SF10070SFRangeReducedPDF','.tif']);
close all;

RF10070SFRangeReduced = createFit(Y);
%figure(3)
xlabel('RF', 'FontSize', 20)
ylabel('Density', 'FontSize', 20)
title (['normal stress = 10070SFRangeReduced'], 'FontSize', 20);
legend('RF','normal distribution','FontSize', '20');
set(gca,'FontSize',20) ;
saveas(1,['RF10070SFRangeReducedPDF','.tif']);
close all;


particledensity10070SFRangeReduced = createFit(Z);
%figure(4)
xlabel('particledensity', 'FontSize', 20)
ylabel('Density', 'FontSize', 20)
title (['normal stress = 10070SFRangeReduced'], 'FontSize', 20);
legend('particledensity','normal distribution','FontSize', '20');
set(gca,'FontSize',20) ;
saveas(1,['particledensity10070SFRangeReducedPDF','.tif']);
close all;

PDF10070SFRangeReduced{1} = COR10070SFRangeReduced;
PDF10070SFRangeReduced{2} = SF10070SFRangeReduced;
PDF10070SFRangeReduced{3} = RF10070SFRangeReduced;
PDF10070SFRangeReduced{4} = particledensity10070SFRangeReduced;
save(['PDF10070SFRangeReducedsinterfine0-1', '.mat'], 'PDF10070SFRangeReduced');