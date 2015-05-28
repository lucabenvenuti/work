clear all
close all
clc

diameterIronOreCoarseReal = [6.3; 5.6; 3.55; 2; 1]/1000;
weightIronOreCoarseReal= [0.101676719;	0.119218182;	0.519542204;	0.259562895;	0];

diameterIronOreFineReal = [0.002000;0.001600;0.001250;0.001000;0.0008000;0.0006300;0.0005000;0.0003150;0.00000001];
weightIronOreFineReal= [0.353978984000000;0.174765409000000;0.149244687000000;0.129140480000000;0.0634363330000000;0.0513413220000000;0.0320992590000000;0.0169929900000000;0.0290005370000000];





%diameter = [0.00450;0.00350;0.00250;0.00150];
diameter2 = [0.005;0.004;0.003;0.002;0.001];

wei(:,1) = [0.45; 0.05; 0.05; 0.45]; %gollum 40 1st round
wei(:,2) = [0.0500;0.450;0.450;0.0500];  %gollum 41 1st round
wei(:,3) = [0.25;0.25;0.25;0.25];
wei(:,4) = [0.33;0.17;0.17;0.33];

wei2(:,1) = [0.2;0.2;0.2;0.2;0.2];
wei2(:,2) = [0.1;0.25;0.3;0.25;0.1];
wei2(:,3) = [0.05;0.2;0.5;0.2;0.05];
wei2(:,4) = [0.05;0.1;0.7;0.1;0.05];

wei3 = [0.1960,0.2600,0.1730,0.1300,0.1100,0.1310]';
diameter3 = [0.006000,0.01000,0.01600,0.02500,0.04000,0.05000]';

j=1;
for i=13 %[9:12]
    
    if i<5
        diameter = [0.00450;0.00350;0.00250;0.00150];
        weight = wei(:,i);   
    elseif i == 5
         diameter =    [2	1.6	1.25	1	0.63	0.315]'/1000; %limestone	fine	sim
         weight = [0.342	0	0.107	0.01	0.327	0.214]';
    elseif i == 6
         diameter =    [2	1.6	1.25	1	0.8	0.63]'/1000; %coke	fine	sim
         weight = [0.050	0.000	0.000	0.000	0.000	0.950]';
    elseif i == 7
         diameter =    [6.3	5.6	3.55	2	1]'/1000; %coke	coarse	sim
         weight = [0.000	0.080	0.920	0.000	0.000]';
    elseif i == 8
         diameter =    [2	1.6	1.25	0.63	0.315]'/1000; %sinter fine	sim
         weight = [0.6205	0.0000	0.1050	0.2299	0.0446]';
    elseif i > 8 & i < 13
         diameter =   diameter2;
         weight = wei2(:,i-8);
    elseif i == 13
        diameter =   diameter3;
         weight = wei3 ;
    end
    
    radius = diameter/2;
 
weightedMeanDiam(i) = mean(weight.'*diameter,2);
stddevDiam(i)=sqrt(var(diameter, weight));

weightedMeanRad(i) = mean(weight.'*radius,2);
stddevRad(i)=sqrt(var(radius, weight));


x = [min(diameter):(max(diameter)-min(diameter))/199:max(diameter)];
norm = normpdf(x,weightedMeanDiam(i),stddevDiam(i));
norm=norm/max(norm);

x2 = [min(radius):(max(radius)-min(radius))/199:max(radius)];
norm2 = normpdf(x2,weightedMeanRad(i),stddevRad(i));
norm2=norm2/max(norm2);

minDiam = 0.000315;
maxDiam = 6.3/1000;

% figure(j);
% %xlim = ([minDiam  maxDiam]);
% bar(diameter,weight)
% %xlim = ([minDiam  maxDiam]);
% hold on
% plot(x,norm)
% xlim([minDiam  maxDiam]);
% hold off

j=j+1;

h1=figure(j);
bar(radius,weight)
hold on
plot(x2,norm2)
xlim([minDiam  maxDiam]/2);
xlabel('radius [m]');
ylabel('% [--]');
hold off
print(h1,'-djpeg','-r300',['0',num2str(41+i),'simulationRadiusDistribution',num2str(i)])
j=j+1;

end