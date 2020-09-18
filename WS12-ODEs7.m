% WS 12 - ODEs 7
clear; clc;

% Inputs
T1 = 40;
T2 = 200;
Ta = 20;
L = 10;
k = 0.01;

% Choose variables
N = 20;
tol = 1e-2;

% Create grid
x = linspace(0,L,N);
T = zeros(1,N);
h=L/N;

% Apply boundary conditions
T(1) = T1;
T(N) = T2;
T_old = T;

% Iterate
for n=1:1000
	% Update all T but boundary
	for i=2:N-1
		T(i) = (k*Ta + (1/(h^2))*(T_old(i+1)+T_old(i-1)))/(2/(h^2) + k);
	end
	
	% Plot
	if mod(n,10)==0
		plot(x,T,'DisplayName',strcat('Iter ',num2str(n)));
		drawnow;
	end
	
	% Check for convergence
	err = max(abs(T-T_old));
	T_old = T;
	if err < tol
		fprintf('Converged.\n');
		break
	end
end

plot(x,T,'DisplayName',strcat('Iter ',num2str(n)));
hold on;

C1 = ( T2-Ta+(Ta-T1)*e^(-L*k^0.5) )/( e^(L*k^0.5) - e^(-L*k^0.5) );
C2 = T1-C1-Ta;
f_anal = @(x) C1*exp(x*sqrt(k)) + C2*exp(-x*sqrt(k)) + Ta;
T_anal = f_anal(x);
plot(x,T_anal,'DisplayName','Analytic')

% plot(x,(T2-T1)/L*x+T1,'DisplayName','Line');

legend();
drawnow;
saveas(gcf,'images/WS12.png');

wait=input('Press Enter to Exit');
