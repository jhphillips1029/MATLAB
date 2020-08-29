% Newton-Raphson Method WS
% clear;clc

% Define function
f = @(x) sin(x);

% Define initial guess
xi = 1.5;

% Define tolerance
tol = 1E-5;

% Define solving method
function root = newtRaph(f,xi,tol)
	% Use the secant approximation because I'm lazy af
	fP_approx = ( f(xi-tol)-f(xi) ) / ( -tol );
	xr = xi - f(xi)/fP_approx;
	if f(xr) < tol || -tol < f(xr)
		root = xr;
	else
		root = newtRaph(f,xr,tol);
	end
end

% Implement method
root = newtRaph(f,xi,tol);
% Print results
fprintf("Found root @ x=%5.3f with initial @ xi=%5.3f\n",root,xi);

% Implement method
root = newtRaph(f,1,tol);
% Print results
fprintf("Found root @ x=%5.3f with initial @ xi=%5.3f\n",root,1);


% Define functions
u = @(x,y) x^2 + x*y - 10;
v = @(x,y) y + 3*x*y^2 - 57;

% Define initial guess
pnt = [1,1];
x_i = pnt(1);
y_i = pnt(2);

% Define tolerance
tol = 1E-5;

% Define recursive method
function [root1 root2] = newtRaphMV(u,v,xi,yi,tol)
	% Use secant approximation because I'm lazy af
	dudx_approx = ( u(xi+tol,yi)-u(xi,yi) ) / ( tol );
	dudy_approx = ( u(xi,yi+tol)-u(xi,yi) ) / ( tol );
	dvdx_approx = ( v(xi+tol,yi)-v(xi,yi) ) / ( tol );
	dvdy_approx = ( v(xi,yi+tol)-v(xi,yi) ) / ( tol );

	xr = xi - ( u(xi,yi) * dvdy_approx - v(xi,yi) * dudy_approx ) / ( dudx_approx * dvdy_approx - dudy_approx * dvdx_approx );
	yr = yi - ( v(xi,yi) * dudx_approx - u(xi,yi) * dvdx_approx ) / ( dudx_approx * dvdy_approx - dudy_approx * dvdx_approx );

	if max(abs(xr-xi),abs(yr-yi)) < tol
		root1 = xr;
		root2 = yr;
	else
		[root1 root2] = newtRaphMV(u,v,xr,yr,tol);
	end
end

% Implement method
[root1 root2] = newtRaphMV(u,v,x_i,y_i,tol);

% Print results
fprintf("The root is at x=%5.3f, y=%5.3f if the initial guess is x_i=%5.3f, y_i=%5.3f\n",root1,root2,x_i,y_i)
