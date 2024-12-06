%% 0. load/add path
clear
close 
% add stuff to path 
addpath('functions/')
addpath('../data/')
%% 1. get video objects
% pre-allocate test runs 

test_date = ["9_11" ; "9_11" ; "9_11" ; "9_11" ; "9_11" ; "9_11" ; "9_11" ; "9_11" ; "9_11" ; "9_11"];   
test_ID = ["A" ;"A" ; "A" ; "A" ; "A" ;"A" ; "A" ; "A" ; "A" ; "A"];               
camera_ID = ["GoPro_0" ; "GoPro_0" ; "GoPro_0" ; "GoPro_0" ; "GoPro_0" ; "GoPro_0" ; "GoPro_0" ; "GoPro_0" ; "GoPro_0" ; "GoPro_0"];        
run_num=[1 ; 2 ; 3 ; 4 ;5 ; 6 ; 7 ; 8 ; 9 ; 10];
%figname = 'write_a_figure_name_here'; 

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

% select wave number 
wave_num = 4; 

% select number of frames for wave 
num_frames = 8;

% select height and width crops (0-1 for no crop)
Hcrop_low=0.4;
Hcrop_high=0.6;
Wcrop_low=0;
Wcrop_high=1;

% cut off frames 
frame_cut=0;

load('wave_start_end_frames.mat')
fig=figure;
tile=tiledlayout(length(test_date),num_frames-frame_cut);
for n=1:length(test_run_ID)
    frame_start = wave_start_end_frames.(join(['test' test_date(n)],'_')).(camera_ID(n)).(join(([test_ID(n) num2str(run_num(n))]),'')).frame_start(wave_num);
    frame_end = wave_start_end_frames.(join(['test' test_date(n)],'_')).(camera_ID(n)).(join(([test_ID(n) num2str(run_num(n))]),'')).frame_end(wave_num);
    ii_frame_num = round(linspace(frame_start,frame_end,num_frames));
    ii_frame_num = ii_frame_num(1:end-frame_cut);
    Frames = get_frames(VideoObj.(test_run_ID(n)),ii_frame_num);
    Hcrop=(1+round(Hcrop_low*VideoObj.(test_run_ID(n)).Height)):round(Hcrop_high*VideoObj.(test_run_ID(n)).Height);
    Wcrop=(1+round(Wcrop_low*VideoObj.(test_run_ID(n)).Width)):round(Wcrop_high*VideoObj.(test_run_ID(n)).Width);
    Frames = Frames(Hcrop,Wcrop,:,:);
        for nn=1:length(ii_frame_num)
        nexttile
        image(Frames(:,:,:,nn))
        xticklabels([])
        yticklabels([])
        xlabel(ii_frame_num(nn))
            if nn==1
                % label = [char(test_run_ID(n)) ' wave ' num2str(wave_num)];
                % label(label == '_') = ' '
                label = join([' A' num2str(run_num(n))]);
                ylabel(label)
            end
        end
end

% figure size and specs 
fontsize(8,"points")
fig.Units='inches';
fig.PaperSize=[10 5];
fig.Position=[0 0 10 5];
tile.Padding='compact';
tile.TileSpacing='compact';

% print(gcf,['figname.png'],'-dpng','-r600');  
% movefile(['figname.png'],['../write_a_path_here'])