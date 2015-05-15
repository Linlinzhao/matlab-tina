# matlab-tina
m files for generating trajectory of each bee and add self-defined feature for using JAABA

****************************************************************
Task one

Use the original tracking file "data.txt" to generate each bee's trajectory. The tricky thing is we split 
each bee's trajectory into several smaller ones due to too many missing frames. 
If just one frame is missing, it is replaced by the average of the frame before and the one after. 
If two or three frames are missing, they are replaced by "NaN"

data_fillOne_Nan.m finished this task.
****************************************************************
Task two

Add self-defined features for using JAABA. 

Gap Feature:
If there are two consecutive "Nan"s in a trajectory, they are replaced with value "2", which means two frames are missing. 
And value "3" for three consecutive "Nan"s.
gen_gap.m finished the gap feature. 


Comb Feature:

****************************************************************
Instructions for Christina:

1. put the tracking file, data_fillOne_Nan.m and gen_gap.m in one directory
2. run data_fillOne_Nan.m first to generate the trajectories which gives a .mat file like "trx.mat"
3. run gen_gap.m to generate the gap feature for each frame of each bee, which gives a .mat file "gap.mat"
4. Start JAABA, generate perframe features using "trx.mat", quit JAABA
5. put "gap.mat" to folder "yourproject/perframe"
6. Start JAABA again. 

