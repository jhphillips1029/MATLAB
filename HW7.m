% HW 7
% clear; clc;

% Part b
N = 20;
L = 1;
A = zeros(N^2,N^2);
B = zeros(N^2,1);
DBC = 10;
a = 1;
sig = 0.1;
S = @(x,y) a*exp(-( (x-0.5)^2 + (y-0.5)^2 )/( 2*sig^2 ));

delta = L/N;
x = linspace(0,L,N);
y = linspace(0,L,N);

% Apply second derivative approximation to all internal points
for j=2:N-1
	for i=2:N-1
		A(N*(j-1)+i,N*(j-1)+i) = -4;
		A(N*(j-1)+i,N*(j-1)+i-1) = 1;
		A(N*(j-1)+i,N*(j-1)+i+1) = 1;
		A(N*(j-1)+i,N*(j-1)+i-N) = 1;
		A(N*(j-1)+i,N*(j-1)+i+N) = 1;
		B(N*(j-1)+i) = -S(delta*i,delta*j);
	end
end

% Apply Dirichlet BCs
j=1; % bottom
for i=1:N
	A(N*(j-1)+i,N*(j-1)+i) = 1;
	B(N*(j-1)+i) = DBC;
end
j=N; % top
for i=1:N
	A(N*(j-1)+i,N*(j-1)+i) = 1;
	B(N*(j-1)+i) = DBC;
end
i=1; % left
for j=1:N
	A(N*(j-1)+i,N*(j-1)+i) = 1;
	B(N*(j-1)+i) = DBC;
end
i=N; % right
for j=1:N
	A(N*(j-1)+i,N*(j-1)+i) = 1;
	B(N*(j-1)+i) = DBC;
end

T_vert = inv(A)*B;
T = zeros(N,N);
for j=1:N
	for i=1:N
		T(i,j) = T_vert(N*(j-1)+i);
	end
end

figure(1); clf(1);
contourf(x,y,T');
colorbar;
saveas(1,"images/HW7_1b.png");

% Part C
A = zeros(N^2,N^2);
B = zeros(N^2,1);

% Apply second derivative approximation to all internal points
for j=2:N-1
	for i=2:N-1
		A(N*(j-1)+i,N*(j-1)+i) = -4;
		A(N*(j-1)+i,N*(j-1)+i-1) = 1;
		A(N*(j-1)+i,N*(j-1)+i+1) = 1;
		A(N*(j-1)+i,N*(j-1)+i-N) = 1;
		A(N*(j-1)+i,N*(j-1)+i+N) = 1;
		B(N*(j-1)+i) = -S(delta*i,delta*j);
	end
end

% Apply Dirichlet BCs
j=1; % bottom
for i=1:N
	A(N*(j-1)+i,N*(j-1)+i) = 1;
	B(N*(j-1)+i) = DBC;
end
j=N; % top
for i=1:N
	A(N*(j-1)+i,N*(j-1)+i) = 1;
	B(N*(j-1)+i) = DBC;
end

% Apply Neumann BCs
i=1; % left
for j=1:N
	A(N*(j-1)+i,N*(j-1)+i) = 1;
	A(N*(j-1)+i,N*(j-1)+i+1) = -1;
end
i=N; % right
for j=1:N
	A(N*(j-1)+i,N*(j-1)+i) = 1;
	A(N*(j-1)+i,N*(j-1)+i-1) = -1;
end

T_vert = inv(A)*B;
T = zeros(N,N);
for j=1:N
	for i=1:N
		T(i,j) = T_vert(N*(j-1)+i);
	end
end

figure(2); clf(2);
contourf(x,y,T');
colorbar;
saveas(2,"images/HW7_1c.png");

%Part D
figure(3);clf(3);
T = zeros(N,N);

% Apply Dirichlet BCs
T(1,:) = DBC;
T(N,:) = DBC;
T(:,1) = DBC;
T(:,N) = DBC;

% Liebmann's Method
n_iter = 10000;
tol = 1.0e-5;
T_new = T(:,:);
for n=1:n_iter
	for i=2:N-1
		for j=2:N-1
			T_new(i,j) = 1/4*( S(delta*i,delta*j) + T(i-1,j) + T(i+1,j) + T(i,j-1) + T(i,j+1) );
		end
	end
	
	res = max(abs(T_new(:)-T(:)));
	if res<tol
		break;
	end
	
	T(:,:) = T_new(:,:);
	
	if rem(n,10)==0
		contourf(x,y,T');
		colorbar;
		drawnow;
	end
end

contourf(x,y,T');
colorbar;
drawnow;
saveas(3,"images/HW7_1d.png");

wait = input("Press Enter to Exit.");
