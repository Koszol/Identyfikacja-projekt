%
%
%
%
clear
filnam ='PZT'
% filnam ='PZTU'

%	Read data from text file

eval(['load ', filnam '.txt']);
Fdat= eval([filnam '(:,2) + j*' filnam '(:,3)']);  
Freq= eval([filnam '(:,1)']); 

Yin = Fdat;


figure( 10)
subplot(2,1,1)
plot(Freq, real(Yin))
hold on
text(51480,0.007,"f_0")
hold off
subplot(2,1,2)
plot(Freq, imag(Yin))

figure(11)
plot(real(Yin)*1e3, imag(Yin)*1e3)
title(['Complex admitance  ', filnam])
xlabel('Resistance in mS')
ylabel('Reactance in mS')
grid
hold on
text(7,1.04,"f_0")
text(3.5,4.66,"f_1")
text(3.5,-2.26,"f_2")