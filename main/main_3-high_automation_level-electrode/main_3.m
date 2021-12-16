%% MAIN_3 Automation level 3: Only the electrode name should be input.

%% Basic inputs
clear
str=pwd;
if ispc
    index_dir=strfind(str,'\main\main_3-high_automation_level-electrode');
elseif isunix
    index_dir=strfind(str,'/main/main_3-high_automation_level-electrode');
else
    disp('Platform not supported')
end
str_temp=str(1:index_dir(end)-1);
currentFolder = str_temp;
addpath(genpath(currentFolder))
clear currentFolder str_temp index_dir str

% ================================================== INPUT START ==================================================  


% ---------- NAME START ----------
% names of elctrode and filling fluid
name_electrode = 'graphiteAnode';
name_filler = 'DMC';

% curve name
curveName = 'curveRAreaContact';
% ---------- NAME   END ----------


% ==================================================  INPUT   END ================================================== 

% name of current collector
if strcmp(name_electrode(end-4:end),'Anode') && ~strcmp(name_electrode(end-6:end),'Cathode')
    name_currentCollector = 'copper';
    vFr_currentCollector = 11.8333/124;
elseif ~strcmp(name_electrode(end-4:end),'Anode') && strcmp(name_electrode(end-6:end),'Cathode')
    name_currentCollector = 'aluminium';
    vFr_currentCollector = 16.7667/146;
end
vFr_coating = 1 - vFr_currentCollector;

load tables statistics
currentCollector = statistics(name_currentCollector,:);
k_currentCollector = currentCollector.thermalConductivity;
rho_currentCollector = currentCollector.density;
cp_currentCollector = currentCollector.heatCapacity;


save  main_3_basic_inputs
%% k: ZSM_1
clear
load main_3_basic_inputs

% ---------- INPUT START ----------

% mode name for additive combination (conductive additive + binder)
modelAdditiveName = 'percolationModel,kc=0.3,vc=0.15,nExp=0.51';

% tortuosity mode
modeTortuosity = 1;

% volume fraction (active material) of part 2 of ZSM_1 in active material: a is in range of [0,1]
% volume fraction of down-part for disconnected part. c is in range of [0,1]
a = 0;  % a between 0 and 1
c = 0;  % c between 0 and 1 or 'automatic'
e = 0;  % e between 0 and 1
g = 0;  % g between 0 and 1
% ---------- INPUT   END ----------

% the effective thermal conductivity
tic;
keff_ZSM_1 = k_ZSM_1_electrode(...
    name_electrode,name_filler,curveName,...
    modelAdditiveName,modeTortuosity,a,c,e,g);        % LOCAL INPUTS 
toc


% in-plane & through-plane thermal conductivity
keff_ZSM_1_in_plane = k_parallelModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);
keff_ZSM_1_through_plane = k_seriesModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);