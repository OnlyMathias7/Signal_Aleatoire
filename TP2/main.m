clear
%
message="Choix question";
opt1 = "question 1";
opt2 = "question 2";
opt3 = "question 3";
opt4 = "question 4";
choix = menu(message, opt1, opt2, opt3, opt4);
if choix==1
question=2;
end 
if choix==2
question=2;
end 
if choix==3
question=3;
end 
if choix==4
question=4;
end 
%
% frequence d'echantillonnage
nu_e=10^3; % 10 kHz      (rappel : T_e = 1 / nu_e)
%
% nombre d'echantillons
N=10^4; % sans dimension (rappel duree d'acquisition : T = N * T_e)
%
lance_TP
%
% Consigne 1 : pour analyser les graphiques, pensez à utiliser la fonction
% zoom et à bien regarder les axes.
%
% Consigne 2 : regardez vos notes de cours ainsi que l'exercice 5 de la
% section 3.1 du polycopie.
%