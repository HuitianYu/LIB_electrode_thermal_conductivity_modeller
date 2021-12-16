%% ENABLE_RECOVER
% recovers the 'Enable' states of all uicontrols

function enable_recover

array_handleWithEnable = findall(gcf, '-property', 'enable');
array_enable = getappdata(0, 'array_enable');

array_handleWithEnable_on = array_handleWithEnable(strcmp(array_enable,'on'));
set(array_handleWithEnable_on,'enable', 'on')

rmappdata(0, 'array_enable')
end