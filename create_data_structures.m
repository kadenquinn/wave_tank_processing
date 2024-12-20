clear 
close
%% 9/11
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
movefile('test_9_11.mat' ,'../data/');
%% 9/24 
% A
test_9_24.A.RED=string(['A005_C004_0924TN.mov';'A005_C005_0924G7.mov';'A005_C006_0924DY.mov';'A005_C007_09241J.mov';'A005_C008_09245L.mov';'A005_C009_09240O.mov';'A005_C010_0924N8.mov';'A005_C011_0924RV.mov';'A005_C012_0924WP.mov';'A005_C013_0924RB.mov']);
test_9_24.A.RED_mp4=string(['A005_C004_0924TN.mp4';'A005_C005_0924G7.mp4';'A005_C006_0924DY.mp4';'A005_C007_09241J.mp4';'A005_C008_09245L.mp4';'A005_C009_09240O.mp4';'A005_C010_0924N8.mp4';'A005_C011_0924RV.mp4';'A005_C012_0924WP.mp4';'A005_C013_0924RB.mp4']);
test_9_24.A.GoPro_2=string(['GX010084.MP4';'GX010085.MP4';'GX010086.MP4';'GX010087.MP4';'GX010088.MP4';'GX010089.MP4';'GX010091.MP4';'GX010092.MP4';'GX010094.MP4';'GX010096.MP4']);

% B 
test_9_24.B.RED=string(['A005_C014_0924MM.mov';'A005_C015_0924CH.mov';'A005_C017_0924OS.mov';'A005_C019_09244A.mov';'A005_C020_0924RE.mov';'A005_C021_0924WR.mov';'A005_C022_0924E7.mov';'A005_C023_0924XI.mov';'A005_C024_0924P6.mov';'A005_C025_09245M.mov']);
test_9_24.B.RED_mp4=string(['A005_C014_0924MM.mp4';'A005_C015_0924CH.mp4';'A005_C017_0924OS.mp4';'A005_C019_09244A.mp4';'A005_C020_0924RE.mp4';'A005_C021_0924WR.mp4';'A005_C022_0924E7.mp4';'A005_C023_0924XI.mp4';'A005_C024_0924P6.mp4';'A005_C025_09245M.mp4']);
test_9_24.B.GoPro_2=string(['GX010057.MP4';'GX010058.MP4';'GX010059.MP4';'GX010060.MP4';'GX010061.MP4';'GX010062.MP4';'GX010063.MP4';'GX010064.MP4';'GX010065.MP4';'GX010066.MP4']);

% C
test_9_24.C.RED=string(["N/A" ; "N/A" ; "A005_C026_0924ER.mov" ; "A005_C027_09244X.mov" ; "N/A" ; "A005_C028_0924XX.mov" ; "N/A" ; "N/A" ; "N/A" ; "A005_C029_0924G0.mov"]);
test_9_24.C.RED_mp4=string(["N/A" ; "N/A" ; "A005_C026_0924ER.mp4" ; "A005_C027_09244X.mp4" ; "N/A" ; "A005_C028_0924XX.mp4" ; "N/A" ; "N/A" ; "N/A" ; "A005_C029_0924G0.mp4"]);
test_9_24.C.GoPro_2=string(["N/A";"N/A";"GX010067.MP4";"GX010068.MP4";"N/A";"GX010069.MP4";"N/A";"N/A";"N/A";"GX010070.MP4"]);

% D
test_9_24.D.RED=string(['A005_C039_0924BQ.mov';'A005_C030_0924IK.mov';'A005_C031_0924VX.mov';'A005_C032_092482.mov';'A005_C033_092470.mov';'A005_C034_0924TU.mov';'A005_C035_0924Y9.mov';'A005_C036_0924CG.mov';'A005_C037_0924NT.mov';'A005_C038_09245S.mov']);
test_9_24.D.RED_mp4=string(['A005_C039_0924BQ.mp4';'A005_C030_0924IK.mp4';'A005_C031_0924VX.mp4';'A005_C032_092482.mp4';'A005_C033_092470.mp4';'A005_C034_0924TU.mp4';'A005_C035_0924Y9.mp4';'A005_C036_0924CG.mp4';'A005_C037_0924NT.mp4';'A005_C038_09245S.mp4']);
test_9_24.D.GoPro_2=string(['GX010071.MP4';'GX010072.MP4';'GX010073.MP4';'GX010074.MP4';'GX010075.MP4';'GX010076.MP4';'GX010077.MP4';'GX010078.MP4';'GX010080.MP4';'GX010081.MP4']);

% paddle_data
test_9_24.paddle_data.freq = [0.5 0.67 0.67 0.8 0.8 0.8 1 1 1 1.25];
test_9_24.paddle_data.amp = [100 60 80 30 60 80 25 50 70 20];
test_9_24.paddle_data.test_num=[1:10]';

save('test_9_24','test_9_24')
movefile('test_9_24.mat' ,'../data/'); 
%% slope measurments (inches) 
% 9/11 
% A
test_slopes.test_9_11.A.x = [-125.5 -75 -2.75 69 140];
test_slopes.test_9_11.A.h = [0 3.3125 6.0625 10.125 15.5];
test_slopes.test_9_11.A.surface = 40*0.393701; 

% B
test_slopes.test_9_11.B.x = [-125.5 -75 -2.75 69 140];
test_slopes.test_9_11.B.h = [0 3.375 8.375 14.875 22.9375];
test_slopes.test_9_11.B.surface = 40*0.393701;

% 9/24 
% A  
test_slopes.test_9_24.A.x = [-125.5 -75 -2.75 69 140];
test_slopes.test_9_24.A.h = [0 3.5 6.25 10.5 15.5];
test_slopes.test_9_24.A.surface = 42*0.393701; 
test_slopes.test_9_24.A.x_reef = 0;

% B
test_slopes.test_9_24.B.x = [-125.5 -75 -2.75 69 140];
test_slopes.test_9_24.B.h = [0 3.5 6.25 10.5 15.5];
test_slopes.test_9_24.B.surface = 42*0.393701; 
test_slopes.test_9_24.B.x_reef = 23;

% C
test_slopes.test_9_24.C.x = [-125.5 -75 -2.75 69 140];
test_slopes.test_9_24.C.h = [0 3.5 6.25 10.5 15.5];
test_slopes.test_9_24.C.surface = 42*0.393701; 
test_slopes.test_9_24.C.x_reef = 41;

% D
test_slopes.test_9_24.D.x = [-125.5 -75 -2.75 69 140];
test_slopes.test_9_24.D.h = [0 3.5 6.25 10.5 15.5];
test_slopes.test_9_24.D.surface = 42*0.393701; 
test_slopes.test_9_24.D.x_reef = 0;

save('test_slopes','test_slopes')
movefile('test_slopes.mat' ,'../data/'); 
%%