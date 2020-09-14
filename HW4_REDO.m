% HW4 restart
clear all; clc;

D_o = 0.01;
D_t = 1.0;
g = 9.8;
f = @(t,h) -(D_o^2/D_t^2)* (2*g*h)^0.5;
h(1) = 1;
t(1) = 0;

dt = 10;

i = 1;
while h(i) > 0
    t(i+1) = t(i) + dt;
    h_star = h(i) + dt*f(t(i),h(i));
    h(i+1) = h(i) + dt/2*( f(t(i),h(i)) + real(f(t(i+1),h_star)) );
    i=i+1;
end

figure(1); clf(1);
plot(t,h);
fprintf('Time taken: %5.2f (h=%5.5f)\n',t(i),h(i));

f=@(x,y) -1000*y + 3000 - 2000*exp(-x);
x(1) = 0;
y(1) = 0;
Lx = 1;
h = 0.0015;
num_steps = Lx/h;

for i=1:num_steps
    x(i+1) = x(i) + h;
    k1 = f(x(i),y(i));
    k2 = f(x(i)+h/2,y(i)+h*k1/2);
    k3 = f(x(i)+h/2,y(i)+h*k2/2);
    k4 = f(x(i)+h,y(i)+h*k3);
    y(i+1) = y(i) + 1/6*(k1+k2+k3+k4);
end

f_anal = @(c) 3 - 0.998*exp(-1000*c)-2.002*exp(-c);
y_anal = f_anal(x);

figure(2); clf(2);
plot(x,y);
hold on;
plot(x,y_anal);

y_e(1) = 0;
for i=1:num_steps
    y_e(i+1) = y(i) + h*f(x(i),y(i));
end

plot(x,y_e);
legend('Numerical','Analytic','Euler');