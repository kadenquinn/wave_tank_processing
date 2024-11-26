function [Frames_resized] = get_resized_frames(Frames,scale)
% Kaden Quinn 
% creates a 4D matrix of resized frames 

% if max pre-allocated array exceeds maximum array size preference
% (16.0GB), function will fail

% check new size 
[H_scale,W_scale,c,~]=size(imresize(Frames(:,:,:,1),scale));

% get num frames 
[~,~,~,fn]=size(Frames);

% pre-allocate frames 
Frames_resized=uint8(zeros(H_scale,W_scale,c,fn));

for n=1:fn
    % resize frames
    Frames_resized(:,:,:,n)=imresize(Frames(:,:,:,n),scale);
end

