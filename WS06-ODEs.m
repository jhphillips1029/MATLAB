% Solving ODEs numerically
clear all; clc;

% Define variables
h = 0.5;
f = @(x,y) 4*y-3;
y_i = @(x,y) y + h*f(x,y);
x_i = @(x) x + h;
x_f = 10;
x0 = 1;
y0 = 1;
num_steps = int32((x_f - x0)/h);
x_array = zeros(1,num_steps);
y_array = zeros(1,num_steps);
x_array(1) = x0;
y_array(1) = y0;

% Iterate to solve
for i=1:num_steps
	x_array(i+1) = x_i(x_array(i));
	y_array(i+1) = y_i(y_array(i));
end

disp(x_array);
disp(y_array);
