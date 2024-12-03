function BW = limit_color_channels(Frames,channel_limits)

% Kaden Quinn 

% creates a mask BW for frames based on limits on each color channel

[H,W,~,num_frames]=size(Frames);

BW = false(H,W,num_frames);
for n=1:num_frames
BW(:,:,n) = (channel_limits(1,1)<Frames(:,:,1,n) & Frames(:,:,1,n)<channel_limits(1,2) & channel_limits(2,1)<Frames(:,:,2,n) & Frames(:,:,2,n)<channel_limits(2,2) & channel_limits(3,1)<Frames(:,:,3,n) & Frames(:,:,3,n)<channel_limits(3,2));
end

