% Joshua H. Phillips
% Bradley J. Harvey
% Joseph R. Stangl

% Cabin Project
clear; clc;

% Given
% Q1 = k1(T1-Tout)
% Q3 = k3(T2-Tout)
% Q2 = k2(T1-T2+5)

length_of_day = 60*60*24; %sec

Tout = @(t) -10*sin(2*pi*t/length_of_day);
T1_0 = 5;
T2_0 = 7;

wout = 250;
w1 = 500;
w2 = 800;
static = 950;
forecast = 2 * length_of_day/24;
Q_in = @(t,T1,T2) static + heaviside(-Tout(t+forecast)) * (wout*heaviside(-Tout(t)) + w1*heaviside(20-T1) + w2*heaviside(20-T2)); % Variable (0-2500)
A_in = 0.5;

rho_air = 1.225;
C_air = 1005;

k1 = 0.2;
k2 = 4;   % Variable (1-10)
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

f1 = @(t,T1,T2) sum([-A1*k1*(T1-Tout(t)),-A2*k2*(T1-T2+5),A_in*Q_in(t,T1,T2)])/(C_air*rho_air*V1);
f2 = @(t,T1,T2) sum([A2*k2*(T1-T2+5),-A3*k3*(T2-Tout(t))])/(C_air*rho_air*V2);

T1(1) = T1_0;
T2(1) = T2_0;
Text(1) = Tout(0);
Qstove(1) = 0;
t(1) = 0;
Q1(1) = A1*k1*(T1(1)-Tout(t(1)));
Q2(1) = A2*k2*(T1(1)-T2(1)+5);
Q3(1) = A3*k3*(T2(1)-Tout(t(1)));

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
	
	Qstove(i+1) = Q_in(t(i+1),T1(i+1),T2(i+1));
	Text(i+1) = Tout(t(i+1));
	Q1(i+1) = A1*k1*(T1(i+1)-Tout(t(i+1)));
	Q2(i+1) = A2*k2*(T1(i+1)-T2(i+1)+5);
	Q3(i+1) = A3*k3*(T2(i+1)-Tout(t(i+1)));
end

Terror = sum(abs(T1-20) + abs(T2-20))/(2*N);

figure(1); clf(1);
plot(t,T1,"DisplayName","T1");
hold on;
plot(t,T2,"DisplayName","T2");
plot(t,Text,"DisplayName","Tout");
hold off;
xlabel("Time (s)");
ylabel("Temperature (C)");
ttl_str = strcat("Cabin Temperature over Two Days (T Error = ",num2str(Terror)," C)");
title(ttl_str);
legend;
drawnow;
%saveas(1,"images/cabinProject_BstSnrio.png");

disp(max(Qstove));
fprintf("T_error = %5.5f\n",Terror);

% wait = input("Press Enter to Exit.");
