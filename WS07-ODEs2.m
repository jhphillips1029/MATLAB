% cOdE
% clear all; clc;

% Problem 2
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

figure(1);clf(1);
plot(x,y);
hold on;

C_act = @(t) C_in*(1-exp(-Q*t/V));
plot(x,C_act(x));
legend('Numerical','Analytical');

x=0;y=0;

%Problem 3a
f=@(x,y) cos(x)*y;
x(1)=0; y(1)=-1;
h = 0.001;
Lx = 10;
num_steps = Lx/h;
for i=1:num_steps
	x(i+1) = x(i) + h;
	y(i+1) = y(i) + h*f(x(i),y(i));
end

figure(2); clf(2);
plot(x,y);
hold on;

y_act = @(x) -exp(sin(x));
plot(x,y_act(x));
legend('Numerical','Analytical');

% Problem 3b
f=@(t,y) -t*y - sin(t)*t^2;
x=0;x(1)=0;
y=0;y(1)=0;
h=0.001;
Lx=10;
num_steps=Lx/h;
for i=1:num_steps
	x(i+1)=x(i)+h;
	y(i+1)=y(i)+h*f(x(i),y(i));
end

figure(3); clf(3);
plot(x,y);

%wait = input("Press Enter to Exit.");
