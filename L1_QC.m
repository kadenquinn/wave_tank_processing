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

% select intensity adjsutments 
low_in=0;
high_in=1;

% select paramters for canny egde detection 
% low and high threshold 
THRESH = [0.1 0.2];
% number of frames for an edge to be steady  
steady = num_frames/2;

%% get VideoObj
% define video filename 
data_struct = load(['test_' test_date '.mat']);
filename = data_struct.(['test_' test_date]).(test_ID).(camera_ID)(run_num);
% define video path 
video_path = ['../Videos_' test_date '_2024/' camera_ID '/']; 
% create video object 
VideoObj=VideoReader(append(video_path,filename));
%% get Frames 
load('data/wave_start_end_frames.mat')
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

% resize Frames 
Frames_resized = get_resized_frames(Frames,scale);

% adjsut contrast of resized Frames 
Frames_resized_adj = get_adj_frames(Frames_resized,low_in,high_in);
%% get edges 
[BW,BW_steady,BW_transient] = get_edges(Frames_resized_adj,THRESH,steady);
%% fig filenames
fig_filename = ['test_' test_date '_' camera_ID '_' test_ID num2str(run_num) '_wave_' num2str(wave_start_end_frames.(['test_' test_date]).(camera_ID).([test_ID num2str(run_num)]).wave_num(wave_num))];
%% 1. view Frames
fig1=figure(1);
tile = tiledlayout(tile_rows,tile_columns);
for n=1:length(ii_frame_num)
    nexttile
    image(Frames(:,:,:,n))
    xticklabels([])
    yticklabels([])
    xlabel(['frame ' num2str(ii_frame_num(n))])
    if n==1
        title_str=[test_date '_' test_ID num2str(run_num) '_' camera_ID];
        title_str(title_str == '_') = ' ';
        title(title_str)
    end

    if n==2
        title(['wave: ' num2str(wave_start_end_frames.(['test_' test_date]).(camera_ID).([test_ID num2str(run_num)]).wave_num(wave_num))])
    end
end

savefig(fig1,[fig_filename '_Frames'])
movefile([fig_filename '_Frames.fig'],['../L1_QC_figs/test_' test_date ])

%% 2. view resized Frames
fig2=figure(2);
tile = tiledlayout(tile_rows,tile_columns);
for n=1:length(ii_frame_num)
    nexttile
    image(Frames_resized_adj(:,:,n))
    xticklabels([])
    yticklabels([])
    xlabel(['frame ' num2str(ii_frame_num(n))])
    if n==1
        title_str=[test_date '_' test_ID num2str(run_num) '_' camera_ID];
        title_str(title_str == '_') = ' ';
        title(title_str,['resize: ' num2str(scale)])
    end

    if n==2
        title(['wave: ' num2str(wave_start_end_frames.(['test_' test_date]).(camera_ID).([test_ID num2str(run_num)]).wave_num(wave_num))],['low: ' num2str(low_in) ' high: ' num2str(high_in)])
    end
    colormap(inferno(255))
end

savefig(fig2,[fig_filename '_Frames_RA']) % Resized Adjusted 
movefile([fig_filename '_Frames_RA.fig'],['../L1_QC_figs/test_' test_date ])
%% 3. view edges 
fig3=figure(3);
tile = tiledlayout(tile_rows,tile_columns);
for n=1:length(ii_frame_num)
    nexttile
    image(BW_transient(:,:,n))
    xticklabels([])
    yticklabels([])
    xlabel(['frame ' num2str(ii_frame_num(n))])
    if n==1
        title_str=[test_date '_' test_ID num2str(run_num) '_' camera_ID];
        title_str(title_str == '_') = ' ';
        title(title_str,['THRESH: ' num2str(THRESH)])
    end

    if n==2
        title(['wave: ' num2str(wave_start_end_frames.(['test_' test_date]).(camera_ID).([test_ID num2str(run_num)]).wave_num(wave_num))],['steady : ' num2str(steady)])
    end
    colormap([0 0 0 ; 1 1 1])
end

savefig(fig3,[fig_filename '_Frames_edges'])
movefile([fig_filename '_Frames_edges.fig'],['../L1_QC_figs/test_' test_date ])
