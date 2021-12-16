%% PATH_GENERATOR: This file adds the path which contains all subpaths of the parent folder of folder main.

%% Add paths
clear
str=pwd;
if ispc
    index_dir=strfind(str,'\pathGenerator');
elseif isunix
    index_dir=strfind(str,'/pathGenerator');
else
    disp('Platform not supported')
end
str_temp=str(1:index_dir(end)-1);
currentFolder = str_temp;
addpath(genpath(currentFolder))
