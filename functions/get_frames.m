function Frames = get_frames(VidReadr,ii_frame_num)
% Kaden Quinn 
% creates a 4D matrix of Frames 

% if max pre-allocated array exceeds maximum array size preference
% (16.0GB), function will fail

% VidReadr: object created using VideoReader()
% ii_frame_num: frame number index

% pre-allocate frames 
Frames = uint8(zeros(VidReadr.Height,VidReadr.Width,3,length(ii_frame_num)));
for n=1:length(ii_frame_num)
    % read in frame 
    I = read(VidReadr,ii_frame_num(n));
    Frames(:,:,:,n) = I;
end

