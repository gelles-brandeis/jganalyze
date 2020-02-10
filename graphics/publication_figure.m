function publication_figure(h, fname, width, height)
% publication_figure: Outputs a png version of a figure afer setting
% appropriate line widths, font sizes etc.
%
% Input parameters:
%   h - figure handle
%   fname - output file name
%   width - image width (inches)
%   height - image height (inches)
%%
h.Color = [1 1 1];
h.PaperUnits = 'inches';
h.PaperPosition = [0 0 width height];
a=h.CurrentAxes;
a.FontSize = 14;
a.FontName = 'Arial';
a.LineWidth = 2;
for i = 1:length(a.Children)
    a.Children(i).LineWidth = 2;
end
print(h, fname, '-dpng')

end

