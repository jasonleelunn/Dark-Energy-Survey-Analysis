close all;
clear all;

%fitsdisp('sva1_gold_r1.0_catalog_trim.fits');

fitsread('sva1_gold_r1.0_catalog_trim.fits','BINTABLE');

MAGR = ans{1,8};

RA = ans{1,2};

DEC = ans{1,3};

%% Creating the modified arrays for objects with magnitude less than 20

magr = MAGR(MAGR<20);

k = find(MAGR<20);

RA20 = RA(k);
DEC20 = DEC(k);

%%

% converting to radians
ra = RA20;%.*(pi/180); %.*cos(DEC20);
dec = DEC20;%.*(pi/180);



% plot points on sky
% plot(modra, dec, '.');
% grid on
% ylim([-pi/2 pi/2]);
% xlim([-2*pi 2*pi]);

% create sky map using Hammer projection
axesm
axesm('MapProjection', 'hammer', 'AngleUnits', 'degrees');

% plot point on sky
plotm(dec, ra,'r.');
framem on
gridm on

