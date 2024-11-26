function [x,Y] = get_true_pixels(BW)
% Kaden Quinn 

% converts pixels=true from binary image BW to (x,y) coordiantes 

[H,W]=size(BW);
Y=nan(W,H);
x=1:W;
for n=1:W
    ii_true=find(BW(:,n)==true);
    if isempty(ii_true)==0
        Y(n,1:length(ii_true))=ii_true;
    end
end

end

