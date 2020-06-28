clear all
close all

z = 0.5;
l = 1;
DA = 1255;
Theta = l./DA;
CellSize = Theta.*(180./pi);

n = input('Input a value for n which is the angular size of sky covered: ');

x=rand(1,5000)*n; %generates 5000 'objects' in the user specified area of the sky.
y=rand(1,5000)*n;

mu1 = [0.5.*n 0.5.*n];
mu2 = [0.3.*n 0.8.*n]; %Means for normal distributions, these specify where the center is.
mu3 = [0.8.*n 0.7.*n];

sigma1 = [0.00005.*n,0;0,0.00005.*n];
sigma2 = [0.00005.*n,0;0,0.00005.*n]; %Sigma values, these specify the spread of each distribution.
sigma3 = [0.00005.*n,0;0,0.00005.*n];


F1 = mvnrnd(mu1,sigma1,100);
F2 = mvnrnd(mu2,sigma2,100); %Obtaining the random points for the each mean and sigma variable.
F3 = mvnrnd(mu3,sigma3,100);

x1 = [F1(:,1)];
y1 = [F1(:,2)];
x2 = [F2(:,1)];
y2 = [F2(:,2)]; %Obtaining the x and y values from each array of normally distrbuted points.
x3 = [F3(:,1)];
y3 = [F3(:,2)];

X = [x,x1',x2',x3'];
Y = [y,y1',y2',y3']; %Combining all these arrays into one so that they can be plotted.
scatter(X,Y,'.');
xlim([0 n]);
ylim([0 n]);
title(['Input Objects including Clusters for ',num2str(n),...
    ' Square Degrees On The Sky']);
xlabel('x (Degrees)');
ylabel('y (Degrees)');

figure;
[count,Xedges,Yedges] = histcounts2(X,Y,'BinWidth',[CellSize, CellSize],...
    'XBinLimits',[0 n],'YBinLimits',[0 n]);
imagesc(count);

figure;
gram = histogram2(X,Y,'BinWidth',[CellSize, CellSize],'XBinLimits',[0 n],...
    'YBinLimits',[0 n],'DisplayStyle','tile');

% Variance field
mean = mean2(count);
N = sum(count,'all');
varsq = ((count - mean).^2)./N;
variance = sqrt(varsq);

varf = var(count(:));

% Nfield
Nfield = mean2(count);
% Ncluster
Ncluster = count;
% Contrast
diff = Ncluster - Nfield;
contrast = diff./varf;
contrast = max(0, contrast);
figure;
imagesc(contrast);