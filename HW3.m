% Homework 3
% clear all; clc;

% Experimental
v_eraser = [0.2,0.34,0.5,0.545,0.6,0.667];
v_paper = [0.2,0.29,0.4,0.5,0.545,0.545];
dist = [0.01,0.06,0.1,0.14,0.18,0.22];

% Plot using data
t_eraser = (1./v_eraser).*dist;
t_paper = (1./v_paper).*dist;

figure(1); clf(1);
plot(t_eraser,v_eraser);
title('Eraser');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
hold on;
figure(2); clf(2);
plot(t_paper,v_paper);
title('Paper');
xlabel('Time (s)');
ylabel('Velocity (m/s)');
hold on;

% Plot using analytic soln (- air resistance)
g = 9.81;
v=@(t) g*t;
v_anal_eraser = v(t_eraser);
v_anal_paper  = v(t_paper);

figure(1);
plot(t_eraser,v_anal_eraser);
figure(2);
plot(t_paper,v_anal_paper);

% Plot using numerical
rho_air = 1.225;
C_drag = 1.05; % for cube
A_eraser = 2.76E-4;
A_paper = 2.673E-2;
m_paper = 906e-4;
m_eraser = 3e-3;
g = 9.81;

fe=@(t,v) 1/(2*m_paper)*rho_air*v^2*C_drag*A_eraser+g;
fp=@(t,v) 1/(2*m_paper)*rho_air*v^2*C_drag*A_paper+g;
t_e(1)=0;t_p(1)=0;
v_e(1)=0;v_p(1)=0;
h = 0.01;
Lt_p = max(t_paper);
Lt_e = max(t_eraser);
numSteps_p = Lt_p/h;
numSteps_e = Lt_e/h;

for i=1:numSteps_p
	t_p(i+1) = t_p(i) + h;
	v_p(i+1) = v_p(i) + h*fp(t_p(i),v_p(i));
end
for i=1:numSteps_e
	t_e(i+1) = t_e(i) + h;
	v_e(i+1) = v_e(i) + h*fe(t_e(i),v_e(i));
end

figure(1);
plot(t_e,v_e);
legend('Experimental','Analytic','Numeric');
figure(2);
plot(t_p,v_p);
legend('Experimental','Analytic','Numeric');

wait = input("Press Enter to continue");
