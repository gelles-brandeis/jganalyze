function y = two_gaussian_one_sigma_pdf(x,varargin)
% pdf values for a two-component Gaussian mixture model with the same sigma
% for each
%
% y - probability densities
% x - input params
% parms - [p1 mu1 sigma mu2] where 0 < p <1 is fractional amplitude; p1 +
%   p2 = 1
parms=cell2mat(varargin);
a=parms(1);
covar=parms(3)^2;
distn=gmdistribution([parms(2);parms(4)],covar,[a;1-a]);
y = pdf(distn,x);
global parm_names
parm_names= {'p1'; 'mu1'; 'sigma'; 'mu2'};
end