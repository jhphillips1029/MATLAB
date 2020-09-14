% Lesson 2: Linear Interpolation
%clear; clc

% Define function
f = @(x) x.^2 - 5;

% Define bounds
xl = 0;
xh = 10;

% Define tolerance
tol = 1e-5;

function [ret cnt] = linearInterpolation (func,a,b,t,counter)
	% fprintf("A: %5.3f, B: %5.3f\n\n",a,b);
	c = a - (func(a)*(a-b))/(func(a)-func(b));
	if abs(a-c) < t || abs(b-c) < t
		ret = c;
		cnt = counter;
	elseif func(a)*func(c) < 0
		[ret cnt] = linearInterpolation(func,a,c,t,counter+1);
	else
		[ret cnt] = linearInterpolation(func,c,b,t,counter+1);
	end
end

[root count] = linearInterpolation(f,xl,xh,tol,0);

fprintf('Root is at %5.3f with f=%5.3f \n',root,f(root));
fprintf('Root found in %d tries.\n',count);

% plot
x = linspace(xl,xh,1000);
figure(1); clf(1)
plot(x,f(x),'k-')
xlabel('x')
ylabel('f(x)')
set(gca,'Fontsize',16)
hold on

%add to plot
plot(root,f(root),'ro')
text(root,-10,['Root is here.'])

% Save to file
saveas(gcf,'images/WS2-LinearInterpolation-Img1.png');

% pause = input("Press Enter to exit.");
