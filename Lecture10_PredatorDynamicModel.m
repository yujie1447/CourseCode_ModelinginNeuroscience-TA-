
clear all
dt = 0.01;
t = 1:0.01:100;

a = 5;
b = 0.2;
c = 0.002;
d = 0.1;
x(1) = 100;
y(1) = 20;

for ii =2:length(t)
    x(ii) = x(ii-1) + (a*x(ii-1) - b*x(ii-1)*y(ii-1))*dt;
    y(ii) = y(ii-1) + (c*x(ii-1)*y(ii-1) - d*y(ii-1))*dt;
    
end

figure;
plot(t,x,'r-');hold on
plot(t,y,'b-')
x
y