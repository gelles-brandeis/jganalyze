function y = three_gaussian_two_sigma_pdf(x,varargin)
% pdf values for a two-component Gaussian mixture model with the same sigma
% for the first two components and a different sigma for the third.
%
% y - probability densities
% x - input params
%
% parms - [p1 mu1 sigma12 p2 mu2 mu3 sigma3] where 0 < p1, p2 <1 are the fractional 
% amplitudes; p1 + p2 + p3 = 1
parms=cell2mat(varargin);
covar = zeros(1, 1, 3);
covar(1, 1, 1) = parms(3)^2;
covar(1, 1, 2) = parms(3)^2;
covar(1, 1, 3) = parms(7)^2;
distn=gmdistribution([parms(2);parms(5);parms(6)],covar,...
    [parms(1);parms(4);abs(1-parms(1)-parms(4))]);
y = pdf(distn,x);
global parm_names
parm_names= {'p1'; 'mu1'; 'sigma12'; 'p2'; 'mu2'; 'mu3'; 'sigma3'};
end