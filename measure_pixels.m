%% scirpt that ulizizes GUI to measure pixels 
%% 0. load data and add stuff to path 
clear
% add paths
addpath('functions/')

% load data structs
load('../data/GoProParams.mat')
%% 1. select a test run and camera 
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

%% 2. get image and annotate scales 
% for GoPro 
IM=get_undistorted_frames(VideoObj,VideoObj.NumFrames-10,cameraParams);

% for RED 
%IM=read(VideoObj,1);

%title and filename for plots 
titstr = [test_ID num2str(run_num) ' ' camera_ID];
filename = [test_ID num2str(run_num) '_' camera_ID];

imageViewer(IM)
% this will launch imageViewer
% Use it to measure distance throughout the image at (10 ish) locations 
% once done, export these distance measruments to worksapce 
% make sure you keep the naming sceme as D##

% for RED 
%IM=read(A_runs_reef.test_7.RED,1);

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
set(groot,'defaultAxesTickLabelInterpreter','latex');  

nexttile
imshow(IM)
hold on
scatter(xs,ys,values,values,'filled')
cb=colorbar;
cb.Location = "southoutside";
cb.Label.String = 'pixels/0.5 in';
cb.Label.Interpreter = 'latex';
    for i = 1:num
    structName = sprintf('D%d', i);
    Pos = eval([structName '.Position']);
    plot(Pos(:,1),Pos(:,2),'Color',[0 0 0],'LineWidth',1)
    hold on
    end
hold off 
title(titstr,'Interpreter','latex')
hold off

nexttile
histogram(values,5)
title(['$\mu=$' num2str(meanValue) ' $\sigma=$' num2str(stdValue) ' N=' num2str(num)],'Interpreter','latex')
xlabel('pixels/0.5 in','Interpreter','latex')

% figure size and specs 
fontsize(8,"points")
fig.Units='inches';
fig.PaperSize=[6 8];
fig.Position=[0 0 6 8];
tile.Padding='compact';
tile.TileSpacing='compact';
%% 3. save as fig and pdf 
savefig(fig,filename)
movefile([filename '.fig'],'/Users/kadequinn/Desktop/glass_channel/QC_figs/');
print(gcf,[filename '.pdf'],'-dpdf','-vector');  
movefile([filename '.pdf'],'/Users/kadequinn/Desktop/glass_channel/QC_figs/');
%%
