% kernel_pdf_example: example use of kernel_pdf
nboot = 500;
plot_x = 0:1:x_max;
[yi, l_ci, u_ci] = kernel_pdf(dwells, plot_x, nboot, 90);
subplot(3,2,4);
h=area(plot_x,[l_ci;u_ci-l_ci]','LineStyle','none');
h(1).FaceColor=[1,1,1];
h(2).FaceColor=[1,0.85,0.85];
hold on
plot(plot_x,yi,'r', plot_x, plot_y, 'b');
title ('Gaussian kernel PDF');
xlabel ('dwell time (s)');
ylabel ('pdf (s^{-1})');
legend (' ','data 90% c.i.','data', 'fit');
hold off