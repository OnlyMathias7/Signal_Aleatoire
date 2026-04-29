clc, clear, close all


message = "Choix de la question";
opt1 = "Question 1";
opt2 = "Question 2";
opt3 = "Question 3";
opt4 = "Question 4";
choix = menu(message, opt1, opt2, opt3, opt4);


N = 128;
T_min = 0; T_max = 1; T_0 = 0.1;
i = 1:N;
i = i(:);
T_e = (T_max-T_min)/(N);
t_i = T_e*(i-1)+T_min;
s = sin(2*pi*(t_i/T_0));

if choix==1
    %Question 1
    %Fréquence d'échan
    T_e = (T_max-T_min)/(N-1);
    t_i = T_e*(i-1)+T_min;
    s = sin(2*pi*(t_i/T_0));
    figure(1)
    plot(t_i, s, "r");
    hold on;
    plot(t_i, s, "*b");
    title("Echantillonnage normal");
    
    figure(2)
    T_e = (T_max-T_min)/N;
    t_i = T_e*(i-1)+T_min;
    s = sin(2*pi*(t_i/T_0));
    plot(t_i, s, "r");
    hold on;
    plot(t_i, s, "*b");
    title("Echantionneur bloqueur");
    
    %On obtient une f=10hz, fe= 128hz, Phase = 0, A = 1;
    
    %Produit  termes à termes
    prod_tern = s.*t_i;
    
    %Produit scalaire
    prod_scal = s'*t_i;
    
    %Produit tensoriel
    prod_tensoriel = s*t_i';

end 

if choix ==2 
    %Question 2
    freq = 10;
    delta_t = T_e;
    S1 = approche_rectangle(s, delta_t, freq);
    for i =-N/2:N/2
    S(i+(N/2)+1) = approche_rectangle(s, delta_t, i);
    end
    x = -N/2:N/2;
    plot(x, imag(S));
end 



function [S] = approche_rectangle(s,delta_t, freq)
%delta_t : période d'échantillonnage
%freq : fréquence 
%s : signal 
    S = 0;
    N = size(s, 1);
    for j=1:N
        S = S+(s(j)*exp(-2*1i*pi*freq*delta_t*(j-1))*delta_t);
    end 
end 

