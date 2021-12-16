%% TASKICON_ACTIVE
% activates the task icon

try
    warning('off') 
    taskIcon = javax.swing.ImageIcon(...
        fullfile(getappdata(0, 'pathParent'),getappdata(0,'folderName_project'),...
        'input','image','icon','processed','task_icon_active.png'));
    figFrame = get(gcf, 'JavaFrame');
    figFrame.setFigureIcon(taskIcon);
    warning('on')
catch

end
