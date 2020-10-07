% PDEs WS 5
% clear; clc;

% Given
Nx = 20;
Nt = 2000;
Lx = 1;
Lt = 100;
kcond = 0.01;
kconv = 0.01;
Ta = 100;
T0 = 100;
S=@(x,y,t) 20*sin((2*pi*t)/10)*exp(-(((x-0.5)^2+(y-0.5)^2)/(0.01)));

x = y = linspace(0,Lx,Nx);
dx = dy = Lx/Nx;
dt = Lt/Nt;

Tmax = 0;
locMax = 0;
tmax = 0;

t=0;
T=zeros(Nx,Nx) + T0;

Tnew = T(:,:);
for n=1:Nt
	t=t+dt;
	
	for j=2:Nx-1
		for i=2:Nx-1
			Tnew(i,j) = T(i,j) + dt*( kcond*((T(i+1,j)+T(i-1,j)+T(i,j+1)+T(i,j-1)-4*T(i,j))/(2*dx^2)) - kconv*(T(i,j)-Ta) + S(dx*i,dx*j,t) );
			
			if Tnew(i,j) > Tmax
				Tmax = Tnew(i,j)
				locMax = [dx*i,dx*j]
				tmax = t
			end
		end
	end
	
	T(:,:) = Tnew(:,:);
	
	T(1,:) = T(2,:);
	T(Nx,:) = T(Nx-1,:);
	T(:,1) = T(:,2);
	T(:,Nx) = T(:,Nx-1);
	
	if rem(n,10)==0
		surf(x,y,T');
		title(strcat("t=",num2str(t)));
		zlim([80,120]);
		colorbar;
		drawnow;
	end
end

surf(x,y,T');
title(strcat("t=",num2str(t)));
zlim([80,120]);
colorbar;
drawnow;

fprintf("Max Temp: %5.5f C\nMax loc: (%5.5f,%5.5f) m\nMax t=%5.5f s\n",Tmax,locMax(1),locMax(2),tmax);

wait = input("Press Enter to Exit");
