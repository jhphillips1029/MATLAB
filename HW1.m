% Homework 1
% Joshua H. Phillips
% Montana State University
% EMEC303-003

% Create array A of zeros
A = zeros(1,20);

% Put a 1 in A[1]
A(2) = 1;

% Create the Fibonacci Sequence
for i=3:length(A)
	A(i) = A(i-1)+A(i-2);
end



% Display results
fprintf("And here, we see the Fibonacci Sequence.");
disp(A);

% Create a basic graph
x = linspace(-pi,pi,1000);

figure(1); clf(1);
plot(x,sin(x),'b-');
xlabel('x');
ylabel('y');
set(gca,'Fontsize',16);
hold on

plot(x,cos(x),'r-');
legend;
saveas(gcf,'images/HW1-Img1.png');



% Display an image pertaining to my summer
beef = imread('images/beef.png');
figure(2); clf(2);
imshow(beef);
title('Mmmmmm.... Just gotta be cut!');
xlabel("Animals and crusty old hermits don't carry the 'Rona.");
saveas(gcf,'images/HW1-Img2.png');

% Vestige of command-line coding
%pause = input('Press Enter to Exit.');

% Use MATLAB's Publish feature to save code and output.
% Unfortunately, this is not possible for me at the moment, as the Windows side of my laptop has shit itself twice now while I attempted to install MATLAB. I spoke with Dr. Evertz, and she said I could use a custom script to produce a .pdf for the time being. I am working on getting both MATLAB and Windows to cooperate at the same time, hopefully before the next homework.
