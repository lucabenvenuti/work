x=unnamed;
y=unnamed1;
plot(x,y)
xlabel('time [s]')
ylabel('\mu_{ie}')
ylabel('\mu_{ie} [-]')
title (['Sinter fine - normal stress = 2000 [Pa]', 'FontSize',24)
title (['Sinter fine - normal stress = 2000 [Pa]'], 'FontSize',24)
set(gca,'fontname','times new roman')
set(gca,'FontSize',20) ;
xlabel('time [s]','FontSize', 20);
ylabel('\mu_{ie} [-]', 'FontSize', 20);
title (['Sinter fine - experimental - normal stress = 2000 [Pa]'], 'FontSize',24)
a=find(y<0.01);
a=find(y<0.05);
a=find(x==300);
a=max(find(x<300));
b=min(find(x>350));
x=unnamed(1:a,b:end);
x=unnamed(1:a);
length(unnamed)
length(unnamed)-b
x(a+1:a+length(unnamed)-b) = unnamed(b:end)
x(a+1:a+length(unnamed)-b+1) = unnamed(b:end)
y=unnamed1(1:a);
y(a+1:a+length(unnamed1)-b+1) = unnamed1(b:end)
plot(x,y)
for i=(a+1):(a+length(unnamed)-b+1)
x(i)=x(i)-50
end
plot(x,y)
title (['Sinter fine - experimental - normal stress = 2000 [Pa]'], 'FontSize',24)
xlabel('time [s]','FontSize', 20);
ylabel('\mu_{ie} [-]', 'FontSize', 20);