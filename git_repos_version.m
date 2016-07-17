function git_repose_version()
disp(mfilename('fullpath'));
dos('git describe --always --long --dirty --tags', '-echo');
