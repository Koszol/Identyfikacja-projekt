clear all;
close all;
clc

filnam ='PZT'
% filnam ='PZTU'

%	Read data from text file

eval(['load ', filnam '.txt']);
Fdat= eval([filnam '(:,2) + j*' filnam '(:,3)']);  
Freq= eval([filnam '(:,1)']); 

Freq2=linspace(51000,52000,500000);
Y_int(:,1)=interp1(Freq,Fdat,Freq2,"linear");
Freq=Freq2;
Yin = Y_int;
% Yin=  Fdat;
[val,ind]=max(real(Yin));

[val1,ind1]=max(imag(Yin));
[val2,ind2]=min(imag(Yin));
[val3,ind3]=min(abs(imag(Yin(ind1:ind2))));
%%
f0=Freq(ind);
f1=Freq(ind1);
f2=Freq(ind2);
Y=val1+abs(val2);
% Y=val;
% Y=real(Yin(ind1+ind3));
R=1/Y;
Q=f0/abs(f2-f1)
L=(Q*R)/(2*pi*f0)
C=1/(((2*pi*f0)^2)*L)   % poprawić w raporcie
w=(2*pi*Freq2)';
%%
for k=1:length(w)
    Yin2(k)=w(k)*C*((R*w(k)*C+i*(w(k)^2*L*C-1))/((R*w(k)*C)^2+(w(k)^2*L*C-1)^2));   % bez C0
end
%%
Yin2=(Yin2)';
%% Znalezienie C0 (zaimplementować least mean square czy coś)
valY2=imag(Yin2(ind1));
% diff=abs(val1-valY2);
diff=lms_custom(imag(Yin),imag(Yin2));
C0=diff/w(500000/2);
Yin2=Yin2+i.*diff;
%% Wykresy
figure(10)
subplot(2,1,1)
plot(Freq, real(Yin))
hold on
% plot(Freq2, real(Yin2))
title("Wykresy Bodego dla PZT")
hold off
subplot(2,1,2)
plot(Freq, imag(Yin))
hold on
% plot(Freq2, imag(Yin2))
xlabel("Frequency [Hz]")

figure(11)
plot(real(Yin), imag(Yin))  
hold on

% plot(real(Yin2), imag(Yin2))
title(['Complex admitance  ', filnam])
xlabel('Resistance in mS')
ylabel('Reactance in mS')
grid

% text(7,1.04,"f_0")
% text(3.5,4.66,"f_1")
% text(3.5,-2.26,"f_2")