%% ARCHIVE scirpt for setting start and end frame for a given test run and wave 
%% 0. clear close load data paths ect
clear
close 

% add stuff to path 
addpath('functions/')
%% 1 get video object 
test_date = '9_11';   
test_ID = 'A';               
camera_ID = 'GoPro_0';         
run_num=3;

% define video filename 
data_struct = load(['test_' test_date '.mat']);
filename = data_struct.(['test_' test_date]).(test_ID).(camera_ID)(run_num);

% define video path 
video_path = ['../Videos_' test_date '_2024/' camera_ID '/']; 

% create video object 
VideoObj=VideoReader(append(video_path,filename));

%% 2. input wave number and ajust frame start and end  
% wave number in test run 
wave_num = 4;

% shift start and end frame indexes if needed
shift_start = 0;
shift_end = 0;

% number of frames for figure 
num_frames = 8;
%% 3. view frames 
% freqeucny of waves 
freq = data_struct.(['test_' test_date]).paddle_data.freq(run_num); 

% approximate start and end frame indexes for wave num
FrameRate = VideoObj.FrameRate;
[frame_start,frame_end] = approx_waves(freq,wave_num,FrameRate);

% shift start and end frame indexes 
frame_start = frame_start + shift_start;
frame_end = frame_end + shift_end;

% get num_frames from start to end frame
ii_frame_num = round(linspace(frame_start,frame_end,num_frames));
Frames = get_frames(VideoObj,ii_frame_num);

% figure 
fig=figure;
tile=tiledlayout(num_frames/2,2);
for n=1:length(ii_frame_num)
    nexttile
    imshow(Frames(:,:,:,n))
    text(1,1,['frame: ' num2str(ii_frame_num(n)) ' t: ' num2str(frame2time(ii_frame_num(n),FrameRate))],'HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor',[1 1 1])
        % title 1
        if n==1
            tit_str = ['test ' test_date ' ' test_ID num2str(run_num) ' ' camera_ID ' wave: ' num2str(wave_num)];
            tit_str(tit_str=='_') = ' ';
            title( tit_str)
        end
        % title 2
        if n==2
            title(['shifts: start=' num2str(shift_start) ' end=' num2str(shift_end)])
        end
end

% figure size and specs 
fontsize(8,"points")
tile.Padding='compact';
tile.TileSpacing='compact';

%% 4. save results
% save fig as .pdf 
figname=['test_' test_date '_' test_ID num2str(run_num) '_' camera_ID '_wave_' num2str(wave_num)];
print(gcf,[figname '.pdf'],'-dpdf','-vector','-fillpage');  
movefile([figname '.pdf'],'/Users/kadequinn/Desktop/glass_channel/wave_QC_figs/');

% save start and end frame as .mat 
ii_start_end_frame = [frame_start frame_end];
save([figname '.mat'],'ii_start_end_frame')
movefile([figname '.mat'],'/Users/kadequinn/Desktop/glass_channel/ii_start_end_frame/');






