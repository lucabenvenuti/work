
legend ('numerical coefficient of internal friction \mu_{ie}', 'numerical coefficient of preshear \mu_{psh}', 'numerical coefficient of shear \mu_{sh}', 'Location', 'SouthEast')

figure(20)
sigmaZ = data(ii).sigmaZ;
plot(timesteps,sigmaZ,'Color',cmap(ii,:),'LineWidth',2);
plot(lTimeSteps,sigmaZ,'Color',cmap(ii,:),'LineWidth',2);
plot(data(ii).timesteps,sigmaZ,'Color',cmap(ii,:),'LineWidth',2);
[a,b]=max(sigmaZ)
data(ii).timesteps(b)
for ijhk=1383:1812
data(ii).timesteps(ijhk)=  data(ii).timesteps(ijhk) - (t(1383)-t(1261));
end
for ijhk=1383:1812
data(ii).timesteps(ijhk)=  data(ii).timesteps(ijhk) - (data(ii).timesteps(1383)-data(ii).timesteps(1261));
end
plot(data(ii).timesteps([1:1261,1383:1775])/data(ii).timesteps(b),data(ii).muR([1:1261,1383:1775]),'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1},'Color',cmap(mod(ii,size(cmap,1))+1,:),'LineWidth',2);
figure(hFig(5));
plot(data(ii).timesteps([1:1261,1383:1775])/data(ii).timesteps(b),data(ii).muR([1:1261,1383:1775]),'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1},'Color',cmap(mod(ii,size(cmap,1))+1,:),'LineWidth',2);
figure(hFig(5));
hold on
plot(data(ii).timesteps([1:1261,1383:1775])/data(ii).timesteps(1261),data(ii).muR([1:1261,1383:1775]),'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1},'Color',cmap(mod(ii,size(cmap,1))+1,:),'LineWidth',2);
figure(hFig(5));
plot(data(ii).timesteps([1:1261,1383:1775]),data(ii).muR([1:1261,1383:1775]),'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1},'Color',cmap(mod(ii,size(cmap,1))+1,:),'LineWidth',2);
figure(hFig(5));
for ijhk=1383:1812
data(ii).timesteps(ijhk)=  data(ii).timesteps(ijhk) - (data(ii).timesteps(1383)-data(ii).timesteps(1261));
end
plot(data(ii).timesteps([1:1261,1383:1775]),data(ii).muR([1:1261,1383:1775]),'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1},'Color',cmap(mod(ii,size(cmap,1))+1,:),'LineWidth',2);
t=data(ii).timesteps;
for ijhk=1383:1812
figure(hFig(5));
figure(hFig(5));
for ijhk=1383:1812
data(ii).timesteps(ijhk)=  data(ii).timesteps(ijhk) - (t(1383)-t(1261));
end
plot(data(ii).timesteps([1:1261,1383:1775]),data(ii).muR([1:1261,1383:1775]),'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1},'Color',cmap(mod(ii,size(cmap,1))+1,:),'LineWidth',2);
clear all
figure(hFig(5));
plotForce
t=data(ii).timesteps;
for ijhk=1383:1812
data(ii).timesteps(ijhk)=  data(ii).timesteps(ijhk) - (t(1383)-t(1261));
end
plot(data(ii).timesteps([1:1261,1383:1775]),data(ii).muR([1:1261,1383:1775]),'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1},'Color',cmap(mod(ii,size(cmap,1))+1,:),'LineWidth',2);
[x,y]=ginput(1)
x
plot(data(ii).timesteps([1:1261,1383:1775])/x,data(ii).muR([1:1261,1383:1775]),'LineStyle',lineStyles{mod(ii,numel(lineStyles))+1},'Color',cmap(mod(ii,size(cmap,1))+1,:),'LineWidth',2);
ylim([0 maxMuRall]);
%legend for force plots
leg{5,iCnt(5)} = fname;
iCnt(5) = iCnt(5)+1;
hLeg = legend(leg{5,1:iCnt(5)-1});
xlabel('time [s]');
ylabel('\mu_{ie} [-]');
set(gca,'fontname','times new roman','FontSize',24)  % Set it to times
xlabel('\~{t} [s]');
STEXT('\tilde{t}','Y')
text('\tilde{t}','Y')
[x,y]=ginput(4)
plot(x(1,2),y(1,2),'r')
plot(x(1:2),y(1:2),'r')
hold om
hold on
plot(x(1:2),y(1:2),'r')
plot(x(1:2),mean(y(1:2)),mean(y(1:2)),'r')
plot(x(1:2),mean(y(1:2)),'r')
a=[mean(y(1:2)),mean(y(1:2))]
plot(x(1:2),a,'r')
c=[mean(y(3:4)),mean(y(3:4))]
plot(x(3:4),c,'r')
legend(leg{5,1:iCnt(5)-1})
leg{5,1:iCnt(5)-1}
legend ('force.rad0.000732dcyldp20density3500rest0.7fric0.6rf0.6dt1e-06ctrlStress-10070.0198shearperc0.6rolfrtypepsd2sysunitsifileID23141', '\mu_{psh}', '\mu_{sh}', 'Location', 'SouthEast', ,'FontSize',16)
legend ('force.rad0.000732dcyldp20density3500rest0.7fric0.6rf0.6dt1e-06ctrlStress-10070.0198shearperc0.6rolfrtypepsd2sysunitsifileID23141', '\mu_{psh}', '\mu_{sh}', 'Location', 'SouthEast', 'FontSize',16)
legend ('force.rad0.000732dcyldp20density3500rest0.7fric0.6rf0.6dt1e-06ctrlStress-10070.0198shearperc0.6rolfrtypepsd2sysunitsifileID23141', '\mu_{psh}', '\mu_{sh}', 'Location', 'SouthEast')
gca
, 'Location', 'SouthEast'
legend ('force.rad0.000732dcyldp20density3500rest0.7fric0.6rf0.6dt1e-06ctrlStress-10070.0198shearperc0.6rolfrtypepsd2sysunitsifileID23141', '\mu_{psh}', '\mu_{sh}')
legend ('force.rad0.000732dcyldp20density3500rest0.7fric0.6rf0.6dt1e-06ctrlStress-10070.0198shearperc0.6rolfrtypepsd2sysunitsifileID23141', '\mu_{psh}', '\mu_{sh}','a','b')
children = get(gca, 'children')
delete(children(2))
delete(children(3))
plot(x(1:2),a,'r')
hold on
plot(x(1:2),a,'r')
plot(x(3:4),c,'r')
children = get(gca, 'children')
legend ('force.rad0.000732dcyldp20density3500rest0.7fric0.6rf0.6dt1e-06ctrlStress-10070.0198shearperc0.6rolfrtypepsd2sysunitsifileID23141', '\mu_{psh}', '\mu_{sh}','a','b')
legend ('force.rad0.000732dcyldp20density3500rest0.7fric0.6rf0.6dt1e-06ctrlStress-10070.0198shearperc0.6rolfrtypepsd2sysunitsifileID23141', '\mu_{psh}', '\mu_{sh}', 'Location', 'SouthEast')
legend ('numerical coefficient of internal friction \mu_{ie}', 'numerical coefficient of preshear \mu_{psh}', 'numerical coefficient of shear \mu_{sh}', 'Location', 'SouthEast')
xlim([0.5 maxMuRall]);
xlim([0.5 5]);
length(data(ii).muR)
data(ii).timesteps(2500)/x
xlim([0.5 1.6424]);
xlim([0.5 1.5]);
xlim([0.5 1.6]);
xlim([0.5 1.55]);
legend ('experimental coefficient of internal friction \mu_{ie}', 'experimental coefficient of preshear \mu_{psh}', 'experimental coefficient of shear \mu_{sh}', 'Location', 'SouthEast')
xlabel('t^~ [-]');