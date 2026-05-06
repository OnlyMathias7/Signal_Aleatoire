opt = "handel";
opt1 = "Trateur";
opt2 = "Applaudissement";
choix = menu("Choix", opt, opt1, opt2);
if choix==1
load handel.mat
end 
if choix==2
    load tracteur.mat
end 
if choix==3
    load applaudissements.mat
end
y;
Fs;
Te = 1/Fs;
N = length(y);
Nr= 300;
t = 0:Te:(N-1)*Te;
i = 1:N;
t(i) = Te*(i-1);


soundsc(y,Fs);

figure(1)
subplot(1,2,1);
plot(t,y);
title("Signal Y");

yxx = xcorr(y,Nr, 'coef');

subplot(1,2,2);
vecteur_t = -Nr*Te:Te:Nr*Te;
plot(vecteur_t,yxx);
title("Autocorrélation du signal y");

%DSP du signal
Sxx1 = fft(yxx);
Sxx = fftshift(fft(yxx));
vecteur_f = -Fs/2:Fs/(Nr*2):Fs/2;
vecteur_f1 = 0:Fs/(Nr*2):Fs;
figure(2)
subplot(1,2,1);
stem(vecteur_f,Sxx);
title("DSP avec Stem et fftshift");

subplot(1,2,2);
stem(vecteur_f1,Sxx1);
title("DSP avec Stem");

figure(3)
subplot(1,2,1);
plot(vecteur_f,abs(Sxx));
title("DSP avec plot et fftshift");

subplot(1,2,2);
plot(vecteur_f1,abs(Sxx1));
title("DSP avec plot");