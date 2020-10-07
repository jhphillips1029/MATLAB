% run in octave command-line
% run 'pkg load symbolic' before running
% run with 'run WS17-PDEs4.m'

% PDEs WS # 4
% clear; clc;

% T_i^{n+1} = T_i^n + \Delta t \left( k_{cond} \dfrac{T_{i-1}^n -2T_i^n + T_{i+1}^n}{Dx^2} - k_{cond} ( T_i^n - T_a ) \right)

% T(i,n+1) = T(i,n) + dt*( k_cond*(T(i-1,n)-2*T(i,n)+T(i+1,n))/(dx^2) - k_cond*(T(i,n)-Ta) )

% Given:
Nx=50;
Nt=20000;
dt=0.005;
kcond=0.01;
kconv=0.1;
Lx=1;
Tl=100;
Tr=100;
To=100;
Ta=@(x,t) 100+heaviside(x-0.5)*100*heaviside(cos(2*pi*t/20));
T_max = 0;
x_max = 0;
t_max = 0;

% Create grid
x=linspace(0,Lx,Nx);
dx=Lx/Nx;

% Initial Condition
t=0;
T=zeros(1,Nx)+To;

% Loop over time
Tnew=T;
for n=1:Nt
    
    % Update time
    t=t+dt;
    
    % Update the temp on interior grid points
    for i=2:Nx-1
        Tnew(i)=T(i) + dt*( kcond*(T(i-1)-2*T(i)+T(i+1))/(dx^2) - kconv*(T(i)-Ta(i*dx,t)) );
    end
    T=Tnew;
    
    % Update the boundary conditions
    T(1)=T(2);   % Left
    T(Nx)=T(Nx-1);  % Right
    
    if max(T) > T_max
    	T_max = max(T)
    	x_max = x(find(T==T_max))
    	t_max = t
    end
    
    % Plot
    if rem(n,100)==0
        figure(1); clf(1)
        % Plot tmperature in bar
        plot(x,T,'linewidth',2)
        hold on
        % Plot temperature of air
        plot(x,Ta(x,t))
        xlabel('x')
        ylabel('T(x)')
        string=sprintf('Time = %7.3f',t);
        title(string)
        axis([0,Lx,90,210])
        legend('Temp of Bar','Temp of Air','Location','northwest')
        set(gca,'Fontsize',20)
        drawnow
    end
end

fprintf("T_max: %5.5f deg C\nx_max: %5.5f m\nt_max: %5.5f s");

wait = input("Press Enter to Exit.");
