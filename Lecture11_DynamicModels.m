%% population growth model
clear all
dt = 0.01;
t = 1:dt:1000;

a = 0.2;
A = 100;
x(1) = 1;
y(1) = 1;
for ii =2:length(t)
    x(ii) = x(ii-1) + a*(1-x(ii-1)/A)*x(ii-1)*dt;
    y(ii) = y(ii-1) + a*y(ii-1)*dt;
end

figure;
plot(t,exp(a*t),'r--','linewidth',1.5);hold on % analytical solution

plot(t,y,'r--','linewidth',1.5);hold on
plot(t,x,'r-','linewidth',1.5);hold on
plot(t,t.*0+A,'k--','linewidth',1.5)
ylim([0 150]);
xlabel('Time / Days');ylabel('Number');box off

