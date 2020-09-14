% Worksheet 5
% clear; clc;

% Given
E = 10^8;
I = 50;
L = 10;
w=@(x) 500*x;

% ODE
% u1=y,u2=y',u3=y'',u4=y'''
f=@(x,u) [ u(2),u(3),u(4),w(x)/(E*I) ];

% Boundary Conditions
u0 = [0,0,0,0];

% Define solution interval
x_span = [0,L];

% Solve
[x,u]=ode45(f,x_span,u0);

% Plot results
plot(x,u(:,1));
saveas(gca,'~/Documents/output.png');

wait = input("Wait.");
