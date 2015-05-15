# matlab-tina
m files for generating trajectory of each bee and add self-defined feature for using JAABA

****************************************************************
Task one

Use the original tracking file "data.txt" to generate each bee's trajectory. The tricky thing is we split 
each bee's trajectory into several smaller ones due to too many missing frames. 
If just one frame is missing, it is replaced by the average of the frame before and the one after. 
If two or three frames are missing, they are replaced by "NaN"
****************************************************************
Task two

Add self-defined features for using JAABA. 

Gap Feature:
If there are two consecutive "Nan"s in a trajectory, they are replaced with value "2", which means two frames are missing. 
And value "3" for three consecutive "Nan"s.

Comb Feature:




