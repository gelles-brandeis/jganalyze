run='run 7'
load('03_26_15_106_efret_1st_pairs-1.mat')
x=efret_1st_pairs;
gridx1 = 0:.5:80;
gridx2 = 0:0.005:1;
cellarea = 0.5 * 0.005;
bw = [2.7, 0.05];
bw
% make negative image of data within 3 sigma of t=0
ttol = 3 * bw(1);
xim=x(x(:,1)<ttol & x(:,1)>0,:);
xim(:,1)=xim(:,1).* -1;
x = [x;xim];

[f, intgl, x1s, x2s]=kernel_hist_2d(x,gridx1,gridx2,bw,cellarea);
intgl
h=fret_hist_2d(x1s,x2s,f);
h.Visible='on';
savefig(run);