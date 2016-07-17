function y = one_gaussian_pdf(x,varargin)
% pdf values for Gaussian 
%
% y - probability densities
% x - input params
% parms - [mu sigma] 
parms=cell2mat(varargin);
y = pdf('Normal', x, parms(1), parms(2));
global parm_names
parm_names= {'mu'; 'sigma'};
end