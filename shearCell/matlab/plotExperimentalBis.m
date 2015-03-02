x=time-time(1);%unnamed;
y=tau/2029;%unnamed1;
plot(x,y)
xlabel('time [s]')
%ylabel('\mu_{ie}')
ylabel('\mu_{ie} [-]')
%title (['Sinter fine - normal stress = 2000 [Pa]', 'FontSize',24)
title (['Sinter fine - normal stress = 2000 [Pa]'], 'FontSize',24)
set(gca,'fontname','times new roman')
set(gca,'FontSize',20) ;
xlabel('time [s]','FontSize', 20);
ylabel('\mu_{ie} [-]', 'FontSize', 20);
title (['Sinter fine - experimental - normal stress = 2000 [Pa]'], 'FontSize',24)
a=find(y<0.01);
a=find(y<0.05);
a=find(x==300);
a=max(find(x<336));
b=min(find(x>438));
%x=unnamed(1:a,b:end);
x=time(1:a);
length(time)
length(time)-b
%x(a+1:a+length(time)-b) = time(b:end)
x(a+1:a+length(time)-b+1) = time(b:end);
y=tau(1:a)/2029;
y(a+1:a+length(tau)-b+1) = tau(b:end)/(2029*.8);
%plot(x,y)

c = time(b)-time(a);
for i=(a+1):(a+length(time)-b+1)
x(i)=x(i)-c;
end
plot(x/335.4523,y)
xlim([0.5 364/335.4523])
title (['Sinter fine - experimental - normal stress = 2000 [Pa]'], 'FontSize',24)
xlabel('time [s]','FontSize', 20);
ylabel('\mu_{ie} [-]', 'FontSize', 20);