%script illustrating use of kernel_hist_2d and fret_hist_2d
load('03_26_15_106_efret_1st_pairs-1.mat')
x=efret_1st_pairs;
gridx1 = 0:0.5:80;
gridx2 = 0:0.005:1;
cellarea = 0.5 * 0.005;
bw = [2.7, 0.05];
bw
[f, intgl, x1s, x2s]=kernel_hist_2d(x,gridx1,gridx2,bw,cellarea);
intgl
fret_hist_2d(x1s,x2s,f);