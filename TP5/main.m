clc, clear, close all

opt = "Son";
opt1 = "Image";
choix = menu("Choix", opt, opt1);
if choix==1
    exercice_sound
end 
if choix==2
    exercice_image
end 

