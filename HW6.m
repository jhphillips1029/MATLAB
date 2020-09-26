% Homework 6
% clear; clc;

% Given
L =    10     ; %m
E =   200.0E9 ; %Pa
I =     4.0E-6; %m^4
q = -1000     ; %N/m

N = 6;
dx = L/N;

function [x,u] = solveMe(L,N,diagonal_terms,B_terms,degree=2,showMatrices=false)
	A = zeros(N,N);
	B = zeros(N,1);

	for i=[1:degree/2,N-(degree/2-1):N]
		A(i,i) = 1;
	end

	for i=1+degree/2:N-degree/2
		for j=1:length(diagonal_terms)
			A(i,[i-j+1,i+j-1]) = diagonal_terms(j);
		end
		B(i) = B_terms;
	end
	
	if showMatrices
		fprintf("A = \n");
		disp(A);
		fprintf("\nB = \n");
		disp(B);
	end

	u = inv(A)*B;
	x = linspace(0,L,N);
end

diagonal_terms = [6/dx^2,-4/dx^2,1/dx^2];
B_terms = q/(E*I);

figure(1); clf(1);
fprintf("Problem 2(a):\n");
[x,u] = solveMe(L,N,diagonal_terms,B_terms,4,true);
plot(x,u);

N = 50;
dx = L/N;
diagonal_terms = [6/dx^2,-4/dx^2,1/dx^2];

figure(2); clf(2);
[x,u] = solveMe(L,N,diagonal_terms,B_terms,4);
plot(x,u);
drawnow;

wait = input("Press Enter to Exit.");
