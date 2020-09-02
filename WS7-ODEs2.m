% cOdE
% clear all; clc;

% Variables
x(1)=0;
y(1)=0;
Q=0.1;
V=5;
C_in=2;
f=@(t,C) Q/V*(C_in - C);
h=10;
Lx=400;
num_steps = Lx/h;

for i=1:num_steps
	x(i+1) = x(i)+h;
	y(i+1)=y(i)+h*f(x(i),y(i));
end

plot(x,y);
hold on;

C_act = @(t) C_in*(1-exp(-Q*t/V));
plot(x,C_act(x));
legend('Numerical','Analytical');

wait = input("Press Enter to Exit.");
