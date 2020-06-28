close all;
clear all;

fitsread('sva1_gold_r1.0_catalog_trim.fits','BINTABLE');

TYPE = ans{1,12};

MAGR = ans{1,8};

RA = ans{1,2};

DEC = ans{1,3};

%%

k = find(TYPE<0.8 & MAGR<21);

RAtype = RA(k);
DECtype = DEC(k);

%%

A = 72;
B = -48;
A1 = A+1;
B1 = B+1;

subplot(3,1,1);
scat = scatter(RAtype,DECtype,'k.');
xlim([A A1]);
ylim([B B1]);
xlabel('Right Ascension (degrees)');
ylabel('Declination (degrees)');
%title('Scatter Plot');

z = 0.5;
l = 1;
DA = 1255;
Theta = l./DA;
CellSize = Theta.*(180./pi);

[count,Xedges,Yedges] = histcounts2(RAtype,DECtype,'BinWidth',[CellSize, CellSize],...
    'XBinLimits',[A A1],'YBinLimits',[B B1]);
count = rot90(count);

subplot(3,1,2);
imagesc(count);
xlabel('x (degrees)');
ylabel('y (degrees)');
%title('Counts');

% subplot(2,2,3);
% gram = histogram2(RAtype,DECtype,'BinWidth',[CellSize, CellSize],'XBinLimits',[A A1],...
%     'YBinLimits',[B B1],'DisplayStyle','tile');
% title('Histogram');

% Variance field
mean = mean2(count);
N = sum(count,'all');
varsq = ((count - mean).^2)./N;
variance = sqrt(varsq);

varf = sqrt(var(count(:)));

% Nfield
Nfield = mean2(count);
% Ncluster
Ncluster = count;
% Contrast
diff = Ncluster - Nfield;
contrast = diff./varf;
contrast = max(0, contrast);
contrast(contrast < 4) = 0;

subplot(3,1,3);
imagesc(contrast);
xlabel('x (degrees)');
ylabel('y (degrees)');
%title('Contrast');



%length = length(contrast);
length = 44;
[CposDEC,CposRA] = find(contrast);

Xlen = A1 - A;
Ylen = B1 - B;

Xdiv = Xlen./length;
Ydiv = Ylen./length;

posRA = (Xdiv.*CposRA)+A;
posDEC = (Ydiv.*CposDEC)+B;


display(posRA);
display(posDEC);