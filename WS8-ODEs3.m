% Heun's Method
% clear all; clc;

% Define necessary variables
f=@(t,y) 2*t*y;
h = 0.01;
x(1) = 1;
y_e(1) = 1;
y_h(1) = 1;
Lx = 5;
num_steps = Lx/h;

for i=1:num_steps
	x(i+1) = x(i) + h;
	y_e(i+1) = y_e(i) + h*f(x(i),y_e(i));
	y_star = y_h(i) + h*f(x(i),y_h(i));
	y_h(i+1) = y_h(i) + h/2*( f(x(i),y_h(i)) + f(x(i+1),y_star) );
end

figure(1); clf(1);
plot(x,y_e);
hold on;
plot(x,y_h);
legend('Euler','Heun');

f=@(x,y) 2*cos(x) + 0.2;
h = 0.01;
y_e=0;y_e(1)=2;
y_h=0;y_h(1)=2;
x=0;x(1)=0;
Lx = 5*pi;
num_steps = Lx/h;

for i=1:num_steps
	x(i+1) = x(i) + h;
	y_e(i+1) = y_e(i) + h*f(x(i),y_e(i));
	y_star = y_h(i) + h*f(x(i),y_h(i));
	y_h(i+1) = y_h(i) + h/2*( f(x(i),y_h(i)) + f(x(i+1),y_star));
end

f_analytic = @(x) 2*sin(x)+0.2*x+2;
y_a = f_analytic(x);

figure(2); clf(2);
plot(x,y_a);
hold on;
plot(x,y_e);
plot(x,y_h);
legend('Analytic','Euler','Heun');

diff = abs(y_a-y_h);
disp(max(diff));

wait = input('Press Enter to Exit.');
