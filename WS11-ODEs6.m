% ODEs WS 6
% clear; clc;

T1=40;T2=200;Ta=20;
k=0.01;
L=10;

f=@(x,u) [u(2),
	  -k*(Ta-u(1))];

xspan = [0,L];
u2_guess = 12.69;
u0=[T1,u2_guess];

[x,u] = ode45(f,xspan,u0);

plot(x,u(:,1),'b');
hold on;

C1 = ( T2-Ta+(Ta-T1)*e^(-L*k^0.5) )/( e^(L*k^0.5) - e^(-L*k^0.5) );
C2 = T1-C1-Ta;
T_anal = @(x) C1*e.^(x*k^0.5) + C2*e.^(-x*k^0.5) + Ta;
plot(x,T_anal(x),'ro');

legend('Numerical','Analytical');
saveas(gcf,'images/WS11_d.png');

wait = input('Press Enter to Continue');
