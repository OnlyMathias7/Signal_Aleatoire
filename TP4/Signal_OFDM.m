clc, clear, close all

% Vecteur A et B 
N = 4096;
Nb_symbole = 30;
x = rand(N,Nb_symbole);
v1 = floor(4*x);
x = rand(N,Nb_symbole);
v2 = floor(4*x);

%Vecteur A 
A = zeros(N, Nb_symbole);
A(v1 == 0) = -3;
A(v1 ==1) = -1;
A(v1 ==2) = 1;
A(v1 ==3) = 3;

%Vecteur B 
B = zeros(N, Nb_symbole);
B(v2 == 0) = -3;
B(v2 ==1) = -1;
B(v2 ==2) = 1;
B(v2 ==3) = 3;

figure(1)
subplot(3,1,1);
hist(A(:,1));
title("Histogramme du vecteur A");
subplot(3,1,2);
hist(B(:,1));
title("Histogramme du vecteur B");

figure(2)
plot(A(:,1),B(:,1), "*");
title("Constéllation de A en fonction de B")

D = A + i*B;
ModuleD = sqrt(A.^2 + B.^2);
figure(1)
subplot(3,1,3);
hist(ModuleD(:,1));
title("Histogramme du Module D");


%Question 2

f1 = 1;
Te = 1/f1;
Nt = 64;
t = ((0:Nt-1)/Nt)*Te;
z = A(1,1)*cos(2*pi*f1*t) - B(1,1)*sin(2*pi*f1*t);


% Création d'un symbole M
Nk = Nt/4;
for j = 1:Nk
    Z(:,j) = A(1,j)*cos(2*pi*j*f1*t) - B(1,j)*sin(2*pi*j*f1*t);
    
end 
Z1 = sum(Z,2);

M = symboleM(f1,Nk,Nt,A(:,1),B(:,1));

figure(3)
subplot(1,2,1);
plot(t,Z);
title("Tout les signaux");

subplot(1,2,2);
plot(t,Z1);
title("Signal Z(t)");

figure(4)
v = fft(M);
plot(real(v), imag(v), "*");
figure(5)
stem(abs(v));
title("DSP d'un symbole");

% Question 3
Zm = signalOFDM(f1,Nk,Nt, A, B, Nb_symbole);


% Question 4
d=4;
Zm_cp = signal_CP_OFDM(Zm, Nt, d);


function M = symboleM(f1,Nk,Nt,A,B)

    Te = 1/f1;
    t = ((0:Nt-1)/Nt)*Te;
    z = A(1)*cos(2*pi*f1*t) - B(1)*sin(2*pi*f1*t);

    for j = 1:Nk
    Z(:,j) = A(j)*cos(2*pi*j*f1*t) - B(j)*sin(2*pi*j*f1*t);
    
    end 
    M = sum(Z,2);

end 


function Zm = signalOFDM(f1,Nk,Nt, A, B, Nb_symbole)

    Zm = zeros(Nt, Nb_symbole);
    for i = 1:Nb_symbole
        Zm(:,i) = symboleM(f1,Nk,Nt,A(:,i),B(:,i));
    end

end 

function Zm_cp = signal_CP_OFDM(Zm, Nt, d)
    Zm_cp = [ Zm(end-(Nt/d)+1:end,:) ; Zm ];

end 
