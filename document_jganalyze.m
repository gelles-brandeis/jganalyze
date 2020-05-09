% Use m2html to create documentation for jganalyze

% The current version of m2html is at https://github.com/gllmflndn/m2html
% this script assumes m2html is installed at:
addpath('C:\Users\gelles\Documents\GitHub\m2html')
cd ('C:\Users\gelles\Documents\GitHub')
warning('off')
m2html('mfiles','jganalyze', 'htmldir','jganalyze/documentation', ...
    'recursive','on', 'source', 'off', 'ignoredDir', 'documentation');