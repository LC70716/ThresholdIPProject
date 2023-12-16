function [means_,std_devs] = findmeanofimages(number_of_algo,param_cell)
         cell = param_cell{number_of_algo,1};
         matrices = cat(3,cell{1,1},cell{1,2},cell{1,3},cell{1,4},cell{1,5},cell{1,6},cell{1,7},cell{1,8},cell{1,9},cell{1,10});
         means_ = mean(matrices,3);
         std_devs = std(matrices,0,3);
         