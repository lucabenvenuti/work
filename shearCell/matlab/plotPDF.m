close all;

COR10070 = createFit(S);
figure(1)
xlabel('COR', 'FontSize', 20)
ylabel('Density', 'FontSize', 20)
title (['normal stress = 10070'], 'FontSize', 20);
legend('COR','normal distribution','FontSize', '20');
set(gca,'FontSize',20) ;
saveas(1,['COR10070PDF','.tif']);
close all;

SF10070 = createFit(X);
%figure(2)
xlabel('SF', 'FontSize', 20)
ylabel('Density', 'FontSize', 20)
title (['normal stress = 10070'], 'FontSize', 20);
legend('SF','normal distribution','FontSize', '20');
set(gca,'FontSize',20) ;
saveas(1,['SF10070PDF','.tif']);
close all;

RF10070 = createFit(Y);
%figure(3)
xlabel('RF', 'FontSize', 20)
ylabel('Density', 'FontSize', 20)
title (['normal stress = 10070'], 'FontSize', 20);
legend('RF','normal distribution','FontSize', '20');
set(gca,'FontSize',20) ;
saveas(1,['RF10070PDF','.tif']);
close all;


particledensity10070 = createFit(Z);
%figure(4)
xlabel('particledensity', 'FontSize', 20)
ylabel('Density', 'FontSize', 20)
title (['normal stress = 10070'], 'FontSize', 20);
legend('particledensity','normal distribution','FontSize', '20');
set(gca,'FontSize',20) ;
saveas(1,['particledensity10070PDF','.tif']);
close all;

PDF10070{1} = COR10070;
PDF10070{2} = SF10070;
PDF10070{3} = RF10070;
PDF10070{4} = particledensity10070;
save(['PDF10070sinterfine0-1', '.mat'], 'PDF10070');