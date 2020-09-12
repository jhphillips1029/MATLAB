% Homework 4
% clear all; clc;
graphics_toolkit("gnuplot"); % Used for plotting in Octave compiler

% Given
D_t = 1;
D_o = 0.01;
g = 9.8;
f = @(t,h) -( D_o^2 / D_t^2 ) * ( 2*g*h )^0.5;

h(1) = 1.0;
t(1) = 0.0;
dt = 0.1;

i = 1;
while ( h(i) > 0 )
	t(i+1) = t(i) + dt;
	h_star = h(i) + dt*f(t(i),h(i));
	h(i+1) = h(i) + 0.5*dt*f(t(i),h(i)) + 0.5*dt*real(f(0,h_star)); % calling real portion because MATLAB fucking sucks
	i = i+1;
end

figure(1); clf(1);
plot(t,h);
saveas(figure(1),'images/HW4_1.png');

fprintf('End Time: %5.5f\n\th=%5.5f\n',t(i),h(i));

f = @(x,y) -1000*y + 3000 - 2000*exp(-x);
y(1) = 0;
x(1) = 0;
h = 0.0015;
Lx = 1;
num_steps = Lx/h;
f_anal = @(x) 3 - 0.998*exp(-1000*x) - 2.002*exp(-x);

for i=1:num_steps
	x(i+1) = x(i) + h;
	k1 = f(x(i),y(i));
	k2 = f(x(i) + h/2,y(i)+h*k1/2);
	k3 = f(x(i) + h/2,y(i)+h*k2/2);
	k4 = f(x(i) + h,y(i)+h*k3);
	y(i+1) = y(i) + 1/6*(k1+k2+k3+k4);
end

figure(2); clf(2);
%plot(x,y);
%hold on;
y_anal = f_anal(x);
plot(x,y_anal);
%legend('RK4','Analytical');
%saveas(figure(2),'images/HW4_2a.png');

y_e(1) = 0;
for i=1:num_steps
	y_e(i+1) = y_e(i) + h*f(x(i),y_e(i));
end
%plot(x,y_e);
%legend('RK4','Analytical','Euler');
%saveas(figure(2),'images/HW4_2b.png');
hold off;

wait = input('Press Enter to Exit.');
