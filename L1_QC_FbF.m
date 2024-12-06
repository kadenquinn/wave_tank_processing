clear 
close
addpath('../data/')
addpath('functions/')
%% 0. user inputs 
% select video of test run and wave number 
test_date = '9_11';   
test_ID = 'A';               
camera_ID = 'GoPro_0';         
run_num=2;

% select wave number 
wave_num = 4; 

% select number of frames for wave 
num_frames = 18;

% select height and width crops (0-1 for no crop)
Hcrop_low=0.4;
Hcrop_high=0.6;
Wcrop_low=0;
Wcrop_high=1;

% tile specs 
tile_rows = num_frames/2;
tile_columns = 2; 

% select resize scale 
scale=0.2; 
%% get VideoObj
% define video filename 
data_struct = load(['test_' test_date '.mat']);
filename = data_struct.(['test_' test_date]).(test_ID).(camera_ID)(run_num);
% define video path 
video_path = ['../Videos_' test_date '_2024/' camera_ID '/']; 
% create video object 
VideoObj=VideoReader(append(video_path,filename));
%% get Frames 
load('wave_start_end_frames.mat')
frame_start = wave_start_end_frames.(['test_' test_date]).(camera_ID).([test_ID num2str(run_num)]).frame_start(wave_num);
frame_end = wave_start_end_frames.(['test_' test_date]).(camera_ID).([test_ID num2str(run_num)]).frame_end(wave_num);
ii_frame_num = round(linspace(frame_start,frame_end,num_frames));

% for GoPro 
camera_IDs_GoPro = {'GoPro_0', 'GoPro_1', 'GoPro_2'};
if ismember(camera_ID,camera_IDs_GoPro)
    load('GoProParams.mat')
    Frames=get_undistorted_frames(VideoObj,ii_frame_num,cameraParams);
end

% for RED
camera_IDs_RED = {'RED', 'RED_mp4'};
if ismember(camera_ID,camera_IDs_RED)
    Frames=get_frames(VideoObj,ii_frame_num);
end

% crop Frames 
Hcrop=(1+round(Hcrop_low*VideoObj.Height)):round(Hcrop_high*VideoObj.Height);
Wcrop=(1+round(Wcrop_low*VideoObj.Width)):round(Wcrop_high*VideoObj.Width);
Frames = Frames(Hcrop,Wcrop,:,:);
%% 1. QC a single frame using the imageSegmenter app 
% Load and display the frame 
ii_frame=2;   % <----- Select frame here 

F=(Frames(:,:,:,ii_frame));

imageSegmenter(F)

% no option to save yet...