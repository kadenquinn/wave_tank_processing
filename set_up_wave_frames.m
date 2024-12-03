%% 0. load/add path
clear
close 
% add stuff to path 
addpath('functions/')
addpath('../data/')
%% 1. get video object 
test_date = '9_24';   
test_ID = 'A';               
camera_ID = 'RED';         
run_num=10;
title_str=[test_date '_' test_ID num2str(run_num) '_' camera_ID];

% define video filename 
data_struct = load(['test_' test_date '.mat']);
filename = data_struct.(['test_' test_date]).(test_ID).(camera_ID)(run_num);

% define video path 
video_path = ['../Videos_' test_date '_2024/' camera_ID '/']; 

% create video object 
VideoObj=VideoReader(append(video_path,filename));

%% 2. estimate waves 

% paddle freq is generaly pretty good
% tune freq using A_f if needed
freq_paddle = data_struct.(['test_' test_date]).paddle_data.freq(run_num);
A_f = 0.5;
freq = freq_paddle*A_f;

% number of waves to show and get start end frames 
wave_num=1:10;
[frame_start,frame_end] = approx_waves(freq,wave_num,VideoObj.FrameRate);

% use these to shift start and end frames if needed
start_adj = 0;
end_adj = 0;

frame_start = frame_start+start_adj;
frame_end = frame_end+end_adj;

% frames per wave in figure 
frame_per_wave = 3;

% set up frame height crop (use 0-1 for no crop)  
Hcrop_low=0.4;
Hcrop_high=0.6;
Hcrop=(1+round(Hcrop_low*VideoObj.Height)):round(Hcrop_high*VideoObj.Height);

tiledlayout(length(wave_num),frame_per_wave) 
for n=1:length(wave_num)
    ii_frame_num = round(linspace(frame_start(n),frame_end(n),frame_per_wave));
    Frames = get_frames(VideoObj,ii_frame_num);
    [Frames_gray] = get_gray_frames(Frames);
    for nn=1:frame_per_wave
    nexttile
    image(Frames_gray(Hcrop,:,nn))
    xticklabels([])
    yticklabels([])
    colormap('gray')
    xlabel(['frame ' num2str(ii_frame_num(nn))])

        if n==1 && nn==1
            title_str(title_str == '_') = ' ';
            title(title_str)
        end

        if n==1 && nn==2
            title(['f= ' num2str(freq) ' A_f= ' num2str(A_f)])
        end

        if n==1 && nn==3
            title(['shift start = ' num2str(start_adj) ' shift end = ' num2str(end_adj)])
        end

        if nn==1
            ylabel(['wave ' num2str(wave_num(n))])
        end
    end
end


% tiledlayout(length(wave_num),1) 
% for n=1:length(wave_num)
%     ii_frame_num = [frame_start(n) frame_end(n)];
%     Frames = get_frames(VideoObj,ii_frame_num);
% 
%     % structural similarity (SSIM) index
%     [ssimval, ssimmap] = ssim(Frames(Hcrop,:,:,1),Frames(Hcrop,:,:,2));
% 
%     nexttile
%     imshowpair(Frames(Hcrop,:,:,1),Frames(Hcrop,:,:,2),'falsecolor','ColorChannels','red-cyan')
%     title(['SSIM= ' num2str(ssimval)])
% 
%     % nexttile
%     % imshow(ssimmap)
%     % title(ssimval)
% end


% tiledlayout(length(wave_num),1) 
% for n=1:length(wave_num)
%     ii_frame_num = [frame_start(n) frame_end(n)];
%     Frames = get_frames(VideoObj,ii_frame_num);
%     nexttile
%     imshowpair(Frames(Hcrop,:,:,1),Frames(Hcrop,:,:,2),'falsecolor','ColorChannels','red-cyan')
% end

