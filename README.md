# wave_tank_processing

## Scripts 
There are currently 7 processing scripts for 

### create_data_structures.m
Creates the following data structures and moves them to a ../data/ folder 
test_9_11.mat
test_9_24.mat
test_slopes.mat

### set_up_wave_start_end_frames.m
creates wave_start_end_frames.mat and moves it to ../data/ folder 
creates a QC fig and moves it to wave_start_end_frames_QC

### measure_pixels.m
Opens a gui to measure the 0.5 in grid in pixels to get a conversion for pixels/0.5 inch
Saves a QC fig to /measure_QC_figs/test_9_11 or /measure_QC_figs/test_9_24

### data_explore.m
An experimental script to play around with image processing techniques for a given test run number and wave. 

### compare_frames.m
Compare frames in tiled layout from different videos files 

### L1_QC_FbF.m
QC an individual frame using MATLABs imageSegmenter app 

### L1_QC.m 
Create 3 QC figs for a set of frames corresponding to a test run number and wave
1. Full color frames (F)
2. Resized and contrast adjusted frames (F_RA) 
3. Edges from Resized and contrast adjusted frames (F_BW) 
