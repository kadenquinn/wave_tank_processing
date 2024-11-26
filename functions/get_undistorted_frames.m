function Frames = get_undistorted_frames(VidReadr,ii_frame_num,cameraParams)
% Kaden Quinn 
% creates a 4D matrix of frames 

% if max pre-allocated array exceeds maximum array size preference
% (16.0GB), function will fail

% VidReadr: object created using VideoReader()
% fn: frame number index
% cameraParams: object created using MATLAB camera calibrator app 

% pre-allocate frames 
Frames = uint8(zeros(VidReadr.Height,VidReadr.Width,3,length(ii_frame_num)));
for n=1:length(ii_frame_num)
    % read in frame 
    I = read(VidReadr,ii_frame_num(n));
    % undistort frame 
    J = undistortImage(I,cameraParams);
    Frames(:,:,:,n) = J;
end

