function [Freq_id,Y_out_id] = draw_id_signal(R,L,C,C0,Frequency)
%GIVEN_SIGNAL Summary of this function goes here
%   Detailed explanation goes here
%     
%     C=C*1e-9;
%     L=L*1e-3;
%     C0=C0*1e-9;
    w=(2*pi*Frequency)';
    for k=1:length(w)
        Yin2(k)=w(k)*C*((R*w(k)*C+i*(w(k)^2*L*C-1))/((R*w(k)*C)^2+(w(k)^2*L*C-1)^2));   % bez C0
    end 
%     diff=(C0*w)';
    if (C0~=0)
        Yin2=Yin2';
        Yin2=Yin2+C0.*w.*i;
    end
    Y_out_id=Yin2';
    Freq_id=Frequency;
end
