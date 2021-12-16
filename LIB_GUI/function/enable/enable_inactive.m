%% ENABLE_INACTIVE
% inactives all the uicontrols with 'Enable' property.

function enable_inactive

array_handleWithEnable = findall(gcf, '-property', 'enable');
array_enable = get(array_handleWithEnable,'enable');
setappdata(0, 'array_enable',array_enable)
array_handleWithEnable_on = array_handleWithEnable(strcmp(array_enable,'on'));
set(array_handleWithEnable_on,'enable', 'inactive')

end