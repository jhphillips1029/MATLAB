% Solving for height above water using Archimedes Principal
% clear; clc

% Define variables
rho_w = 1E3;
g = 9.81;
r = 1;
W = 8210;
t = 1E-5;

% Define net force function
f = @(h) rho_w*g*( 4/3*pi*r^3 - (pi*h^2)/3*(3*r-h) ) - W;

% Define recursive method
function root = lin_interp(f,x1,x2,tol)
	xm = x1 - (f(x1)  *(x1-x2))/(f(x1)  -f(x2));

	% Conditionals
	if abs(xm-x1)<tol || abs(xm-x2)<tol
		root = xm;
	elseif f(x1)*f(x2) < 0
		root = lin_interp(f,x1,xm,tol);
	else
		root = lin_interp(f,xm,x2,tol);
	end
end

% Apply method to function
% Choosing bounds based on radius of object
root1 = lin_interp(f,0,2*r,t);

% Display results
fprintf('The root of the function is %5.3f\n',root1)
