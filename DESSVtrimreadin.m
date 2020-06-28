close all;
clear all;

%fitsdisp('sva1_gold_r1.0_catalog_trim.fits');

fitsread('sva1_gold_r1.0_catalog_trim.fits','BINTABLE');



% FLAGR = ans{1,5};
% BADFLAG = ans{1,7};
MAGR = ans{1,8};
% MAGI = ans{1,9};

%TYPE = ans{1,12};

%%

hist1 = histogram(MAGR);
%figure;
%hist2 = histogram(MAGI);
xlim([15 30]);

xlabel('Magnitude');
ylabel('Number of Objects');