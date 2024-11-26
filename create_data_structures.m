clear 
close
%% 9/11
addpath('test_1_9_11_2024/gopro_0/')
addpath('test_1_9_11_2024/gopro_1/')

% A 
test_9_11.A.GoPro_0=string(['GX010054.MP4';'GX010055.MP4';'GX010058.MP4';'GX010059.MP4';'GX010060.MP4';'GX010061.MP4';'GX010062.MP4';'GX010063.MP4';'GX010064.MP4';'GX010065.MP4']);
test_9_11.A.GoPro_1=string(['GX010021.MP4';'GX010022.MP4';'GX010025.MP4';'GX010026.MP4';'GX010027.MP4';'GX010028.MP4';'GX010029.MP4';'GX010030.MP4';'GX010031.MP4';'GX010032.MP4']);

% B 
test_9_11.B.GoPro_0=string(['GX010066.MP4';'GX010067.MP4';'GX010068.MP4';'GX010069.MP4';'GX010070.MP4';'GX010071.MP4';'GX010072.MP4';'GX010073.MP4';'GX010076.MP4';'GX010075.MP4']);
test_9_11.B.GoPro_1=string(['GX010033.MP4';'GX010034.MP4';'GX010035.MP4';'GX010036.MP4';'GX010037.MP4';'GX010038.MP4';'GX010039.MP4';'GX010040.MP4';'GX010043.MP4';'GX010042.MP4']);

% paddle_data
test_9_11.paddle_data.freq = [0.5 0.67 0.67 0.8 0.8 0.8 1 1 1 1.25];
test_9_11.paddle_data.amp = [100 60 80 30 60 80 25 50 70 20];
test_9_11.paddle_data.test_num=[1:10]';

save('test_9_11','test_9_11')
movefile('test_9_11.mat' ,'/Users/kadequinn/Desktop/wave_tank_expts/data_structs/');
%% 9/24 
addpath('test_2_9_24_2024/RED/')
addpath('test_2_9_24_2024/gopro_2/')

% A
test_9_24.A.RED=string(['A005_C004_0924TN.mov';'A005_C005_0924G7.mov';'A005_C006_0924DY.mov';'A005_C007_09241J.mov';'A005_C008_09245L.mov';'A005_C009_09240O.mov';'A005_C010_0924N8.mov';'A005_C011_0924RV.mov';'A005_C012_0924WP.mov';'A005_C013_0924RB.mov']);
test_9_24.A.GoPro=string(['GX010084.MP4';'GX010085.MP4';'GX010086.MP4';'GX010087.MP4';'GX010088.MP4';'GX010089.MP4';'GX010091.MP4';'GX010092.MP4';'GX010094.MP4';'GX010096.MP4']);

% B 
test_9_24.B.RED=string(['A005_C014_0924MM.mov';'A005_C015_0924CH.mov';'A005_C017_0924OS.mov';'A005_C019_09244A.mov';'A005_C020_0924RE.mov';'A005_C021_0924WR.mov';'A005_C022_0924E7.mov';'A005_C023_0924XI.mov';'A005_C024_0924P6.mov';'A005_C025_09245M.mov']);
test_9_24.B.GoPro=string(['GX010057.MP4';'GX010058.MP4';'GX010059.MP4';'GX010060.MP4';'GX010061.MP4';'GX010062.MP4';'GX010063.MP4';'GX010064.MP4';'GX010065.MP4';'GX010066.MP4']);

% C
test_9_24.C.RED=string(["N/A" ; "N/A" ; "A005_C026_0924ER.mov" ; "A005_C027_09244X.mov" ; "N/A" ; "A005_C028_0924XX.mov" ; "N/A" ; "N/A" ; "N/A" ; "A005_C029_0924G0.mov"]);
test_9_24.C.GoPro=string(["N/A";"N/A";"GX010067.MP4";"GX010068.MP4";"N/A";"GX010069.MP4";"N/A";"N/A";"N/A";"GX010070.MP4"]);

% D
test_9_24.D.RED=string(['A005_C039_0924BQ.mov';'A005_C030_0924IK.mov';'A005_C031_0924VX.mov';'A005_C032_092482.mov';'A005_C033_092470.mov';'A005_C034_0924TU.mov';'A005_C035_0924Y9.mov';'A005_C036_0924CG.mov';'A005_C037_0924NT.mov';'A005_C038_09245S.mov']);
test_9_24.D.GoPro=string(['GX010071.MP4';'GX010072.MP4';'GX010073.MP4';'GX010074.MP4';'GX010075.MP4';'GX010076.MP4';'GX010077.MP4';'GX010078.MP4';'GX010080.MP4';'GX010081.MP4']);

% paddle_data
test_9_24.paddle_data.freq = [0.5 0.67 0.67 0.8 0.8 0.8 1 1 1 1.25];
test_9_24.paddle_data.amp = [100 60 80 30 60 80 25 50 70 20];
test_9_24.paddle_data.test_num=[1:10]';

save('test_9_24','test_9_24')
movefile('test_9_24.mat' ,'/Users/kadequinn/Desktop/wave_tank_expts/data_structs/');
%%
% %% test #: wave freq vs paddle amp
% paddle_data.freq = [0.5 0.67 0.67 0.8 0.8 0.8 1 1 1 1.25];
% paddle_data.amp = [100 60 80 30 60 80 25 50 70 20];
% paddle_data.test_num=[1:10]';
% 
% fig = figure;
% scatter(paddle_data.freq,paddle_data.amp,150)
% text(paddle_data.freq,paddle_data.amp,num2str(paddle_data.test_num),'HorizontalAlignment','center','VerticalAlignment','middle')
% xlim([0 1.5])
% xlabel('frequency (Hz)')
% ylabel('amplitude (mm)')
% ylim([0 110])
% 
% save('paddle_data','paddle_data')
% 
% % figure size and specs 
% fontsize(8,"points")
% fig.Units='inches';
% fig.PaperSize=[4 4];
% fig.Position=[0 0 4 4];
% 
% % save figure
% print(gcf,'paddle.png','-dpng','-r600');  
% movefile('paddle.png','/Users/kadequinn/Desktop/wave_tank_expts/QC_figs_2/');
% %% gopros 9/11
% % slope A 
% gopro_0_A=string(['GX010054.MP4';'GX010055.MP4';'GX010058.MP4';'GX010059.MP4';'GX010060.MP4';'GX010061.MP4';'GX010062.MP4';'GX010063.MP4';'GX010064.MP4';'GX010065.MP4']);
% gopro_1_A=string(['GX010021.MP4';'GX010022.MP4';'GX010025.MP4';'GX010026.MP4';'GX010027.MP4';'GX010028.MP4';'GX010029.MP4';'GX010030.MP4';'GX010031.MP4';'GX010032.MP4']);
% 
% % slope B 
% gopro_0_B=string(['GX010066.MP4';'GX010067.MP4';'GX010068.MP4';'GX010069.MP4';'GX010070.MP4';'GX010071.MP4';'GX010072.MP4';'GX010073.MP4';'GX010076.MP4';'GX010075.MP4']);
% gopro_1_B=string(['GX010033.MP4';'GX010034.MP4';'GX010035.MP4';'GX010036.MP4';'GX010037.MP4';'GX010038.MP4';'GX010039.MP4';'GX010040.MP4';'GX010043.MP4';'GX010042.MP4']);
% 
% for n=1:10
% test_num=['test_' num2str(n)];
% A_runs.(test_num).cam_0=VideoReader(gopro_0_A(n));
% A_runs.(test_num).cam_1=VideoReader(gopro_1_A(n));
% B_runs.(test_num).cam_0=VideoReader(gopro_0_B(n));
% B_runs.(test_num).cam_1=VideoReader(gopro_1_B(n));
% end
% 
% save('A_runs','A_runs')
% save('B_runs','B_runs')
% %% RED 9/24: A
% 
% % Reef A
% RED_A=string(['A005_C004_0924TN.mov';'A005_C005_0924G7.mov';'A005_C006_0924DY.mov';'A005_C007_09241J.mov';'A005_C008_09245L.mov';'A005_C009_09240O.mov';'A005_C010_0924N8.mov';'A005_C011_0924RV.mov';'A005_C012_0924WP.mov';'A005_C013_0924RB.mov']);
% gopro_2_A=string(['GX010084.MP4';'GX010085.MP4';'GX010086.MP4';'GX010087.MP4';'GX010088.MP4';'GX010089.MP4';'GX010091.MP4';'GX010092.MP4';'GX010094.MP4';'GX010096.MP4']);
% 
% for n=1:10
% test_num=['test_' num2str(n)];
% A_runs_reef.(test_num).RED=VideoReader(RED_A(n));
% A_runs_reef.(test_num).cam_2=VideoReader(gopro_2_A(n));
% end
% save('A_runs_reef','A_runs_reef')
% %% RED 9/24: B
% 
% % Reef B 
% RED_B=string(['A005_C014_0924MM.mov';'A005_C015_0924CH.mov';'A005_C017_0924OS.mov';'A005_C019_09244A.mov';'A005_C020_0924RE.mov';'A005_C021_0924WR.mov';'A005_C022_0924E7.mov';'A005_C023_0924XI.mov';'A005_C024_0924P6.mov';'A005_C025_09245M.mov']);
% 
% gopro_2_B=string(['GX010057.MP4';'GX010058.MP4';'GX010059.MP4';'GX010060.MP4';'GX010061.MP4';'GX010062.MP4';'GX010063.MP4';'GX010064.MP4';'GX010065.MP4';'GX010066.MP4']);
% 
% for n=1:10
% test_num=['test_' num2str(n)];
% B_runs_reef.(test_num).RED=VideoReader(RED_B(n));
% B_runs_reef.(test_num).cam_2=VideoReader(gopro_2_B(n));
% end
% save('B_runs_reef','B_runs_reef')
% %% RED 9/24: C 
% 
% % Reef C
% RED_C=string(['A005_C026_0924ER.mov';'A005_C027_09244X.mov';'A005_C028_0924XX.mov';'A005_C029_0924G0.mov']);
% gopro_2_C=string(['GX010067.MP4';'GX010068.MP4';'GX010069.MP4';'GX010070.MP4']);
% 
% C_runs_reef.test_3.RED=VideoReader(RED_C(1));
% C_runs_reef.test_4.RED=VideoReader(RED_C(2));
% C_runs_reef.test_6.RED=VideoReader(RED_C(3));
% C_runs_reef.test_10.RED=VideoReader(RED_C(4));
% 
% C_runs_reef.test_3.cam_2=VideoReader(gopro_2_C(1));
% C_runs_reef.test_4.cam_2=VideoReader(gopro_2_C(2));
% C_runs_reef.test_6.cam_2=VideoReader(gopro_2_C(3));
% C_runs_reef.test_10.cam_2=VideoReader(gopro_2_C(4));
% 
% save('C_runs_reef','C_runs_reef')
% %% RED 9/24: D
% 
% % Reef D
% RED_D=string(['A005_C039_0924BQ.mov';'A005_C030_0924IK.mov';'A005_C031_0924VX.mov';'A005_C032_092482.mov';'A005_C033_092470.mov';'A005_C034_0924TU.mov';'A005_C035_0924Y9.mov';'A005_C036_0924CG.mov';'A005_C037_0924NT.mov';'A005_C038_09245S.mov']);
% gopro_2_D=string(['GX010071.MP4';'GX010072.MP4';'GX010073.MP4';'GX010074.MP4';'GX010075.MP4';'GX010076.MP4';'GX010077.MP4';'GX010078.MP4';'GX010080.MP4';'GX010081.MP4']);
% 
% for n=1:10
% test_num=['test_' num2str(n)];
% D_runs_reef.(test_num).RED=VideoReader(RED_D(n));
% D_runs_reef.(test_num).cam_2=VideoReader(gopro_2_D(n));
% end
% 
% save('D_runs_reef','D_runs_reef')
% %%
