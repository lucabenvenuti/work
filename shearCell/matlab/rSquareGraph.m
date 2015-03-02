a=4:4:length(errorNN2); %test
%length(a)
for i =1:length(a)
    b(i)=errorNN2(a(i)).r2(2);
end
    
plot(a/4+4,b) %avgMuR1

c=1:4:length(errorNN2); %test
%length(a)
for i =1:length(a)
    d(i)=errorNN2(c(i)).r2(2);
end
  
figure(2)
plot((c-1)/4+5,d) %avgMuR1

figure(3)
plot(a/4+4,b,'k-', (c-1)/4+5,d, 'k--');
coeffPirker =1;

legend('test','total', 'Location','SouthWest');%,'FontSize',20)
title (['Shear Cell: \sigma_n = 10070 [Pa], coeff. P. = ', num2str(coeffPirker)], 'FontSize', 20);
%set(gca, 'xlim', [0 1], 'ylim', [0 1],'FontSize',20);

%scatter(X,Y,[],S, 'x');
set(gca,'FontSize',20) ;
xlabel('Number of hidden neurons', 'FontSize', 20);
ylabel('R^2 value', 'FontSize', 20);