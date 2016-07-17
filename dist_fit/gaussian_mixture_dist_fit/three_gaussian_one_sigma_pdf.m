function y = three_gaussian_one_sigma_pdf(x,varargin)
% pdf values for a three-component Gaussian mixture model with the same sigma
% for each component
%
% y - probability densities
% x - input params
% parms - [p1 mu1 sigma p2 mu2 mu3] where 0 < p1, p2 <1 are the fractional 
% amplitudes; p1 + p2 + p3 = 1
parms=cell2mat(varargin);
covar=parms(3)^2;
distn=gmdistribution([parms(2);parms(5);parms(6)],covar,...
    [parms(1);parms(4);1-parms(1)-parms(4)]);
y = pdf(distn,x);
global parm_names
parm_names= {'p1'; 'mu1'; 'sigma'; 'p2'; 'mu2'; 'mu3'; };
end
