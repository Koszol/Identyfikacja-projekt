clear all;
close all;
clc

filnam ='PZTU'

eval(['load ', filnam '.txt']);
Fdat= eval([filnam '(:,2) + j*' filnam '(:,3)']);  
Freq= eval([filnam '(:,1)']); 
Frequency=linspace(51000,57000,500000);
R=144;
L=218.7;
C=0.0437;
C0=3.79;
w=(2*pi*Frequency)';
%%
for k=1:length(w)
    Yin2(k)=w(k)*C*((R*w(k)*C+i*(w(k)^2*L*C-1))/((R*w(k)*C)^2+(w(k)^2*L*C-1)^2));   % bez C0
end 

diff=(C0*w)';
%%
Yin2_diff=Yin2+diff.*i;
% Y_out_giv=Yin2';
% Freq_giv=Frequency;