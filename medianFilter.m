function [y] = medianFilter(x, fs)
y = x;
%30% of FS
R=fs*0.3;
for i = 1:length(x)
    if ((i+R)<= length(x) && (i-R)>= 1)
        BL = median(x((i-R):(i+R)));
    elseif ((i+R)<= length(x) && (i-R)< 1)
        BL = median(x(1:(i+R)));
    elseif ((i+R)> length(x) && (i-R)>= 1)
        BL = median(x((i-R):end));
    end
    y(i) = y(i)- BL;
end

