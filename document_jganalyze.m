% Use m2html to create documentation for jganalyze

% m2html is at http://www.artefact.tk/software/matlab/m2html/
% this script assumes it is installed at:
addpath('C:\Users\gelles\Documents\MATLAB\m2html')
cd ('C:\Users\gelles\Documents\GitHub')
m2html('mfiles','jganalyze', 'htmldir','jganalyze/documentation', ...
    'recursive','on', 'source', 'off', 'ignoredDir', 'documentation');