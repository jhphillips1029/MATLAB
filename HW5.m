% HW 5 - Dampened Spring
% clear; clc;

% Problem 1
m = 5;   %kg
k = 0.5; %N/m
c_all = [0,sqrt(4*m*k)-1,sqrt(4*m*k)+1,sqrt(4*m*k)];
T = 40;

% let:
%	u1=y 	=>   u1'=y' =u2
%	u2=y'	=>   u2'=y''=-c/m*u2 - k*u1

figure(1); clf(1);
for i=1:length(c_all)
	x=0;u=0;
	c = c_all(i);
	f=@(x,u) [u(2),-c/m*u(2)-k/m*u(1)];

	u0 = [1,1];
	t_span = [0,T];

	[x,u] = ode45(f,t_span,u0);
	plot(x,u(:,1),'DisplayName',strcat("c",num2str(i)));
	if i==1
		hold on;
	end
end

A = 1;
B = 1;
omega_0 = sqrt(k/m);
f_anal = @(x) A*cos(omega_0*x) + B*sin(omega_0*x);
x_anal = linspace(0,T,T/0.01);
y_anal = f_anal(x_anal);
plot(x_anal,y_anal,'DisplayName','Analytic');

legend();

% Problem 2
% u1 = y    =>   u1' = u2
% u2 = y'   =>   u2' = w/T*sqrt(1+u2^2)

% choose variables
w = 2;
T = 52;
L = 10;

% Define problem
f=@(x,u) [u(2),w/T*sqrt(1+(u(2))^2)];
f_span = [0,L];
guess = 10;
y1 = 0;
y2 = 0;

% tolerance and error
tol = 1e-2;
err = 1;

% Shooting method
n=1;
for n=1:1000
	% Update initial guess
	u0 = [y1,guess];
	
	% Solve
	[x,u] = ode45(f,f_span,u0);
	    
	% Check for error
	err = abs(y2-u(length(u),1));
	guess = guess + 0.001*(y2-u(length(u),1));
	if (err < tol)
		break;
	end
end

figure(2); clf(2);
plot(x,u(:,1),'DisplayName','Chain');
legend();

wait = input('Press Enter to Exit');
