% clear; clc

% Given:

% V = <u,v,0>
% u = -partial(phi,x)
% v = -partial(phi,y)

% partial(partial(phi,x),x) + partial(partial(phi,y),y) = 0

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
A = zeros(N^2,N^2);
B = zeros(N^2,1);

delta = L/N;

% Apply second derivative approximation to all internal points
for j=2:N-1
	for i=2:N-1
		A(N*(j-1)+i,N*(j-1)+i) = -4;
		A(N*(j-1)+i,N*(j-1)+i-1) = 1;
		A(N*(j-1)+i,N*(j-1)+i+1) = 1;
		A(N*(j-1)+i,N*(j-1)+i-N) = 1;
		A(N*(j-1)+i,N*(j-1)+i+N) = 1;
	end
end

% Apply first derivative approximation to no slip boundaries (Neumann BCs)
j = 1;
for i=1:N-1
	A(N*(j-1)+i,N*(j-1)+i) = 1;
	A(N*(j-1)+i,N*(j-1)+i+N) = -1;
end
j = N;
for i=2:N
	A(N*(j-1)+i,N*(j-1)+i) = 1;
	A(N*(j-1)+i,N*(j-1)+i-N) = -1;
end

i = 1;
for j=2:N/2
	A(N*(j-1)+i,N*(j-1)+i) = 1;
	A(N*(j-1)+i,N*(j-1)+i+1) = -1;
end
i = N;
for j=N/2+1:N-1
	A(N*(j-1)+i,N*(j-1)+i) = 1;
	A(N*(j-1)+i,N*(j-1)+i-1) = -1;
end

% Apply input boundary conditions (Dirichlet BCs)
i = 1;
for j=N/2+1:N
	A(N*(j-1)+i,N*(j-1)+i) = 1;
	B(N*(j-1)+i) = 10;
end
i = N;
for j=1:N/2
	A(N*(j-1)+i,N*(j-1)+i) = 1;
	B(N*(j-1)+i) = 0;
end

% Solve for potential
phi_vert = inv(A)*B;

% Reshape potential matrix
phi = zeros(N,N);
for i=1:N
	for j=1:N
		phi(i,j) = phi_vert(N*(i-1)+j);
	end
end

% Plot potential
x = linspace(0,L,N);
y = linspace(0,L,N);
contourf(x,y,phi);
hold on;

% Solve for internal points' velocities using central difference approximation
u = zeros(N,N);
v = zeros(N,N);

for j=1:N
	for i=2:N-1
		v(i,j) = -(phi(i+1,j)-phi(i-1,j))/(2*delta);
	end
end
for j=2:N-1
	for i=1:N
		u(i,j) = -(phi(i,j+1)-phi(i,j-1))/(2*delta);
	end
end

% Plot velocity
quiver(x,y,u,v,'k');
drawnow;

wait = input("Press Enter to Exit.");
