clear
load dist_aip2
%set 1
tt = title1;
dwellts = data1;
dwell_rec = data1 + data1after;
obsts = data1trunc;
recl = 400; %??
finite_dwell_plot4;
savefig(strjoin(tt));
saveas(gcf,strjoin(tt),'pdf');
%set 2
tt = title2;
dwellts = data2;
dwell_rec = data2 + data2after;
obsts = data1trunc;
recl = 400; %??
finite_dwell_plot4;
savefig(strjoin(tt));
saveas(gcf,strjoin(tt),'pdf');