function [BW,BW_steady,BW_transient] = get_edges(Frames,THRESH,steady)

% Kaden Quinn 

% find edges in frames using canny method with thresholds THRESH 
% set a number of frames steady where if an edge is dected across multiple
% frames, it is removed 
% i.e steady = 3, if an edge if present in 3 of more frames, it is
% removed
[H,W,num_frames] = size(Frames);
BW=false(H,W,num_frames);
for n=1:num_frames
BW(:,:,n) = edge(Frames(:,:,n),'canny',THRESH);
end


BW_sum=sum(BW,3);
BW_steady=(BW_sum>=steady);
BW_transient=BW;
for n=1:num_frames
bw=BW(:,:,n);
bw(BW_steady)=false;
BW_transient(:,:,n)=bw;
end

end

