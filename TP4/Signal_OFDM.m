clc, clear, close all

% Vecteur A et B 
N = 4096;
x = rand(N,1);
v1 = floor(4*x);
x = rand(N,1);
v2 = floor(4*x);

%Vecteur A 
A = zeros(1, N);
A(v1 == 0) = -3;
A(v1 ==1) = -1;
A(v1 ==2) = 1;
A(v1 ==3) = 3;

%Vecteur B 
B = zeros(1, N);
B(v2 == 0) = -3;
B(v2 ==1) = -1;
B(v2 ==2) = 1;
B(v2 ==3) = 3;

figure(1)
subplot(3,1,1);
hist(A);
title("Histogramme du vecteur A");
subplot(3,1,2);
hist(B);
title("Histogramme du vecteur B");

figure(2)
plot(A,B, "*");
title("Constéllation de A en fonction de B")

D = A + i*B;
ModuleD = sqrt(A.^2 + B.^2);
figure(1)
subplot(3,1,3);
hist(ModuleD);
title("Histogramme du Module D");


%Question 2

f1 = 1;
Te = 1/f1;
Nt = 64;
t = ((0:Nt-1)/Nt)*Te;
z = A(1)*cos(2*pi*f1*t) - B(1)*sin(2*pi*f1*t);

Nk = Nt/4;
for j = 1:Nk
    Z(:,j) = A(j)*cos(2*pi*j*f1*t) - B(j)*sin(2*pi*j*f1*t);
end 
Z = sum(Z,2);


figure(3)
subplot(1,2,1);
plot(t,z, "*");
title("Signal z(t)");
subplot(1,2,2);
plot(t,Z);
title("Signal Z(t)");

figure(4)



