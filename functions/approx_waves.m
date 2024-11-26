function [frame_start,frame_end] = approx_waves(freq,wave_num,FrameRate)
% Kaden Quinn 
% approixmates start and end frame based on wave freq, wave num and
% FrameRate

% convert wave freq (Hz) to wave period (s) 
T_s = 1/freq;

% convert wave period (s) to (frames) 
T_frames = time2frame(T_s,FrameRate);

% start time (frames)
frame_start=(wave_num-1)*T_frames + 1;

% end time (frames)
frame_end=frame_start+T_frames;
end

