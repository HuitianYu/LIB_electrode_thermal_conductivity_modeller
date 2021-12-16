%% MAIN_2 Automation level 2: The name of of all from table statistics and volume fractions of solid materials should be input.

%% Basic inputs
clear
str=pwd;
if ispc
    index_dir=strfind(str,'\main\main_2-median_automation_level-names');
elseif isunix
    index_dir=strfind(str,'/main/main_2-median_automation_level-names');
else
    disp('Platform not supported')
end
str_temp=str(1:index_dir(end)-1);
currentFolder = str_temp;
addpath(genpath(currentFolder))
clear currentFolder str_temp index_dir str

% ================================================== INPUT START ================================================== 


% ---------- NAME START ----------
% names of different materials
name_activeMaterial = 'graphite';
name_conductiveAdditive = 'carbonBlack';
name_binder = 'PVDF';
name_filler = 'DMC';

% name of current collector
name_currentCollector = 'aluminium';

% curve name
curveName = 'curveRAreaContact';
% ---------- NAME   END ----------


% ---------- MODE START ----------
% fraction mode and porosity mode
ifMassFractionsMatrix = 1;                  % 0: using volume fractions, 1: using mass fractions   % INPUT FRACTION MODE
ifMassPorosity = 0;                         % 0: using volume porosity, 1: using mass porosity   % INPUT POROSITY MODE
% ---------- MODE   END ----------


% ---------- PROPORTION START ----------
% input fractions
inputFraction_activeMaterial = 0.923645100217249;
inputFraction_conductiveAdditive = 0.0260751982758095;

% input porosity
inputPorosity = 0.4838;
% ---------- PROPORTION   END ----------

% ---------- CURRENTCOLLECTOR START ----------

vFr_currentCollector = 22/76;
vFr_coating = 1 - vFr_currentCollector;

% ---------- CURRENTCOLLECTOR   END ----------

% ================================================== INPUT   END ================================================== 

[output_volumeFractionsMatrix,output_volumePorosity] = fractionsMatrix_xPorosity_transfer(...
    {name_activeMaterial;name_conductiveAdditive;name_binder},...
    [inputFraction_activeMaterial;inputFraction_conductiveAdditive],...
    name_filler,inputPorosity,....
    ifMassFractionsMatrix,ifMassPorosity,...
    0,0);

vFrMatrix_activeMaterial = output_volumeFractionsMatrix(1,1);
vFrMatrix_conductiveAdditive = output_volumeFractionsMatrix(2,1);
vFrMatrix_binder = 1 - vFrMatrix_activeMaterial - vFrMatrix_conductiveAdditive;

if vFrMatrix_binder < 0
    error('vFrMatrix_binder is negative. The sum of all fractions should be 1.')
end

porosity = output_volumePorosity;

[output_massFractionsMatrix,output_massPorosity] = fractionsMatrix_xPorosity_transfer(...
    {name_activeMaterial;name_conductiveAdditive;name_binder},...
    [inputFraction_activeMaterial;inputFraction_conductiveAdditive],...
    name_filler,inputPorosity,....
    ifMassFractionsMatrix,ifMassPorosity,...
    1,1);

mFrMatrix_activeMaterial = output_massFractionsMatrix(1,1);
mFrMatrix_conductiveAdditive = output_massFractionsMatrix(2,1);
mFrMatrix_binder = 1 - mFrMatrix_activeMaterial - mFrMatrix_conductiveAdditive;

if mFrMatrix_binder < 0
    error('mFrMatrix_binder is negative. The sum of all fractions should be 1.')
end

mass_porosity = output_massPorosity;



load tables statistics
currentCollector = statistics(name_currentCollector,:);
k_currentCollector = currentCollector.thermalConductivity;

save  main_2_basic_inputs

%% k: ZSM_1
clear
load main_2_basic_inputs

% ---------- INPUT START ----------

% mode name for additive combination (conductive additive + binder)
modelAdditiveName = 'MEM_1,f=3.2';

% tortuosity mode
modeTortuosity = 1;

% volume fraction (active material) of part 2 of ZSM_1 in active material: a is in range of [0,1]
% volume fraction of down-part for disconnected part. c is in range of [0,1]
a = (-0.025252 * porosity + 0.025705) * 1;  % a between 0 and 1
c = 0.013796 * exp(3.2251 * porosity);  % c between 0 and 1 or 'automatic'
e = 0;  % e between 0 and 1
g = 0;  % g between 0 and 1

% ---------- INPUT   END ----------

% the effective thermal conductivity    
tic;
keff_ZSM_1 = k_ZSM_1(...
    {name_activeMaterial;name_conductiveAdditive;name_binder},...
    [vFrMatrix_activeMaterial;vFrMatrix_conductiveAdditive],...
    name_filler,porosity,curveName,...
    modelAdditiveName,modeTortuosity,a,c,e,g);        % LOCAL INPUTS
toc

% in-plane & through-plane thermal conductivity
keff_ZSM_1_in_plane = k_parallelModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);
keff_ZSM_1_through_plane = k_seriesModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);
%% k: ZSM_1_a
clear
load main_2_basic_inputs

% ---------- INPUT START ----------

% mode name for additive combination (conductive additive + binder)
modelAdditiveName = 'MEM_1,f=3.2';

% tortuosity mode
modeTortuosity = 1;

% volume fraction (active material) of part 2 of ZSM_1 in active material: a is in range of [0,1]
% volume fraction of down-part for disconnected part. c is in range of [0,1]
a = (-0.025252 * porosity + 0.025705) * 1;  % a between 0 and 1
c = 0.013796 * exp(3.2251 * porosity);  % c between 0 and 1 or 'automatic'
e = 0;  % e between 0 and 1
g = 0;  % g between 0 and 1

% ---------- INPUT   END ----------

% the effective thermal conductivity    
tic;
keff_ZSM_1 = k_ZSM_1_a(...
    {name_activeMaterial;name_conductiveAdditive;name_binder},...
    [vFrMatrix_activeMaterial;vFrMatrix_conductiveAdditive],...
    name_filler,porosity,curveName,...
    modelAdditiveName,modeTortuosity,a,c,e,g);        % LOCAL INPUTS
toc

% in-plane & through-plane thermal conductivity
keff_ZSM_1_in_plane = k_parallelModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);
keff_ZSM_1_through_plane = k_seriesModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);

%% k: ZSM_1_polyAM
clear
load main_2_basic_inputs

% ---------- INPUT START ----------

% mode name for additive combination (conductive additive + binder)
modelAdditiveName = 'MEM_1,f=3.2';

% tortuosity mode
modeTortuosity = 1;

% thermal conductivities of the active materials and their ratio
names_activeMaterial = {'graphite';'LCO'};
ratios_activeMaterial = [0.8;0.2];
[ratios_activeMaterial,~] = fractionsMatrix_xPorosity_transfer(...
    names_activeMaterial,ratios_activeMaterial,...
    name_filler,inputPorosity,....
    ifMassFractionsMatrix,ifMassPorosity,...
    0,0);

% volume fraction (active material) of part 2 of ZSM_1 in active material: a is in range of [0,1]
% volume fraction of down-part for disconnected part. c is in range of [0,1]
a = (-0.025252 * porosity + 0.025705) * 1;  % a between 0 and 1
c = 0.013796 * exp(3.2251 * porosity);  % c between 0 and 1 or 'automatic'
e = 0;  % e between 0 and 1
g = 0;  % g between 0 and 1

% ---------- INPUT   END ----------

% the effective thermal conductivity    
tic;
keff_ZSM_1 = k_ZSM_1_polyAM(...
    [names_activeMaterial;name_conductiveAdditive;name_binder],...
    [vFrMatrix_activeMaterial;vFrMatrix_conductiveAdditive],...
    name_filler,porosity,curveName,...
    modelAdditiveName,modeTortuosity,a,c,e,g,ratios_activeMaterial);        % LOCAL INPUTS
toc

% in-plane & through-plane thermal conductivity
keff_ZSM_1_in_plane = k_parallelModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);
keff_ZSM_1_through_plane = k_seriesModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);

%% k: ZSM_1_a_polyAM
clear
load main_2_basic_inputs

% ---------- INPUT START ----------

% mode name for additive combination (conductive additive + binder)
modelAdditiveName = 'MEM_1,f=3.2';

% tortuosity mode
modeTortuosity = 1;

% thermal conductivities of the active materials and their ratio
names_activeMaterial = {'graphite';'LCO'};
ratios_activeMaterial = [0.8;0.2];
[ratios_activeMaterial,~] = fractionsMatrix_xPorosity_transfer(...
    names_activeMaterial,ratios_activeMaterial,...
    name_filler,inputPorosity,....
    ifMassFractionsMatrix,ifMassPorosity,...
    0,0);

% volume fraction (active material) of part 2 of ZSM_1 in active material: a is in range of [0,1]
% volume fraction of down-part for disconnected part. c is in range of [0,1]
a = (-0.025252 * porosity + 0.025705) * 1;  % a between 0 and 1
c = 0.013796 * exp(3.2251 * porosity);  % c between 0 and 1 or 'automatic'
e = 0;  % e between 0 and 1
g = 0;  % g between 0 and 1

% ---------- INPUT   END ----------

% the effective thermal conductivity    
tic;
keff_ZSM_1 = k_ZSM_1_a_polyAM(...
    [names_activeMaterial;name_conductiveAdditive;name_binder],...
    [vFrMatrix_activeMaterial;vFrMatrix_conductiveAdditive],...
    name_filler,porosity,curveName,...
    modelAdditiveName,modeTortuosity,a,c,e,g,ratios_activeMaterial);        % LOCAL INPUTS
toc

% in-plane & through-plane thermal conductivity
keff_ZSM_1_in_plane = k_parallelModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);
keff_ZSM_1_through_plane = k_seriesModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);

%% k: ZSM_1_addDistribution
clear
load main_2_basic_inputs

% ---------- INPUT START ----------

% mode name for additive combination (conductive additive + binder)
modelAdditiveName = 'MEM_1,f=3.2';

% tortuosity mode
modeTortuosity = 1;

% thermal conductivities of the active materials and their ratio
% distribution of additive system
addDistribution = 'linear';
addDisPar = 0.1;

% volume fraction (active material) of part 2 of ZSM_1 in active material: a is in range of [0,1]
% volume fraction of down-part for disconnected part. c is in range of [0,1]
a = (-0.025252 * porosity + 0.025705) * 1;  % a between 0 and 1
c = 0.013796 * exp(3.2251 * porosity);  % c between 0 and 1 or 'automatic'
e = 0;  % e between 0 and 1
g = 0;  % g between 0 and 1

% ---------- INPUT   END ----------

% the effective thermal conductivity    
tic;
keff_ZSM_1 = k_ZSM_1_addDistribution(...
    {name_activeMaterial;name_conductiveAdditive;name_binder},...
    [vFrMatrix_activeMaterial;vFrMatrix_conductiveAdditive],...
    name_filler,porosity,curveName,...
    modelAdditiveName,modeTortuosity,a,c,e,g,addDistribution,addDisPar);        % LOCAL INPUTS
toc

% in-plane & through-plane thermal conductivity
keff_ZSM_1_in_plane = k_parallelModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);
keff_ZSM_1_through_plane = k_seriesModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);


%% k: ZSM_1_a_addDistribution
clear
load main_2_basic_inputs

% ---------- INPUT START ----------

% mode name for additive combination (conductive additive + binder)
modelAdditiveName = 'MEM_1,f=3.2';

% tortuosity mode
modeTortuosity = 1;

% thermal conductivities of the active materials and their ratio
% distribution of additive system
addDistribution = 'linear';
addDisPar = 0.1;

% volume fraction (active material) of part 2 of ZSM_1 in active material: a is in range of [0,1]
% volume fraction of down-part for disconnected part. c is in range of [0,1]
a = (-0.025252 * porosity + 0.025705) * 1;  % a between 0 and 1
c = 0.013796 * exp(3.2251 * porosity);  % c between 0 and 1 or 'automatic'
e = 0;  % e between 0 and 1
g = 0;  % g between 0 and 1

% ---------- INPUT   END ----------

% the effective thermal conductivity    
tic;
keff_ZSM_1 = k_ZSM_1_a_addDistribution(...
    {name_activeMaterial;name_conductiveAdditive;name_binder},...
    [vFrMatrix_activeMaterial;vFrMatrix_conductiveAdditive],...
    name_filler,porosity,curveName,...
    modelAdditiveName,modeTortuosity,a,c,e,g,addDistribution,addDisPar);        % LOCAL INPUTS
toc

% in-plane & through-plane thermal conductivity
keff_ZSM_1_in_plane = k_parallelModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);
keff_ZSM_1_through_plane = k_seriesModel_calculator([keff_ZSM_1;k_currentCollector],vFr_coating,'none',0);
%% the effective thermal conductivity of composite out of conductive addtive and binder
clear
load main_2_basic_inputs

% ---------- INPUT START ----------

% mode name for additive combination (conductive additive + binder)
modelAdditiveName = 'MEM_1,f=3.2';

% ---------- INPUT   END ----------

% calculate the effective thermal conductivity
if vFrMatrix_binder + vFrMatrix_conductiveAdditive ~= 0
    
    vFrAdditive_conductiveAdditive =...
        vFrMatrix_conductiveAdditive /...
        (vFrMatrix_binder + vFrMatrix_conductiveAdditive);
    
    k_additive = k_model_out_of_name(...
        {name_binder},[],...
        name_filler,vFrAdditive_conductiveAdditive,...
        modelAdditiveName);        % LOCAL INPUTS
        
else
    error('The sum of volume fractions of binder and conductive additive is 0.')
end
