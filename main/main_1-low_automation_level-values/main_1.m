%% MAIN_1 Automation level 1: The thermal conductivities of all and volume fractions of solid materials should be input.

%% Basic inputs
clear
% Add paths
clear
str=pwd;
if ispc
    index_dir=strfind(str,'\main\main_1-low_automation_level-values');
elseif isunix
    index_dir=strfind(str,'/main/main_1-low_automation_level-values');
else
    disp('Platform not supported')
end
str_temp=str(1:index_dir(end)-1);
currentFolder = str_temp;
addpath(genpath(currentFolder))
clear currentFolder str_temp index_dir str

% ================================================== INPUT START ================================================== 


% ---------- THERMALCONDUCTIVITY START ----------
% thermal conductivities of solid components
k_activeMaterial = 4.3; % for more than 1 AM, this variable is not relavant
k_conductiveAdditive = 23.8488;
k_binder = 0.1965;
k_filler = 0.026;
k_currentCollector = 398;
% ---------- THERMALCONDUCTIVITY   END ----------


% ---------- PROPORTION START ----------
% volume fractions
vFrMatrix_activeMaterial = 0.9;
vFrMatrix_conductiveAdditive = 0.06;

% porosity
porosity = 0.5;

% ---------- PROPORTION   END ----------

% ---------- NAME START ----------
% curve name
curveName = 'curveRAreaContact';
% ---------- NAME   END ----------


% ---------- CURRENTCOLLECTOR START ----------

vFr_currentCollector = 11.8333 / 124;
vFr_coating = 1 - vFr_currentCollector;

% ---------- CURRENTCOLLECTOR   END ----------

% ================================================== INPUT   END ================================================== 

vFrMatrix_binder = 1 - vFrMatrix_activeMaterial - vFrMatrix_conductiveAdditive;

if vFrMatrix_binder < 0
    error('vFrMatrix_binder is negative. The sum of all fractions should be 1.')
end

save  main_1_basic_inputs


%% k: ZSM_1
clear
load main_1_basic_inputs

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
keff_ZSM_1 = k_ZSM_1_calculator(...
    [k_activeMaterial;k_conductiveAdditive;k_binder],...
    [vFrMatrix_activeMaterial;vFrMatrix_conductiveAdditive],...
    k_filler,porosity,curveName,...
    modelAdditiveName,modeTortuosity,a,c,e,g);        % LOCAL INPUTS
toc

% in-plane & through-plane thermal conductivity
keff_ZSM_1_in_plane = k_parallelModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);
keff_ZSM_1_through_plane = k_seriesModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);

%% k: ZSM_1_a
clear
load main_1_basic_inputs

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
keff_ZSM_1 = k_ZSM_1_a_calculator(...
    [k_activeMaterial;k_conductiveAdditive;k_binder],...
    [vFrMatrix_activeMaterial;vFrMatrix_conductiveAdditive],...
    k_filler,porosity,curveName,...
    modelAdditiveName,modeTortuosity,a,c,e,g);        % LOCAL INPUTS
toc

% in-plane & through-plane thermal conductivity
keff_ZSM_1_in_plane = k_parallelModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);
keff_ZSM_1_through_plane = k_seriesModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);

%% k: ZSM_1_polyAM
clear
load main_1_basic_inputs

% ---------- INPUT START ----------

% mode name for additive combination (conductive additive + binder)
modelAdditiveName = 'percolationModel,kc=0.3,vc=0.15,nExp=0.51';

% tortuosity mode
modeTortuosity = 1;

% thermal conductivities of the active materials and their ratio
ks_activeMaterial = [6;4.3];
ratios_activeMaterial = [0.8;0.2];

% volume fraction (active material) of part 2 of ZSM_1 in active material: a is in range of [0,1]
% volume fraction of down-part for disconnected part. c is in range of [0,1]
a = 0;  % a between 0 and 1
c = 0;  % c between 0 and 1 or 'automatic'
e = 0;  % e between 0 and 1
g = 0;  % g between 0 and 1

% ---------- INPUT   END ----------

% the effective thermal conductivity
tic;
keff_ZSM_1 = k_ZSM_1_polyAM_calculator(...
    [ks_activeMaterial(1:end,1);k_conductiveAdditive;k_binder],...
    [vFrMatrix_activeMaterial;vFrMatrix_conductiveAdditive],...
    k_filler,porosity,curveName,...
    modelAdditiveName,modeTortuosity,a,c,e,g,ratios_activeMaterial);        % LOCAL INPUTS
toc

% in-plane & through-plane thermal conductivity
keff_ZSM_1_in_plane = k_parallelModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);
keff_ZSM_1_through_plane = k_seriesModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);

%% k: ZSM_1_a_polyAM
clear
load main_1_basic_inputs

% ---------- INPUT START ----------

% mode name for additive combination (conductive additive + binder)
modelAdditiveName = 'percolationModel,kc=0.3,vc=0.15,nExp=0.51';

% tortuosity mode
modeTortuosity = 1;

% thermal conductivities of the active materials and their ratio
ks_activeMaterial = [6;4.3];
ratios_activeMaterial = [0.8;0.2];

% volume fraction (active material) of part 2 of ZSM_1 in active material: a is in range of [0,1]
% volume fraction of down-part for disconnected part. c is in range of [0,1]
a = 0;  % a between 0 and 1
c = 0;  % c between 0 and 1 or 'automatic'
e = 0;  % e between 0 and 1
g = 0;  % g between 0 and 1

% ---------- INPUT   END ----------

% the effective thermal conductivity
tic;
keff_ZSM_1 = k_ZSM_1_a_polyAM_calculator(...
    [ks_activeMaterial(1:end,1);k_conductiveAdditive;k_binder],...
    [vFrMatrix_activeMaterial;vFrMatrix_conductiveAdditive],...
    k_filler,porosity,curveName,...
    modelAdditiveName,modeTortuosity,a,c,e,g,ratios_activeMaterial);        % LOCAL INPUTS
toc

% in-plane & through-plane thermal conductivity
keff_ZSM_1_in_plane = k_parallelModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);
keff_ZSM_1_through_plane = k_seriesModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);

%% k: ZSM_1_distributionAdd
clear
load main_1_basic_inputs

% ---------- INPUT START ----------

% mode name for additive combination (conductive additive + binder)
modelAdditiveName = 'percolationModel,kc=0.3,vc=0.15,nExp=0.51';

% tortuosity mode
modeTortuosity = 1;

% distribution of additive system
addDistribution = 'linear';
addDisPar = 0.1;

% volume fraction (active material) of part 2 of ZSM_1 in active material: a is in range of [0,1]
% volume fraction of down-part for disconnected part. c is in range of [0,1]
a = 0;  % a between 0 and 1
c = 0;  % c between 0 and 1 or 'automatic'
e = 0;  % e between 0 and 1
g = 0;  % g between 0 and 1

% ---------- INPUT   END ----------

% the effective thermal conductivity
tic;
keff_ZSM_1 = k_ZSM_1_addDistribution_calculator(...
    [k_activeMaterial;k_conductiveAdditive;k_binder],...
    [vFrMatrix_activeMaterial;vFrMatrix_conductiveAdditive],...
    k_filler,porosity,curveName,...
    modelAdditiveName,modeTortuosity,a,c,e,g,addDistribution,addDisPar);        % LOCAL INPUTS
toc

% in-plane & through-plane thermal conductivity
keff_ZSM_1_in_plane = k_parallelModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);
keff_ZSM_1_through_plane = k_seriesModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);

%% k: ZSM_1_a_distributionAdd
clear
load main_1_basic_inputs

% ---------- INPUT START ----------

% mode name for additive combination (conductive additive + binder)
modelAdditiveName = 'percolationModel,kc=0.3,vc=0.15,nExp=0.51';

% tortuosity mode
modeTortuosity = 1;

% distribution of additive system
addDistribution = 'linear';
addDisPar = 0.1;

% volume fraction (active material) of part 2 of ZSM_1 in active material: a is in range of [0,1]
% volume fraction of down-part for disconnected part. c is in range of [0,1]
a = 0;  % a between 0 and 1
c = 0;  % c between 0 and 1 or 'automatic'
e = 0;  % e between 0 and 1
g = 0;  % g between 0 and 1

% ---------- INPUT   END ----------

% the effective thermal conductivity
tic;
keff_ZSM_1 = k_ZSM_1_a_addDistribution_calculator(...
    [k_activeMaterial;k_conductiveAdditive;k_binder],...
    [vFrMatrix_activeMaterial;vFrMatrix_conductiveAdditive],...
    k_filler,porosity,curveName,...
    modelAdditiveName,modeTortuosity,a,c,e,g,addDistribution,addDisPar);        % LOCAL INPUTS
toc

% in-plane & through-plane thermal conductivity
keff_ZSM_1_in_plane = k_parallelModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);
keff_ZSM_1_through_plane = k_seriesModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);


%% the effective thermal conductivity of composite out of conductive addtive and binder
clear
load main_1_basic_inputs

% ---------- INPUT START ----------

% mode name for additive combination (conductive additive + binder)
modelAdditiveName = 'percolationModel,kc=0.3,vc=0.15,nExp=0.51';

% ---------- INPUT   END ----------

% calculate the effective thermal conductivity
if vFrMatrix_binder + vFrMatrix_conductiveAdditive ~= 0
    
    vFrAdditive_conductiveAdditive =...
        vFrMatrix_conductiveAdditive /...
        (vFrMatrix_binder + vFrMatrix_conductiveAdditive);
    
    k_additive = k_model_out_of_name_calculator(...
        k_binder,[],...
        k_conductiveAdditive,vFrAdditive_conductiveAdditive,...
        modelAdditiveName);        % LOCAL INPUTS
        
else
    error('The sum of volume fractions of binder and conductive additive is 0.')
end

