x1 = [50:50:500];
x2 = [50:10:500];
[~,ncol] = size(x2);

attime = 0.4;
step = attime/deltim;

Psimulated = reshape(Psim(step,:),20,20);

analytic = [];

for i=1:ncol
    analytic = [analytic analyticsol(x2(i),mu,ct)];
end

plot(x1,Psimulated(10,11:20),x2,analytic,'LineWidth',2);
grid on;
xlabel('Distance from Well [m]');
ylabel('Pressure [MPa]');
tit1 = strcat('Radial Pressure Distribution at Time t = ',num2str(attime));
l1=legend('Simulated Pressure Distribution','Analytical Solution','Location','SouthEast');
title(tit1);