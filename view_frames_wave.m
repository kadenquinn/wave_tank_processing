%% 0. clear close load data paths ect
clear
close 
% add stuff to path 
addpath('functions/')
addpath('data_structs/')

% load data structs 
load('test_9_11.mat')
load('test_9_24.mat')

% 1. inputs 
test_struct = 'test_9_24';   
camera_ID = 'RED';    
video_path = "test_2_9_24_2024/RED/"; 
test_ID = 'C';      

% run number in test 
run_num=10;  

% wave number in test run 
wave_num = 4;

% shift start and end frame indexes if needed
shift_start = -50;
shift_end = -10;

% number of frames for figure 
num_frames = 8;
%% 2. view frames 
% data struct index 
data_struct = load([test_struct '.mat']);

% filename for test, run, and camera
filename = data_struct.(test_struct).(test_ID).(camera_ID)(run_num);

% freqeucny of waves 
freq = data_struct.(test_struct).paddle_data.freq(run_num); 

% create video object 
VideoObj=VideoReader(append(video_path,filename));

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
            tit_str = [test_struct ' ' test_ID num2str(run_num) ' ' camera_ID ' wave: ' num2str(wave_num)];
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

%% 3. save results
% save fig as .pdf 
figname=[test_struct '_' test_ID num2str(run_num) '_' camera_ID '_wave_' num2str(wave_num)];
print(gcf,[figname '.pdf'],'-dpdf','-vector','-fillpage');  
movefile([figname '.pdf'],'/Users/kadequinn/Desktop/wave_tank_expts/wave_QC_figs/');

% save start and end frame as .mat 
ii_start_end_frame = [frame_start frame_end];
save([figname '.mat'],'ii_start_end_frame')
movefile([figname '.mat'],'/Users/kadequinn/Desktop/wave_tank_expts/ii_start_end_frame/');

%"test_1_9_11_2024
% A03 0 1   DONE
% A04 0 1   DONE
% A06 0 1   DONE
% A10 0 1   DONE

%"test_2_9_24_2024/RED/"
% A03 RED 2
% A04 RED 2
% A06 RED 2
% A10 RED 2

% B03 RED 2
% B04 RED 2
% B06 RED 2
% B10 RED 2

% C03 RED 2
% C04 RED 2
% C06 RED 2
% C10 RED 2





