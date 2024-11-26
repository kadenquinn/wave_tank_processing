clear
close
% add paths
addpath('functions/')
addpath('gopro_cam_cal/')
addpath('data_structs/')
addpath('Colormaps/')

% load data structs
load('test_9_11.mat')
load('test_9_24.mat')
load('GoProParams.mat')
%% 1. select a test run, camera, and wave number  

% test run information 
test_ID = 'A';
camera_ID = 'GoPro_0';
run_num=3; 

% path where video is located 
video_path = "test_1_9_11_2024/gopro_0/";

% camera filename 
filename = test_9_11.(test_ID).(camera_ID)(run_num); 

% create video object 
VideoObj=VideoReader(append(video_path,filename));

% index of frames of interest 
frame_start = 538;
frame_spacing = 30;
frame_end = 717;
ii_frame_num = frame_start:frame_spacing:frame_end;

% Frames of interest
Frames = get_undistorted_frames(VideoObj,ii_frame_num,cameraParams);
%% 2. crop height and width of frames 

% check size of Frames 
[H,W,~,~]=size(Frames);

% set up height crop using yl and yu
yl=round(0.4*H);
yu=round(0.78*H);
Hcrop=yl:yu;

%  set up width crop using xl and xu
xl=1;
xu=W;
Wcrop=xl:xu;

for n=1:length(ii_frame_num)
nexttile
imshow(Frames(:,:,:,n))
title(ii_frame_num(n))
axis image
xlim([xl xu])
ylim([yl yu])
xticklabels([])
yticklabels([])
end
hold off
%% 4. adjust frames

% frames matrix 
Frames_rgb = Frames(Hcrop,Wcrop,:,:); 

% adjust rgb 
Frames_rgb(:,:,1,:) = 1*Frames(Hcrop,Wcrop,1,:); % red 
Frames_rgb(:,:,2,:) = 1*Frames(Hcrop,Wcrop,2,:); % green
Frames_rgb(:,:,3,:) = 1*Frames(Hcrop,Wcrop,3,:); % blue

% convert frames to gray 
Frames_gray = get_gray_frames(Frames_rgb);

% pre-allocate edges of frames 
Frames_BW=false(length(Hcrop),length(Wcrop),length(ii_frame_num));

% pre-allocate adjusted frames 
Frames_adj=Frames_gray;

for ii_frame=1:length(ii_frame_num)
F=Frames_gray(:,:,ii_frame);

% adjust brightness 
low_in=0;
high_in=1;

F_adj=imadjust(F,[low_in high_in]);
F_adj=imsharpen(F_adj);
Frames_adj(:,:,ii_frame)=F_adj;

% edge finding 
THRESH = [0.06 0.09];
[BW,threshOut] = edge(F_adj,'Canny',THRESH);
Frames_BW(:,:,ii_frame)=BW;

tiledlayout(3,1)

% rgb image 
nexttile
imshow(Frames_rgb(:,:,:,ii_frame))
title(['frame: ' num2str(ii_frame_num(ii_frame))])

% adjusted gray scale image 
nexttile
imshow(F_adj)
colormap(inferno(256))

% edges 
nexttile
imshow(BW)
title(threshOut)

pause(0.5)
end

%% 5. remove steady edges
cutoff=0.25*length(ii_frame_num);    

% pre-allocate transient BW 
Frames_BW_transient=Frames_BW;

% total times pixel is edge 
sum_Frames_BW=sum(Frames_BW,3);

% total times pixel is edge >= cuttof 
BW_cutoff=sum_Frames_BW>=cutoff;

% thicken and bridge 
BW_cutoff=bwmorph(BW_cutoff,'thicken',3);
BW_cutoff=bwmorph(BW_cutoff,'bridge',10);

for n=1:length(ii_frame_num)
  BW=Frames_BW(:,:,n);
  BW(BW_cutoff)=false;
  BW=bwmorph(BW,'clean');
  Frames_BW_transient(:,:,n)=BW;
end

imshow(BW_cutoff)
%%
for ii_frame=1:length(ii_frame_num)
imshow(Frames_BW_transient(:,:,ii_frame))
pause(1)
end
%% 5.5 view edges and overlay edges 
for ii_frame=1
[x_T,Y_T] = get_true_pixels(Frames_BW_transient(:,:,ii_frame));
imshow(Frames(Hcrop,Wcrop,:,ii_frame))
hold on
scatter(x_T,Y_T,1,'MarkerEdgeColor',[0 0 1])
set(gca,'Ydir','reverse')
hold off
end

%% region of interest (ROI) QC 
ii_frame=1;
BW_QC=Frames_BW(:,:,ii_frame);
imshow(BW_QC)
[H,W]=size(BW);
my_vertices = [linspace(0,W,10) W 0; H/2*ones(1,10) H H]';
roi = drawpolygon('Position',my_vertices);
%% apply mask 
mask = createMask(roi);
BW_QC(mask)=false;
imshow(BW_QC)





%% brightness adjustments and theshholds vs tru pixels % plot
% set frame 
% ii_frame=1;
% F=frames_gray(Hcrop_wave,Wcrop,ii_frame);
% [H,W]=size(F);
% lowIn=0:0.1:0.6;
% threshHigh=0.01:0.01:0.5;
% totalTrue=zeros(length(lowIn),length(threshHigh));
% for n=1:length(threshHigh)
%     for m=1:length(lowIn)
%         F_adj=imadjust(F,[lowIn(m) 1]);
%         threshold = [0 threshHigh(n)];
%         BW = edge(F_adj,'Canny',threshold);
%         totalTrue(m,n)=sum(BW==true,"all")/(H*W);
%     end
% end
% 
% plot(threshHigh,100*totalTrue)
% xlabel('threshHigh')
% ylabel('true pixels (%)')
% title(ii_frame)
% legend(num2str(lowIn'))
