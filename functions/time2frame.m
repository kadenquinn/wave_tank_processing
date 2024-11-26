function [frame] = time2frame(time,FrameRate)
% converts time stamp to frame using FrameRate
frame=round(FrameRate.*time);
end

