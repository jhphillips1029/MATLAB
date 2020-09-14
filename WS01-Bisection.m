% Bisection
% clear; clc

% Define function
f=@(x) x^2 - 5;

% Define bounds
x_l = 0;
x_u = 10;

% Define tolerance
t = 0.002;

% Use a recursive funcion, because recursion is F-U-N FUN!
function ret = bisection (func,b1,b2,tol)
	m = (b2+b1)/2; % Please for the love of god, Joshua, use the correct midpoint formula
	%fprintf('Lower Bound: %5.3f\n',b1);
	%fprintf('Upper Bound: %5.3f\n',b2);
	%fprintf('Median: %5.3f\n\n',m);
	if 0-tol < func(m) && func(m) < 0+tol
		ret = m;
	elseif b2-b1 < 2*tol
		ret = NaN;
	elseif func(m) > 0
		% Gotta get those <> facing the correct direction!
		ret = bisection(func,b1,m,tol);
	elseif func(m) < 0
		ret = bisection(func,m,b2,tol);
	end
end

root = bisection(f,x_l,x_u,t);

fprintf('Root is at %5.3f with f=%5.3f \n',root,f(root))
