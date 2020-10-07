% Cabin Project

% Given
% Q1 = k1(T1-Tout)
% Q3 = k3(T2-Tout)
% Q2 = k2(T1-T2+5)

length_of_day = 1440; %min

Tout = @(t) -10*sin(2*pi*t/length_of_day);
T1_0 = 5;
T2_0 = 7;

Q_in = 2500;   % Variable (0-2500)
A_in = 0.5;

rho_air = 1.225;
C_air = 1005;

k1 = 0.2;
k2 = 1;   % Variable (1-10)
k3 = 0.5;

L = 5;
W = 6;
H1 = 3;
H2 = 3;

A1 = 2*L*H1 + 2*W*H1;
A2 = L*W;
A3 = W*H2 + L*sqrt(H2^2 + (W/2)^2);
V1 = L*W*H1;
V2 = 1/2*L*W*H2;

Lt = 2*length_of_day;
N = 1000;   % Variable (any)
dt = Lt/N;

f1 = @(t,T1,T2) sum([-A1*k1*(T1-Tout(t)),-A2*k2*(T1-T2+5),A_in*Q_in])/(C_air*rho_air*V1);
f2 = @(t,T1,T2) sum([A2*k2*(T1-T2+5),-A3*k3*(T2-Tout(t))])/(C_air*rho_air*V2);

T1 = zeros(1,N)+T1_0;
T2 = zeros(1,N)+T2_0;
t(1) = 0;

for i=1:N
	k1 = f1(t(i),T1(i),T2(i));
	k2 = f1(t(i)+dt/2,T1(i)+k1*dt/2,T2(i)+k1*dt/2);
	k3 = f1(t(i)+dt/2,T1(i)+k2*dt/2,T2(i)+k2*dt/2);
	k4 = f1(t(i)+dt,T1(i)+k3*dt,T2(i)+k3*dt);
	T1(i+1) = T1(i) + 1/6*(k1+2*k2+2*k3+k4)*dt;
	
	k1 = f2(t(i),T1(i),T2(i));
	k2 = f2(t(i)+dt/2,T1(i)+k1*dt/2,T2(i)+k1*dt/2);
	k3 = f2(t(i)+dt/2,T1(i)+k2*dt/2,T2(i)+k2*dt/2);
	k4 = f2(t(i)+dt,T1(i)+k3*dt,T2(i)+k3*dt);
	T2(i+1) = T2(i) + 1/6*(k1+2*k2+2*k3+k4)*dt;
	
	t(i+1) = t(i)+dt;
end

plot(t,T1,"DisplayName","T1");
hold on;
plot(t,T2,"DisplayName","T2");
legend;
drawnow;

wait = input("Press Enter to Exit.");
