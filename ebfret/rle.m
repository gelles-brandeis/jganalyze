function [data, runvalue] = rle(x)
% data = rle(x) (de)compresses the data with the RLE-Algorithm
%   Compression:
%      if x is a numbervector data contains the run lengths
%      and runvalue contains the data values
%
%   Decompression:
%      if x is a cell array, data contains the uncompressed values
%
%      Version 1.0 by Stefan Eireiner (<a href="mailto:stefan-e@web.de?subject=rle">stefan-e@web.de</a>)
%      based on Code by Peter J. Acklam
%      last change 14.05.2004
%      modified by JG 1021/2018 to produce two separate outputs
%
% from https://www.mathworks.com/matlabcentral/fileexchange/4955-rle-de-encoding
%%
if iscell(x) % decoding
	i = cumsum([ 1 x{2} ]);
	j = zeros(1, i(end)-1);
	j(i(1:end-1)) = 1;
	data = x{1}(cumsum(j));
else % encoding
	if size(x,1) > size(x,2), x = x'; end % if x is a column vector, tronspose
    i = [ find(x(1:end-1) ~= x(2:end)) length(x) ]; % indices of run ends
	data = diff([ 0 i ]); % run length
	runvalue = x(i); % run value
end