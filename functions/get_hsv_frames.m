function Frames_hsv = get_hsv_frames(Frames)
% Kaden Quinn 
% creates a 4D matrix of Frames in HSV color channel 

% if max pre-allocated array exceeds maximum array size preference
% (16.0GB), function will fail

[H,W,~,num_frames]=size(Frames);

% pre-allocate frames 
Frames_hsv = zeros(H,W,3,num_frames);
for n=1:num_frames
    % read in frame 
    Frames_hsv(:,:,:,n) = rgb2hsv(Frames(:,:,:,n));
end


