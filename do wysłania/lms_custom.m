function diff = lms_custom(y1,y2)
%LMS Summary of this function goes here
%   Detailed explanation goes here
sum=0;
    for i=1:length(y1)
        diff_table(i)=abs(y1(i)-y2(i));
        sum=sum+diff_table(i)^2;
    end
    diff=sqrt(sum/length(diff_table));
end

