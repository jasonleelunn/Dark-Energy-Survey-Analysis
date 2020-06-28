close all;
clear all;

fitsread('sva1_gold_r1.0_catalog_trim.fits','BINTABLE');

TYPE = ans{1,12};

MAGR = ans{1,8};

RA = ans{1,2};

DEC = ans{1,3};

%%

k = find(TYPE<0.8 & MAGR<24);

RAtype = RA(k);
DECtype = DEC(k);

%%

% converting to radians
ra = RAtype.*(pi/180); %.*cos(DEC20);
dec = DECtype.*(pi/180);



% plot points on sky
% plot(modra, dec, '.');
% grid on
% ylim([-pi/2 pi/2]);
% xlim([-2*pi 2*pi]);

% create sky map using Hammer projection
axesm('MapProjection', 'hammer', 'AngleUnits', 'radians');

% plot point on sky
plotm(dec, ra,'r.');
framem

%%

% convert to degrees

A = 0.8434*(180/pi);
B = -0.9364*(180/pi);

X = RAtype > A; %&& RAtype < A+1;


%%

z = 0.5;
l = 1;
DA = 1255;
Theta = l./DA;
CellSize = Theta.*(180./pi);

figure;
[count,Xedges,Yedges] = histcounts2(X,Y,'BinWidth',[CellSize, CellSize],...
    'XBinLimits',[A A+1],'YBinLimits',[B B+1]);
imagesc(count);

figure;
gram = histogram2(X,Y,'BinWidth',[CellSize, CellSize],'XBinLimits',[A A+1],...
    'YBinLimits',[B B+1],'DisplayStyle','tile');

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