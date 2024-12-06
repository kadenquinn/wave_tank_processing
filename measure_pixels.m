%% scirpt that ulizizes GUI to measure pixels 
%% 0. load data and add stuff to path 
clear
% add paths
addpath('functions/')

%% 1. select a test run and camera 
test_date = '9_24';   
test_ID = 'A';               
camera_ID = 'GoPro_2';         
run_num=3;

% define video filename 
data_struct = load(['test_' test_date '.mat']);
filename = data_struct.(['test_' test_date]).(test_ID).(camera_ID)(run_num);

% define video path 
video_path = ['../Videos_' test_date '_2024/' camera_ID '/']; 

% create video object 
VideoObj=VideoReader(append(video_path,filename));

%% 2. get image and annotate scales 

% this will launch imageViewer
% Use it to measure distance throughout the image at (10 ish) locations 
% once done, export these distance measruments to worksapce 
% make sure you keep the naming sceme as D##

% select frame to annotate
ii_frame = 1;

%title and filename for plots 
title_str = [test_ID num2str(run_num) ' ' camera_ID];
title_str(title_str=='_') = ' ';
filename = [test_ID num2str(run_num) '_' camera_ID];

% for GoPro 
camera_IDs_GoPro = {'GoPro_0', 'GoPro_1', 'GoPro_2'};
if ismember(camera_ID,camera_IDs_GoPro)
    load('../data/GoProParams.mat')
    IM=get_undistorted_frames(VideoObj,ii_frame,cameraParams);
end

% for RED
camera_IDs_RED = {'RED', 'RED_mp4'};
if ismember(camera_ID,camera_IDs_RED)
    IM=get_frames(VideoObj,ii_frame);
end

% laucnh 
imageViewer(IM)
%% 2. view results 
% find number of distance measruments created based on naming scheme of D##
vars_in_workspace=who;
vars_in_workspace_c=char(vars_in_workspace);
num=sum(vars_in_workspace_c(:,1)=='D');

values = zeros(1,num);
xs=zeros(1,num);
ys=zeros(1,num);
% loop through the structures
for i = 1:num
    % structure name 
    structName = sprintf('D%d', i);
    % values of measuremnt 
    values(i) = eval([structName '.Value']);
    Pos = eval([structName '.Position']);
    % mean location of measuremnt 
    xs(i)=mean(Pos(:,1));
    ys(i)=mean(Pos(:,2));
end

% Compute the mean and std of the values
meanValue = mean(values);
stdValue = std(values);

fig=figure;
tile=tiledlayout(2,1);

ii = find(values > 0);
xs = xs(ii);
ys = ys(ii);
values = values(ii);

cmap=inferno(length(values));

nexttile
imshow(IM)
hold on
    for i = 1:num
    structName = sprintf('D%d', i);
    Pos = eval([structName '.Position']);
    plot(Pos(:,1),Pos(:,2),'Color',[0 0 0],'LineWidth',1)
    hold on
    end
    scatter(xs,ys,10,values,'filled')
    cb=colorbar;
    cb.Location = "southoutside";
    cb.Label.String = 'pixels/0.5 in';
hold off 
title(title_str)
hold off

nexttile
histogram(values,5)
title(['\mu=' num2str(meanValue) ' \sigma=' num2str(stdValue) ' N=' num2str(num)])
xlabel('pixels/0.5 in')

% figure size and specs 
fontsize(8,"points")
fig.Units='inches';
fig.PaperSize=[6 8];
fig.Position=[0 0 6 8];
tile.Padding='compact';
tile.TileSpacing='compact';
%% 3. save as png

print(gcf,[filename '.png'],'-dpng','-r600');  
movefile([filename '.png'],['../measure_QC_figs/test_' test_date])
%%