clc, clear all, close all

N  =200
r = rand(1,N);
figure(1)
plot(r, "x");
title("Cas avec la loi uniforme");

figure(2)
plot(randn(1,N), 'x');
title("Cas avec la loi Gaussienne");

x = mod(2, 3)

ru = rand(1,N);
rv = rand(1,N);

u = zeros(1, N);
u(ru < 1/3) = -1;
u(ru >= 1/3 & ru < 2/3) = 0;
u(ru >= 2/3) = 1;

v = zeros(1, N);
v(rv < 1/3) = -1;
v(rv >= 1/3 & rv < 2/3) = 0;
v(rv >= 2/3) = 1;

figure(3)
plot(u, '*');
title("Cas vecteur u");

figure(4)
plot(v, '*');
title("Cas vecteur v");

imin = 201;
imax = 500;
K = 50;

cxx = Correlation(u,u,imin, imax, K);
figure(5)
plot(cxx);









function [cxx] = Correlation(x,y,imin,imax,K)

  for k=-K:K
   cxx(k+K+1) = sum(x(imin:imax).*(y(imin:imax)-k));
  end
  cxx = cxx / sqrt( sum(x(imin:imax).^2) * sum(y(imin:imax).^2) );

end
