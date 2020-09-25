% ODE Worksheet 8 - Matrix approach
% clear; clc

% Given
T1 = 40;
T2 = 200;
Ta = 20;
k = 0.01;
L = 10;

N = 4;
dx = L/N;

Y1 = T1;
YN = T2;
C_curr = -k;
C_prev = 0;
C_next = 0;
C_B = -k*Ta;

A = zeros(N,N);
B = zeros(N,1);

A(1,1) = 1;
for j=2:N
	A(1,j) = 0;
end
A(N,N) = 1;
for j=1:N-1
	A(N,j) = 0;
end
for i=2:N-1
	A(i,i-1) = 1/dx^2 + C_prev;
	A(i,i) = -2/dx^2 + C_curr;
	A(i,i+1) = 1/dx^2 + C_next;
end

B(1) = Y1;
B(N) = YN;
for i=2:N-1
	B(i) = C_B;
end

u = inv(A)*B;

x = linspace(0,L,N);
plot(x,u,'-*','DisplayName','Numerical');
hold on;

C1 = ( T2-Ta+(Ta-T1)*e^(-L*k^0.5) )/( e^(L*k^0.5) - e^(-L*k^0.5) );
C2 = T1-C1-Ta;
f_anal = @(x) C1*exp(x*sqrt(k)) + C2*exp(-x*sqrt(k)) + Ta;
T_anal = f_anal(x);
plot(x,T_anal,'DisplayName','Analytic')

legend();

drawnow;
saveas(gcf,'images/ODEs8.png');

wait = input("Press Enter to Exit.");
