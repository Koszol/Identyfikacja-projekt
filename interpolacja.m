function [x_new, y_new] = interpolacja(x,y,d)
%INTERPOLACJA Summary of this function goes here
%   Detailed explanation goes here
%   x,y - signals; d-rząd wielomianu
    A=zeros(length(x), d+1);
    for i=1:length(x)
        for j=1:d+1
            A(i,j)=x(i)^(j-1);
        end
    end
    coeffs=A\y;
    x_new=linspace(x(1),x(end),100000);
    y_new=0;
    for j=1:length(x_new)
        for i=1:d+1
            y_new(j)= coeffs(i)*x_new(j)^(i-1);
        end
    end
end

