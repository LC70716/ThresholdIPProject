function makeplot = makeplot(title_k,title_w,y_label,algo_number,k_matrix,w_matrix,param_matrix)
%DO NOT USE THIS ONE WITH ZHANG'S
figure % x = k plot
m = {'-+','-o','-*','-.','-x','-s','-d','-^','-v','->','-<','-p','-h'}; %marker styles
colors = [0 0.5 0 ; 0.5 0 0 ; 0 0 0.5 ; 0.5 0.5 0 ; 0 0.5 0.5 ; 0.5 0 0.5 ; ...
    0.75 0.25 0 ; 0.75 0 0.25 ; 0.25 0 0.75 ; 0.25 0.25 0.25]; %setting up colors [R G B]
set(gca(), 'LineStyleOrder', m, 'ColorOrder',colors, 'NextPlot','replacechildren')
plot(k_matrix(algo_number,:),param_matrix,'LineWidth', 1)
xlabel('Bias'); %this defaults to bias, you can change it directly in the figure if you want
ylabel(y_label);
title(title_k); 
legendCell=strcat('W =',strtrim(cellstr(num2str(transpose(w_matrix(algo_number,:))))));
legend(legendCell); 
%FOR ZHANG COPY THIS IN ANOTHER SCRIPT
figure % x = w plot
m = {'-+','-o','-*','-.','-x','-s','-d','-^','-v','->','-<','-p','-h'};
colors = [0 0.5 0 ; 0.5 0 0 ; 0 0 0.5 ; 0.5 0.5 0 ; 0 0.5 0.5 ; 0.5 0 0.5 ; ...
    0.75 0.25 0 ; 0.75 0 0.25 ; 0.25 0 0.75 ; 0.25 0.25 0.25]; %setting color scheme, cannot come up w/ 41 different combination of rgb values
set(gca(), 'LineStyleOrder', m, 'ColorOrder',colors, 'NextPlot','replacechildren')
plot(w_matrix(algo_number,:),param_matrix,'LineWidth', 1)
xlabel('Window Size');
ylabel(y_label);
title(title_w);
legendCell=strcat('K =',strtrim(cellstr(num2str(transpose(k_matrix(algo_number,:))))));
legend(legendCell);