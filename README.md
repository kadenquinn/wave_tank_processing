# wave_tank_processing

## Scripts 
main processing scripts for wave tank data videos 

### create_data_structures.m
Creates the following data structures and moves them to a ../data/ folder. 
* test_9_11.mat
* test_9_24.mat
* test_slopes.mat

### set_up_wave_start_end_frames.m
creates wave_start_end_frames.mat and moves it to ../data/ folder. 
Saves the .fig to ../wave_start_end_frames_QC/

### measure_pixels.m
Opens a gui to measure the 0.5 in grid in pixels to get a conversion for pixels/0.5 inch
Saves the .png of the fig to ../measure_QC_figs/test_9_11/ or ../measure_QC_figs/test_9_24/

### data_explore.m
An experimental script to play around with image processing techniques for a given test run number and wave. 

### compare_frames.m
Compare frames in tiled layout from different videos files 

### L1_QC_FbF.m
QC an individual frame using MATLABs imageSegmenter app 

### L1_QC.m 
Create 3 QC figs for a set of frames corresponding to a test run number and wave
1. Full color frames 
2. Resized and contrast adjusted frames
3. Edges from Resized and contrast adjusted frames 
Saves .png of all figs to ../L1_QC_figs/test_9_11/ or ../L1_QC_figs/test_9_24/

## Data 
data structures for wave tank data videos 
### test_9_11.mat & test_9_24.mat
Access video filenames for a test run number and camera i.e. test_9_11.A.GoPro_0(1)
* test_9_11.A.GoPro_0(1)

Access paddle data for a given test by test_9_11.paddle_data
* freq: [0.5000 0.6700 0.6700 0.8000 0.8000 0.8000 1 1 1 1.2500]
* amp: [100 60 80 30 60 80 25 50 70 20]
* test_num: [10×1 double]

### test_slopes.mat
Access slope data for a test run i.e. test_slopes.test_9_11.A
* x: [-125.5000 -75 -2.7500 69 140]
* h: [0 3.3125 6.0625 10.1250 15.5000]
* surface: 15.7480
### wave_start_end_frames.mat
Access start and end frames of each wave for a test run i.e. wave_start_end_frames.test_9_11.GoPro_0.A1
* wave_num: [1 2 3 4 5 6 7 8 9 10]
* frame_start: [10×1 double]
* frame_end: [10×1 double]
### GoProParams.mat
* Calibration data for GoPros, used to undistrot images 

