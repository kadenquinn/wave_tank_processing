%% script for messing around with techniques 
%% 0. load/add path
clear
close 
% add stuff to path 
addpath('functions/')
addpath('../data/')
%% 1. get video object 
test_date = '9_24';   
test_ID = 'B';               
camera_ID = 'GoPro_2';         
run_num=3;

% define video filename 
data_struct = load(['test_' test_date '.mat']);
filename = data_struct.(['test_' test_date]).(test_ID).(camera_ID)(run_num);

% define video path 
%video_path = "test_1_9_11_2024/GoPro_0/";
%video_path = "../gopro_0/"; 

video_path = ['../Videos_' test_date '_2024/' camera_ID '/']; 


% create video object 
VideoObj=VideoReader(append(video_path,filename));
disp('done with creating video object')
%% 2. select desired frames

wave_num = 5;
freq = data_struct.(['test_' test_date]).paddle_data.freq(run_num);
[frame_start,frame_end] = approx_waves(freq,wave_num,VideoObj.FrameRate);
ii_frame_num = round(linspace(frame_start,frame_end,15));
Frames = get_frames(VideoObj,ii_frame_num);
%% 2. full color, full size 
% check size of frames 
[H,W,~,~]=size(Frames);

% crop 
Hcrop=(800:1300); %Hcrop=1:H;
Wcrop=(1:W);      %Wcrop=1:W;

% set up tile layout specs
figure
tile_rows = 5;
tile_columns = 3; 
tile=tiledlayout(tile_rows,tile_columns);
for n=1:length(ii_frame_num)
nexttile
imshow(Frames(Hcrop,Wcrop,:,n))
%text(1,1,['frame: ' num2str(ii_frame_num(n))],'HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor',[1 1 1])
title(['frame: ' num2str(ii_frame_num(n))])
end
tile.Padding = 'tight';
tile.TileSpacing = 'tight';
%% 3. resize and recolor
Frames_resized = get_resized_frames(Frames(Hcrop,Wcrop,:,:),0.5);
Frames_resized_hsv = get_hsv_frames(Frames_resized);
Frames_resized_gray = get_gray_frames(Frames_resized);

figure
tiledlayout(tile_rows,tile_columns);
for n=1:length(ii_frame_num)
nexttile
imshow(Frames_resized(:,:,:,n))
text(1,1,['frame: ' num2str(ii_frame_num(n))],'HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor',[1 1 1])
end
%% 4. adjust gray image 
low_in=0.4;
high_in=0.6;
Frames_resized_adj = get_adj_frames(Frames_resized,low_in,high_in);

figure
tile=tiledlayout(tile_rows,tile_columns);
for n=1:length(ii_frame_num)
nexttile
imshow(Frames_resized_adj(:,:,n))
%text(1,1,['frame: ' num2str(ii_frame_num(n))],'HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor',[1 1 1])
end
colormap(inferno(20))
tile.Padding = 'tight';
tile.TileSpacing = 'tight';
%% 5. hsv histograms
figure
tiledlayout(3,1)

hist_edges = 0:0.01:1;
nexttile
histogram(Frames_resized_hsv(:,:,1,:),hist_edges,'Normalization','probability')
title('h')

nexttile
histogram(Frames_resized_hsv(:,:,2,:),hist_edges,'Normalization','probability')
title('s')

nexttile
histogram(Frames_resized_hsv(:,:,3,:),hist_edges,'Normalization','probability')
title('v')
%% 5.1 hue

figure
tiledlayout(tile_rows,tile_columns);
for n=1:length(ii_frame_num)
nexttile
imshow(Frames_resized_hsv(:,:,1,n))
text(1,1,['frame: ' num2str(ii_frame_num(n))],'HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor',[1 1 1])
end
cb=colorbar;
cb.Location='southoutside';
colormap(hsv(20))
%% 5.2 sat
figure
tiledlayout(tile_rows,tile_columns);
for n=1:length(ii_frame_num)
nexttile
imshow(Frames_resized_hsv(:,:,2,n))
text(1,1,['frame: ' num2str(ii_frame_num(n))],'HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor',[1 1 1])
end
cb=colorbar;
cb.Location='southoutside';
colormap(inferno(20))
%% 5.3 val
figure
tiledlayout(tile_rows,tile_columns);
for n=1:length(ii_frame_num)
nexttile
imshow(Frames_resized_hsv(:,:,3,n))
text(1,1,['frame: ' num2str(ii_frame_num(n))],'HorizontalAlignment','left','VerticalAlignment','top','BackgroundColor',[1 1 1])
end
cb=colorbar;
cb.Location='southoutside';
colormap(inferno(20))
%% 6. edges
figure
THRESH = [0.15 0.2];
steady = 10;
[BW,BW_steady,BW_transient] = get_edges(Frames_resized_adj,THRESH,steady);

tiledlayout(tile_rows,tile_columns);
for n=1:length(ii_frame_num)
nexttile
imshow(BW_transient(:,:,n))
end
%%
for n=1:length(ii_frame_num)
imshow(BW_transient(:,:,n))
pause(0.5)
end

%% 7.1 select water
%% This opens a gui to select water and air
n=1;
F = Frames_resized(:,:,:,n);
imshow(F)
h_water = drawfreehand;
bw_water = createMask(h_water);
%% 7.2 select air
imshow(F)
h_air = drawfreehand;
bw_air = createMask(h_air);
%% 8. hsv hsitogrms for air and water 


% add hsitogram for all 

F_h=Frames_resized_hsv(:,:,1,n);
F_s=Frames_resized_hsv(:,:,2,n);
F_v=Frames_resized_hsv(:,:,3,n);

water_h_low = mean(F_h(bw_water))-1*std(F_h(bw_water));
water_h_high = mean(F_h(bw_water))+1*std(F_h(bw_water));

water_s_low = mean(F_s(bw_water))-1*std(F_s(bw_water));
water_s_high = mean(F_s(bw_water))+1*std(F_s(bw_water));

water_v_low = mean(F_v(bw_water))-1*std(F_v(bw_water));
water_v_high = mean(F_v(bw_water))+1*std(F_v(bw_water));

tiledlayout(3,1)
hist_edges = 0:0.01:1;
nexttile
histogram(F_h(bw_water),hist_edges,'Normalization','probability')
hold on
histogram(F_h(bw_air),hist_edges,'Normalization','probability')
legend('water','air')
title('h')
xline([water_h_low water_h_high])
hold off

nexttile
histogram(F_s(bw_water),hist_edges,'Normalization','probability')
hold on
histogram(F_s(bw_air),hist_edges,'Normalization','probability')
xline([water_s_low water_s_high])
title('s')
hold off

nexttile
histogram(F_v(bw_water),hist_edges,'Normalization','probability')
hold on
histogram(F_v(bw_air),hist_edges,'Normalization','probability')
xline([water_v_low water_v_high])
title('v')
hold off
%% 9. water edges 

channel_limits=[water_h_low water_h_high ; water_s_low water_s_high ; water_v_low water_v_high];
BW_water = limit_color_channels(Frames_resized_hsv,channel_limits);

n=3;

BW_water_edges = double(BW_water) + double(BW_transient);

tiledlayout(2,2)
t1=nexttile;
imshow(BW_water(:,:,n))

t2=nexttile;
imshow(BW_transient(:,:,n))

t3=nexttile;
imshow(BW_water_edges(:,:,n))
%colormap(t3,[0 0 0 ; 1 1 1 ; 0 0 1])
clim([0 2])
colorbar

t4=nexttile;
imshow(Frames_resized(:,:,:,n))

%% old stuff 
% hist_edges = 0:0.025:1;
% nexttile
% histogram(Frames_resized_hsv(:,:,1,:),hist_edges)
% 
% nexttile
% histogram(Frames_resized_hsv(:,:,2,:),hist_edges)
% 
% nexttile
% histogram(Frames_resized_hsv(:,:,3,:),hist_edges)






% %% hue 
% hue_low = 0;
% hue_high = 1;
% Frames_resized_h = squeeze(Frames_resized_hsv(:,:,1,:));
% 
% for n=1:length(ii_frame_num)
% Frames_resized_h(:,:,n) = imadjust(Frames_resized_hsv(:,:,1,n),[hue_low hue_high]);
% end
% 
% tiledlayout(length(ii_frame_num),1);
% for n=1:length(ii_frame_num)
% nexttile
% imshow(Frames_resized_h(:,:,n))
% colormap(inferno(100))
% colorbar
% end
% %% sat
% sat_low = 0;
% sat_high = 1;
% Frames_resized_s = squeeze(Frames_resized_hsv(:,:,2,:));
% 
% for n=1:length(ii_frame_num)
% Frames_resized_s(:,:,n) = imadjust(Frames_resized_hsv(:,:,2,n),[sat_low sat_high]);
% end
% 
% tiledlayout(length(ii_frame_num),1);
% for n=1:length(ii_frame_num)
% nexttile
% imshow(Frames_resized_s(:,:,n))
% colormap(inferno(100))
% colorbar
% end
% %% val
% sat_low = 0;
% sat_high = 1;
% Frames_resized_v = squeeze(Frames_resized_hsv(:,:,3,:));
% 
% for n=1:length(ii_frame_num)
% Frames_resized_v(:,:,n) = imadjust(Frames_resized_hsv(:,:,3,n),[sat_low sat_high]);
% end
% 
% tiledlayout(length(ii_frame_num)+1,1);
% nexttile
% histogram(Frames_resized_v)
% xline([sat_low sat_high],'Color',[1 0 0])
% 
% for n=1:length(ii_frame_num)
% nexttile
% imshow(Frames_resized_hsv(:,:,3,n))
% colormap(inferno(100))
% colorbar
% clim([sat_low sat_high])
% end




% %%
% low=0.2;
% high=1;
% BW_h=BW;
% for n=1:length(ii_frame_num)
% BW_h(:,:,n)=(Frames_resized_hsv(:,:,1,n)>low & Frames_resized_hsv(:,:,1,n)<high);
% 
% end
% for n=1:length(ii_frame_num)
% nexttile
% imshow(BW_h(:,:,n))
% end
% %%
% 
% 
% %% view channel ranges
% low=0.2;
% high=1;
% channel=1;
% for n=1:length(ii_frame_num)
%     tiledlayout(2,1)
%     nexttile
%     histogram(Frames_resized_hsv(:,:,channel,n))
%     xline([low high])
% 
%     nexttile
%     imshow(Frames_resized_hsv(:,:,channel,n)>low & Frames_resized_hsv(:,:,channel,n)<high);
%     pause(1)
% end
% 
% %%
% ii_frame=2
% F=Frames_resized(:,:,:,ii_frame);
% 
% % rgb frames 
% F_r=F(:,:,1);
% F_g=F(:,:,2);
% F_b=F(:,:,3);
% 
% % hsv frames 
% hsv = rgb2hsv(F);
% F_h=hsv(:,:,1);
% F_s=hsv(:,:,2);
% F_v=hsv(:,:,3);
% 
% % edges
% THRESH=[0.01 0.03]+0.02;
% 
% BW = edge(im2gray(F),'canny',THRESH);
% 
% BW_r = edge(F_r,'canny',THRESH);
% BW_g = edge(F_g,'canny',THRESH);
% BW_b = edge(F_b,'canny',THRESH);
% 
% BW_h = edge(F_h,'canny',THRESH);
% BW_s = edge(F_s,'canny',THRESH);
% BW_v = edge(F_v,'canny',THRESH);
% 
% [x_r,Y_r] = get_true_pixels(BW_r);
% [x_g,Y_g] = get_true_pixels(BW_g);
% [x_b,Y_b] = get_true_pixels(BW_b);
% 
% redmap=[linspace(0,1,256)' zeros(256,1) zeros(256,1)];
% greenmap=[zeros(256,1) linspace(0,1,256)' zeros(256,1)];
% bluemap=[zeros(256,1) zeros(256,1) linspace(0,1,256)' ];
% 
% %% hsv edges 
% tile=tiledlayout(3,2);
% t1 = nexttile;
% imshow(F_h)
% colormap(t1,"hsv")
% colorbar
% 
% t2= nexttile;
% imshow(BW_h)
% title(['edges= ' num2str(sum(BW_h,'all')) ' THRESH= ' num2str(THRESH)])
% 
% 
% t3 = nexttile;
% imshow(F_s)
% colormap(t3,"hsv")
% 
% t4= nexttile;
% imshow(BW_s)
% title(['edges= ' num2str(sum(BW_s,'all')) ' THRESH= ' num2str(THRESH)])
% 
% 
% t5 = nexttile;
% imshow(F_v)
% colormap(t5,"hsv")
% 
% t6= nexttile;
% imshow(BW_v)
% title(['edges= ' num2str(sum(BW_v,'all')) ' THRESH= ' num2str(THRESH)])
% 
% 
% tile.Padding = 'tight';
% tile.TileSpacing = 'tight';
% %% rgb edges 
% tile=tiledlayout(3,2);
% t1 = nexttile;
% imshow(F_r)
% colormap(t1,redmap)
% 
% t2= nexttile;
% imshow(BW_r)
% title(['edges= ' num2str(sum(BW_r,'all')) ' THRESH= ' num2str(THRESH)])
% 
% t3 = nexttile;
% imshow(F_g)
% colormap(t3,greenmap)
% title('Green')
% 
% t4= nexttile;
% imshow(BW_g)
% title(['edges= ' num2str(sum(BW_g,'all')) ' THRESH= ' num2str(THRESH)])
% 
% 
% t5 = nexttile;
% imshow(F_b)
% colormap(t5,bluemap)
% title('Blue')
% 
% t6= nexttile;
% imshow(BW_b)
% title(['edges= ' num2str(sum(BW_b,'all')) ' THRESH= ' num2str(THRESH)])
% 
% 
% tile.Padding = 'tight';
% tile.TileSpacing = 'tight';
% 
% %% histograms 
% tiledlayout(3,2)
% nexttile
% histogram(F_r,'FaceColor',[1 0 0])
% title('Red')
% 
% nexttile
% histogram(F_h,'FaceColor',[0 0 0])
% title('Hue')
% 
% nexttile
% histogram(F_g,'FaceColor',[0 1 0])
% title('Green')
% 
% nexttile
% histogram(F_s,'FaceColor',[0 0 0])
% title('Saturation')
% 
% nexttile
% histogram(F_b,'FaceColor',[0 0 1])
% title('Blue')
% 
% nexttile
% histogram(F_v,'FaceColor',[0 0 0])
% title('Value')
% 
% 
% %% images 
% tile=tiledlayout(3,2);
% t1 = nexttile;
% imshow(F_r)
% colormap(t1,redmap)
% title('Red')
% 
% t2=nexttile;
% imshow(F_h)
% colormap(t2,'hsv')
% title('Hue')
% 
% t3 = nexttile;
% imshow(F_g)
% colormap(t3,greenmap)
% title('Green')
% 
% t4=nexttile;
% imshow(F_s)
% colormap(t4,'gray')
% title('Saturation')
% 
% t5 = nexttile;
% imshow(F_b)
% colormap(t5,bluemap)
% title('Blue')
% 
% 
% t6=nexttile;
% imshow(F_v)
% colormap(t6,'gray')
% title('Value')
% 

% clear
% addpath('video_obj_structs/')
% addpath('functions/')
% addpath('Colormaps/')
% load('A_runs.mat')
% %load('A_runs_reef.mat')
% %%
% addpath('gopro_cam_cal/')
% load('GoProParams')
% 
% t=[9];
% FrameRate = A_runs.test_1.cam_1.FrameRate;
% 
% [fn] = times2frames(t,FrameRate);
% 
% frames = get_undistorted_frames(A_runs.test_1.cam_1,fn,cameraParams);
% frames_resized = get_resized_frames(frames,0.1);
% frames_resized_gray = get_gray_frames(frames_resized);
% 
% Hcrop=800:1200;
% 
% ii_frame=1;
% 
% F=frames(Hcrop,:,:,ii_frame);
% 
% F_r=frames(Hcrop,:,1,ii_frame);
% F_g=frames(Hcrop,:,2,ii_frame);
% F_b=frames(Hcrop,:,3,ii_frame);
% 
% low_in = 0;
% high_in = 1;
% F_r=imadjust(F_r,[low_in high_in]);
% F_g=imadjust(F_g,[low_in high_in]);
% F_b=imadjust(F_b,[low_in high_in]);
% 
% F(:,:,1)=F_r;
% F(:,:,2)=F_g;
% F(:,:,3)=F_b;
% 
% HSV = rgb2hsv(F);
% F_H=HSV(:,:,1);
% F_S=HSV(:,:,2);
% F_V=HSV(:,:,3);
% 
% THRESH=[0.01 0.03]+0.07;
% BW_r = edge(F_r,'canny',THRESH);
% BW_g = edge(F_g,'canny',THRESH);
% BW_b = edge(F_b,'canny',THRESH);
% 
% [x_r,Y_r] = get_true_pixels(BW_r);
% [x_g,Y_g] = get_true_pixels(BW_g);
% [x_b,Y_b] = get_true_pixels(BW_b);
% 
% redmap=[linspace(0,1,256)' zeros(256,1) zeros(256,1)];
% greenmap=[zeros(256,1) linspace(0,1,256)' zeros(256,1)];
% bluemap=[zeros(256,1) zeros(256,1) linspace(0,1,256)' ];
% 
% 
% tile=tiledlayout(3,2);
% t1 = nexttile;
% imshow(F_r)
% %colormap(t1,redmap)
% colormap(t1,inferno(256))
% title('Red')
% 
% t2= nexttile;
% imshow(BW_r)
% title(['edges= ' num2str(sum(BW_r,'all')) ' THRESH= ' num2str(THRESH)])
% 
% t3 = nexttile;
% imshow(F_g)
% %colormap(t3,greenmap)
% colormap(t3,inferno(256))
% title('Green')
% 
% t4= nexttile;
% imshow(BW_g)
% title(['edges= ' num2str(sum(BW_g,'all')) ' THRESH= ' num2str(THRESH)])
% 
% 
% t5 = nexttile;
% imshow(F_b)
% %colormap(t5,bluemap)
% colormap(t5,inferno(256))
% title('Blue')
% 
% t6= nexttile;
% imshow(BW_b)
% title(['edges= ' num2str(sum(BW_b,'all')) ' THRESH= ' num2str(THRESH)])
% 
% 
% tile.Padding = 'tight';
% tile.TileSpacing = 'tight';
% %%
% 
% 
% 
% %% histograms 
% tiledlayout(3,2)
% nexttile
% histogram(F_r,'FaceColor',[1 0 0])
% title('Red')
% 
% nexttile
% histogram(F_H,'FaceColor',[0 0 0])
% title('Hue')
% 
% nexttile
% histogram(F_g,'FaceColor',[0 1 0])
% title('Green')
% 
% nexttile
% histogram(F_S,'FaceColor',[0 0 0])
% title('Saturation')
% 
% nexttile
% histogram(F_b,'FaceColor',[0 0 1])
% title('Blue')
% 
% nexttile
% histogram(F_V,'FaceColor',[0 0 0])
% title('Value')
% 
% 
% %% images 
% tile=tiledlayout(3,2);
% t1 = nexttile;
% imshow(F_r)
% colormap(t1,redmap)
% title('Red')
% 
% t2=nexttile;
% imshow(F_H)
% colormap(t2,'hsv')
% title('Hue')
% 
% t3 = nexttile;
% imshow(F_g)
% colormap(t3,greenmap)
% title('Green')
% 
% t4=nexttile;
% imshow(F_S)
% colormap(t4,'gray')
% title('Saturation')
% 
% t5 = nexttile;
% imshow(F_b)
% colormap(t5,bluemap)
% title('Blue')
% 
% 
% t6=nexttile;
% imshow(F_V)
% colormap(t6,'gray')
% title('Value')
% 
% %%
% 
% %%
% tiledlayout(5,1)
% for n=1:length(fn)
% nexttile
% imagesc(frames_resized_gray(:,:,n))
% colormap(inferno(255))
% axis image
% end
% hold off
% %%
% 
% F1=frames_resized_gray(:,:,1);
% 
% med=double(median(F1,'all'))/255;
% 
% F1_adj=imadjust(F1,[med-0.1 med+0.1]);
% 
% 
% 
% tiledlayout(2,1)
% nexttile
% imagesc(F1)
% nexttile
% imagesc(F1_adj)
% colormap(inferno(255))
% 
% 
% %%
% BW_t=false(height(frame_small),length(frame_small),length(fn));
% tiledlayout(4,5)
% for n=1:length(fn)
% nexttile
% frame_small=imresize(frames(:,:,:,n),0.1);
% BW= edge(im2gray(frame_small),'Sobel',0.005);
% BW_t(:,:,n)=BW;
% imshow(BW)
% end
% hold off
% %%
% BW_sum=sum(BW_t,3);
% imagesc(BW_sum)
% cb=colorbar;
% addpath('Colormaps/')
% colormap(inferno(20))
% %%
% 
% % fnum=9;
% % 
% % bw_a=BW_t(:,:,fnum);
% % bw_b=BW_t(:,:,fnum);
% % 
% % cutoff=4;
% % bw_a(BW_sum>cutoff)=false;
% % bw_b(BW_sum<cutoff)=false;
% % 
% % tiledlayout(1,2)
% % nexttile
% % imshow(bw_a)
% % 
% % nexttile
% % imshow(bw_b)
% 
% %% distorted vs undistorted frame 
% % frame_distorted = read(A_runs.test_1.cam_1,500);
% % frame_undistorted = get_undistorted_frames(A_runs.test_1.cam_1,500,cameraParams);
% % 
% % imshowpair(frame_distorted,frame_undistorted,"falsecolor")
% %%
% % 
% % t=[4.17 6.25 8.3 10.37 12.42 14.5 16.57 18.7 20.9 23];
% % FrameRate=119.8801;
% % frame_0_nums=round(FrameRate*t);
% % frames = frame_0_nums(3)+[0:20:120];
% % Height_crop=800:1600;
% % Width_crop=1:3400;
% % 
% % BW_t = false(length(Height_crop),length(Width_crop),length(frames));
% % tiledlayout(length(frames),2)
% % for n=1:length(frames)
% %     nexttile
% %     frame_no_reef = read(A_runs.test_1.cam_1,frames(n));
% %     imshow(frame_no_reef(Height_crop,Width_crop,:))
% %     axis image
% % 
% %     nexttile
% % %"Sobel" (default) | "Prewitt" | "Roberts" | "log" | "zerocross" | "Canny" | "approxcanny"
% %     BW = edge(im2gray(frame_no_reef(Height_crop,Width_crop,:)),'Sobel',0.01);
% %     BW_t(:,:,n)=BW;
% %     imshow(BW)
% % end
% % %%
% % addpath('Colormaps/')
% % logical_t=sum(BW_t,3);
% % image(logical_t)
% % shading flat
% % colorbar
% % colormap(plasma(length(frames)))
% % axis image
% % %%
% % BW_t_cut=false(length(Height_crop),length(Width_crop),length(frames));
% % for n=1:length(frames)
% % bw=BW_t(:,:,n);
% % bw(logical_t>1)=false;
% % BW_t_cut(:,:,n)=bw;
% % end
% % 
% % tiledlayout(length(frames),2)
% % for n=1:length(frames)
% %     nexttile
% %     frame_no_reef = read(A_runs.test_1.cam_1,frames(n));
% %     imshow(frame_no_reef(Height_crop,Width_crop,:))
% %     axis image
% % 
% %     nexttile
% %     imshow(BW_t_cut(:,:,n))
% % end
% % %%
% % [X,Y] = meshgrid(1:length(Width_crop),1:length(Height_crop));
% % 
% % %tiledlayout(length(frames),1)
% % for n=3%1:length(frames)
% % nexttile
% % xx=X(BW_t_cut(:,:,n));
% % yy=Y(BW_t_cut(:,:,n));
% % 
% % % find median 
% % % xx_median=ones(size(min(xx):max(xx)));
% % % yy_median=ones(size(min(xx):max(xx)));
% % % for m=min(xx):max(xx)
% % %     xx_median(m)=m;
% % %     yy_median(m)=median(yy(xx==m));
% % % end
% % 
% % frame_no_reef = read(A_runs.test_1.cam_1,frames(n));
% % image(frame_no_reef(Height_crop,Width_crop,:))
% % hold on
% % scatter(xx,yy,1,'MarkerEdgeColor',[1 0 1])
% % %scatter(xx_median,yy_median,1,'MarkerEdgeColor',[1 1 0])
% % axis image
% % colormap('gray')
% % set(gca,'Ydir','reverse')
% % hold off
% % end
% % %%
