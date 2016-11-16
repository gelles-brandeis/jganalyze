function git_repos_version()
disp(mfilename('fullpath'));
dos('git describe --always --long --dirty --tags', '-echo');
