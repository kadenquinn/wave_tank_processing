function [Frames_gray] = get_gray_frames(Frames)
% Kaden Quinn 
% creates a 3D matrix of gray Frames 

% if max pre-allocated array exceeds maximum array size preference
% (16.0GB), function will fail

% checksize 
[H,W,~,fn]=size(Frames);

% pre-allocate frames 
Frames_gray=uint8(zeros(H,W,fn));

for n=1:fn
    % convert frames to gray
    Frames_gray(:,:,n)=im2gray(Frames(:,:,:,n));
end

end

