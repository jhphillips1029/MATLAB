% PDEs WS #3
% clear; clc;

% Problem 1
% Given:
% V = <u,v,0>
% u = -partial(phi,x)
% v = -partial(phi,y)

% partial(partial(phi,x),x) + partial(partial(phi,y),y) = 0
% Discretized:
%     phi_{i-1,j} + phi_{i+1,j} + phi_{i,j-1} + phi_{i,j+1} - 4phi_{i,j} = 0
%     phi_{i,j} = 1/4 ( phi_{i-1,j} + phi_{i+1,j} + phi_{i,j-1} + phi_{i,j+1} )

% BCs:
%     Neumann:
%     {x=[0,L],y=0,L}: partial(phi,y) = 0
%     {x=0,y=[0,L/2]}: partial(phi,x) = 0
%     {x=L,y=[L/2,L]}: partial(phi,x) = 0
%     Dirichlet:
%     {x=0,y=[L/2,L]}: phi = 10
%     {x=L,y=[0,L/2]}: phi = 0

L = 1;
N = 20;
phi_in = 10;
phi_out = 0;

delta = L/N;
x = linspace(0,L,N);
y = linspace(0,L,N);

% Apply Dirichlet BCs
phi = zeros(N,N);
phi(1,N/2:N) = phi_in;
phi(N,1:N/2) = phi_out;

% Liebmann's Method
n_iter = 10000;
tol = 1.0e-5;
phi_new = phi(:,:);
for n=1:n_iter
	for i=2:N-1
		for j=2:N-1
			phi_new(i,j) = 1/4*( phi(i-1,j) + phi(i+1,j) + phi(i,j-1) + phi(i,j+1) );
		end
	end
	
	% Apply Neumann BCs
	phi_new(:,1) = phi_new(:,2);
	phi_new(:,N) = phi_new(:,N-1);
	phi_new(1,1:N/2-1) = phi_new(2,1:N/2-1);
	phi_new(N,N/2+1:N) = phi_new(N-1,N/2+1:N);
	
	res=max(abs(phi_new(:)-phi(:)));
	if res<tol
		break;
	end
	
	phi(:,:) = phi_new(:,:);
	
	if rem(n,10)==0
		contourf(x,y,phi');
		xlabel('x');
		ylabel('y');
		set(gca,'Fontsize',20);
		drawnow;
	end
end

% Solve for internal points' velocities using central difference approximation
u = zeros(N,N);
v = zeros(N,N);

for j=1:N
	for i=2:N-1
		u(i,j) = -(phi(i+1,j)-phi(i-1,j))/(2*delta);
	end
end
for j=2:N-1
	for i=1:N
		v(i,j) = -(phi(i,j+1)-phi(i,j-1))/(2*delta);
	end
end

figure(1); clf(1);
contourf(x,y,phi');
hold on;
quiver(x,y,u,v,'k');
xlabel('x');
ylabel('y');
set(gca,'Fontsize',20);
drawnow;

% Problem 2
% Given:

% partial(partial(T,x),x) + partial(partial(T,y),y) = -k(T - Ta)
% Discretized:
%     T_{i,j} = 1/(4-k) ( T_{i-1,j} + T_{i+1,j} + T_{i,j-1} + T_{i,j+1} - k Ta)

T_l = T_r = T_t = T_b = T_boundary = 100;
N = 20;
k = 0.01;
Ta = 20;
x = linspace(0,L,N);
y = linspace(0,L,N);
figure(2); clf(2);

T = zeros(N,N);
T_new = T(:,:);

% Liebmann's Method
n_iter = 10000;
tol = 1.0e-5;
for n=1:n_iter
	for i=2:N-1
		for j=2:N-1
			T_new(i,j) = 1/(4-k)*( T(i-1,j) + T(i+1,j) + T(i,j-1) + T(i,j+1) - k*Ta );
		end
	end
	
	res=max(abs(T_new(:)-T(:)));
	if res<tol
		break;
	end
	
	T(:,:) = T_new(:,:);
	
	if rem(n,10)==0
		contourf(x,y,T');
		xlabel('x');
		ylabel('y');
		set(gca,'Fontsize',20);
		drawnow;
	end
end

contourf(x,y,T');
xlabel('x');
ylabel('y');
set(gca,'Fontsize',20);
drawnow;

saveas(1,"images/WS16_a.png");
saveas(2,"images/WS16_b.png");

wait = input("HI");
