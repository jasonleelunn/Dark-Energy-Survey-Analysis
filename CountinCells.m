clear all;
close all;

z = 0.5;
l = 1;
DA = 1255;
Theta = l./DA;
CellSize = Theta.*(180./pi);

x = rand(1,100)*5;
y = rand(1,100)*5;
scatter(x,y);

figure;

count = histogram2(x, y, 'BinWidth', [CellSize, CellSize],...
    'XBinLimits', [0 5], 'YBinLimits', [0 5],'DisplayStyle','tile');