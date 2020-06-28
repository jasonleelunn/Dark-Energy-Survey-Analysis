clear all;
close all;

c = 3e8;
h = 0.7;
DH = (9.26e25)/h;

% for a flat universe, k=0
omegaM = 0.286;
omegaL = 0.714;

z = 0;
input = input('Input Redshift Limit = ');

zspace = linspace(0,input,101);
qdata = [];

while z <= input
    
%z = input;

fun = @(z) 1./(sqrt((omegaM*(1+z).^3)+omegaL));
q = integral(fun,0,z);

qdata = [qdata,q];

z = z + (input./100);

end 

DC = DH.*qdata;
DA = DC.*((1+zspace).^-1);

DA = DA./3.0857e22;

plot(zspace,DA,'-r');
xlabel('Redshift, z');
ylabel('Angular Diameter Distance, D_A (Mpc)');
%title(['Angular Diameter Distance to an object ',...
%   'w.r.t. Redshift for a flat (k=0) Universe']);