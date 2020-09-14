% Problem 2
% clear all; clc;

% Given:
f = @(x,y) cos(x)*y;
h = 0.5;
y(1) = -1;
x(1) = 0;
f_anal = @(x) -exp(sin(x));
Lx = 10;
num_steps = Lx/h;

for i=1:num_steps
	k1 = f(x(i),y(i));
	k2 = f(x(i)+h/2,y(i)+k1*h/2);
	k3 = f(x(i)+h/2,y(i)+k2*h/2);
	k4 = f(x(i)+h,y(i)+k3*h);
	x(i+1) = x(i)+h;
	y(i+1) = y(i) + 1/6*(k1+2*k2+2*k3+k4)*h;
end

y_e(1) = -1;
for i=1:num_steps
	y_e(i+1) = y_e(i) + h*f(x(i),y_e(i));
end

plot(x,y);
hold on;
y_anal = f_anal(x);
plot(x,y_anal);
plot(x,y_e);
legend('Numerical','Analytical','Euler');

wait = input('Press Enter to Exit.');
