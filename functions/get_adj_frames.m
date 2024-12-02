function [Frames_adj] = get_adj_frames(Frames,low_in,high_in)
% Kaden Quinn 
% creates a 3D matrix of gray Frames with the intensity values in grayscale
% image adjusted


% if max pre-allocated array exceeds maximum array size preference
% (16.0GB), function will fail

% checksize 
[H,W,~,fn]=size(Frames);

% pre-allocate frames 
Frames_adj=uint8(zeros(H,W,fn));

for n=1:fn
    % convert frames to gray
    F=im2gray(Frames(:,:,:,n));
    Frames_adj(:,:,n)=imadjust(F,[low_in high_in]);
end

end

