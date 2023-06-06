function [C0_id,R_id,L_id,C_id] = identification_signal(filnam)
%IDENTIFICATION_SIGNAL Summary of this function goes here
%   Detailed explanation goes here
    eval(['load ', filnam '.txt']);
    Fdat= eval([filnam '(:,2) + j*' filnam '(:,3)']);  
    Freq= eval([filnam '(:,1)']); 

    Freq2=linspace(Freq(1),Freq(end),100000);
    Y_int(:,1)=interp1(Freq,Fdat,Freq2,"linear");
    Freq=Freq2;
    Yin = Y_int;
    [val1,ind1]=max(imag(Yin));
    [val2,ind2]=min(imag(Yin));
    [val,ind]=max(real(Yin));
    f0=Freq(ind);
    f1=Freq(ind1);
    f2=Freq(ind2);
    Y=val1+abs(val2);
    R=1/Y;
    Q=f0/abs(f2-f1);
    L=(Q*R)/(2*pi*f0);
    C=1/(((2*pi*f0)^2)*L);   % poprawić w raporcie
    w=(2*pi*Freq2)';
    for k=1:length(w)
        Yin2(k)=w(k)*C*((R*w(k)*C+i*(w(k)^2*L*C-1))/((R*w(k)*C)^2+(w(k)^2*L*C-1)^2));   % bez C0
    end 
    Yin2=(Yin2)';
    diff=lms_custom(imag(Yin),imag(Yin2));
    C0=diff/w(100000/2);
    Yin2=Yin2+i.*diff;
    %% bigger signal
%     w=(2*pi*Frequency)';
%     for k=1:length(w)
%         Y_out(k)=w(k)*C*((R*w(k)*C+i*(w(k)^2*L*C-1))/((R*w(k)*C)^2+(w(k)^2*L*C-1)^2));   % bez C0
%     end
%     diff=(C0*w)';
%     Y_out=Y_out+i.*diff;
%     Y_out=zeros(1,size(Frequency));
%     Y_out=Yin2;
    R_id=R
    L_id=L
    C_id=C
    C0_id=C0
end

