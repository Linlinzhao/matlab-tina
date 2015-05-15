clear all;
load('trx0956.mat');

num_bee = length(trx);

for i = 1:num_bee
    
    bee = trx(i);
    x = bee.x;
    y = bee.y;
    theta = bee.theta;
    
    idx_nan = isnan(x);
    idx_nan = +idx_nan;
    ck{i} = idx_nan;
    idx_one = find(idx_nan == 1);
    
    idx_one_shift = [idx_one(2:end); 0];
    
    idx_temp1 = idx_one_shift - idx_one;
    idx_temp1_shift = [idx_temp1(2:end); 0];
    idx_temp2 = idx_temp1_shift - idx_temp1;
        
    idx_temp2_0 = find(idx_temp2 == 0);
    
    idx_nan(idx_one(idx_temp2_0)) = 3;
    idx_nan(idx_one(idx_temp2_0) + 1) = 3;
    idx_nan(idx_one(idx_temp2_0) + 2) = 3;
    
    idx_two = find(idx_nan == 1);
    idx_nan(idx_two) = 2;
    
    gap{i} = idx_nan;
    

end

units.num = {'frame'};
units.den = cell(1, 0);

save('gap.mat', 'gap', 'units');