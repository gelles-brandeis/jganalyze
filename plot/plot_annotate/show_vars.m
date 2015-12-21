function [strings] = show_vars(vlist)
%SHOW_VARS Places a text box in the current figure that displays variable
%values
%
%Example:
%  show_vars({'tx'; 'tm'}) would produce a box with the text
%
%      tx = 200.0000
%      tm = 0.1000
%
%  if the variables exist in the caller's worspace with those values
%
%  use of evalin in this context suggested by
%  http://www.mathworks.com/matlabcentral/newsreader/view_thread/166740
%
s = length(vlist);
strings = cell(s, 1);
for n = 1:s
%     strings{n} = sprintf('%s = %4.4f',vlist{n},evalin('caller',char(vlist{n})));
    strings{n} = [vlist{n}, ' =  ', num2str(evalin('caller',char(vlist{n})))];
end
annotation('textbox', 'String', strings, 'FitBoxToText', 'on', ...
    'Interpreter', 'none');
end

