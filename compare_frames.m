%% 0. load/add path
clear
close 
% add stuff to path 
addpath('functions/')
addpath('../data/')
%% 1. get video objects
% pre-allocate test runs 
test_date = ["9_11" ; "9_24"];   
test_ID = ["A" ; "A"];               
camera_ID = ["GoPro_0" ; "RED_mp4"];        
run_num=[3 ; 3];
test_run_ID = join([test_ID run_num test_date camera_ID],'_');

for n=1:length(test_date)
% define video filename 
data_struct = load(['test_' char(test_date(n)) '.mat']);
filename = data_struct.(['test_' char(test_date(n))]).(test_ID(n)).(camera_ID(n))(run_num(n));

% define video path 
video_path = ['../Videos_' char(test_date(n)) '_2024/' char(camera_ID(n)) '/']; 

% create video object 
VideoObj.(test_run_ID(n))=VideoReader(append(video_path,filename));
end
%%
tiledlayout(1,2)
ii_frame_num=1;
for n=1:length(test_run_ID)
Frames = get_frames(VideoObj.(test_run_ID(n)),ii_frame_num);
nexttile
imshow(Frames)
end