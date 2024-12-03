function [frame_start,frame_end] = approx_waves(freq,wave_num,FrameRate)
% Kaden Quinn 
% approixmates start and end frame based on wave freq, wave num and
% FrameRate

% pre-allocate
n_waves = length(wave_num);
frame_start = ones(n_waves,1);
frame_end = ones(n_waves,1);

% convert wave freq (Hz) to wave period (s) 
T_s = 1/freq;

% convert wave period (s) to (frames) 
T_frames = time2frame(T_s,FrameRate);

for n=1:length(wave_num)
% start time (frames)
frame_start(n)=(wave_num(n)-1)*T_frames + 1;

% end time (frames)
frame_end(n)=frame_start(n)+T_frames;
end

end

