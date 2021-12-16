clear
str=pwd;
if ispc
    index_dir=strfind(str,'\main\main_4-simulation');
elseif isunix
    index_dir=strfind(str,'/main/main_4-simulation');
else
    disp('Platform not supported')
end
str_temp=str(1:index_dir(end)-1);
currentFolder = str_temp;
addpath(genpath(currentFolder))
clear currentFolder str_temp index_dir str

%% Part 1: find the compostion of BMWi3 anode and cathode
clear
currentFolder = pwd;
fprintf('Start of Part 1...\n\n\n')
names_BMWi3Electrode = {'BMWi3Anode';'BMWi3Cathode'};
names_activeMaterial = {'graphite';'NMC'};
names_physicalQuantities = {'density';'heatCapacity'};
if ~exist('BMWi3','dir')
    mkdir('BMWi3')
end
if ispc
    if ~exist([currentFolder,'\','BMWi3\pictures'],'dir')
        mkdir('BMWi3\pictures')
    end
elseif isunix
    if ~exist([currentFolder,'/','BMWi3\pictures'],'dir')
        mkdir('BMWi3\pictures')
    end
else
    disp('Platform not supported')
end
if ispc
    if ~exist([currentFolder,'\','BMWi3\vector_graphs'],'dir')
        mkdir('BMWi3\vector_graphs')
    end
elseif isunix
    if ~exist([currentFolder,'/','BMWi3\vector_graphs'],'dir')
        mkdir('BMWi3\vector_graphs')
    end
else
    disp('Platform not supported')
end
% CALCULATION AND SAVE ---------------------------------------- START

    % BMWi3 anode and cathode
    for ii = 1 : size(names_BMWi3Electrode,1)
        fprintf(['Start to calculate mass fractions of matrix for ',names_BMWi3Electrode{ii,1},'...\n'])
        eval(['[~,~,massFractionsMatrix_',names_BMWi3Electrode{ii,1},',~,~] =  plot_y_vs_x_electrode_compositions_combined(',...
              '{''',names_activeMaterial{ii,1},''';''carbonBlack'';''PVDF''},''automatic'',''air'',0,',...
              '''',names_BMWi3Electrode{ii,1},''',''temperature'',{''',...
              names_physicalQuantities{1,1},''';''',names_physicalQuantities{2,1},'''},',...
              '[10,40],[0,6],500,25);'])
        fprintf(['End of calculation of mass fractions of matrix for ',names_BMWi3Electrode{ii,1},'...\n'])
    end
    clear ii
    
    % save the compositions
    str = 'save massFractionsMatrix_BMWi3Electrodes';
    for ii = 1 : size(names_BMWi3Electrode,1)
        strlength_str = strlength(str);
        str = insertAfter(str,strlength_str,[' massFractionsMatrix_',names_BMWi3Electrode{ii,1}]);
    end
    clear ii
    eval(str)
    clear str
% CALCULATION AND SAVE----------------------------------------   END

% PLOT AND SAVE ---------------------------------------- START
    % BMWi3 anode - density
    for ii = 1 : size(names_BMWi3Electrode,1)
        fprintf(['Start to plot for ',names_BMWi3Electrode{ii,1},'...\n'])
        for jj = 1 : size(names_physicalQuantities,1)
            fprintf(['Start to plot for ',names_physicalQuantities{jj,1},'...\n'])
                eval(['plot_y_vs_x_electrode_compositions(',...
                      '{''',names_activeMaterial{ii,1},''';''carbonBlack'';''PVDF''},massFractionsMatrix_',...
                      names_BMWi3Electrode{ii,1},',''air'',0,''',...
                      names_BMWi3Electrode{ii,1},''',''temperature'',''',names_physicalQuantities{jj,1},''',',...
                      '[10,40],[0,6],500,25,''plot'')'])
                if ispc
                    eval(['saveas(gcf,''BMWi3\',names_BMWi3Electrode{ii,1},'_',names_physicalQuantities{jj,1},''',''fig'')'])
                    eval(['saveas(gcf,''BMWi3\pictures\',names_BMWi3Electrode{ii,1},'_',names_physicalQuantities{jj,1},''',''png'')'])
                    eval(['saveas(gcf,''BMWi3\vector_graphs\',names_BMWi3Electrode{ii,1},'_',names_physicalQuantities{jj,1},''',''epsc'')'])
                    try
                        eval(['saveas(gcf,''BMWi3\vector_graphs\',names_BMWi3Electrode{ii,1},'_',names_physicalQuantities{jj,1},''',''emf'')'])
                    catch
                        disp('emf not possible')
                    end
                elseif isunix
                    eval(['saveas(gcf,''BMWi3/',names_BMWi3Electrode{ii,1},'_',names_physicalQuantities{jj,1},''',''fig'')'])
                    eval(['saveas(gcf,''BMWi3/pictures/',names_BMWi3Electrode{ii,1},'_',names_physicalQuantities{jj,1},''',''png'')'])
                    eval(['saveas(gcf,''BMWi3/vector_graphs/',names_BMWi3Electrode{ii,1},'_',names_physicalQuantities{jj,1},''',''epsc'')'])
                    try
                        eval(['saveas(gcf,''BMWi3/vector_graphs/',names_BMWi3Electrode{ii,1},'_',names_physicalQuantities{jj,1},''',''emf'')'])
                    catch
                        disp('emf not possible')
                    end
                else
                    disp('Platform not supported')
                end
                close(figure(gcf))
            fprintf(['End of plot for ',names_physicalQuantities{jj,1},'...\n'])
        end
        clear jj
        fprintf(['End of plot plot for ',names_BMWi3Electrode{ii,1},'...\n'])
    end
    clear ii
fprintf('End of Part 1.\n\n\n')
clear currentFolder
% PLOT AND SAVE ----------------------------------------   END

%% Part2: Models of thermal conductivity with different influence factors
clear
currentFolder = pwd;
fprintf('Start of Part 2...\n\n\n')
load tables electrode statistics
load massFractionsMatrix_BMWi3Electrodes

% -------------------------------------------------- INPUT START --------------------------------------------------
% 1. electrode: TO FILL
name_electrode = {'graphiteAnode';...
                    %'NMCCathode';'LCOCathode';...
                    };               % ii
% 2. filler/fluid: TO FILL
name_filler = {
                %'air';'He';...
                'CO2';...
                %'LP30';'LP50';...
                };                             % jj
    % 2.2 corresponding cell vector for titles: TO CHECK
    titleName_filler = {...
                        %'air';'He';...
                        'CO_{2}';...
                        %'LP30';'LP50';...
                        };                 % jj: It should correspond name_filler
        % =================================== NOT TO FILL BEGIN ===================================
        if size(name_filler,1) > size(titleName_filler,1)
            error('The dimension of name_filler cannot be bigger than that of titleName_filler.')
        end
        % =================================== NOT TO FILL   END ===================================
% 3. mass fraction ratio of conductive additive and binder: TO FILL
ratio_conductiveAdditive_binder = [...
                                    1/1;1/2;1/3;1/4;1/5;2/1;...
                                    ];                % ll
% 4. mass fraction of active material: TO FILL
massFraction_activeMaterial = [...
                                0.8;0.85;0.9;0.92;0.94;0.96;0.98;1;...
                                ];         % hh
% 5. additional compositions: TO FILL (optional)
massFractions_matrix_additional = {...
                                    massFractionsMatrix_BMWi3Cathode;...    % BMWi3Cathode
                                    massFractionsMatrix_BMWi3Anode;...      % BMWi3Anode
                                    [0.918;0.028];...                       % common composition for anode
                                    [0.9;0.06];...                          % common composition for cathode
                                    [0.9;0.05];...                          % common composition for cathode
                                   };
% 6. models: TO FILL
names_model = {'parallelModel';...                                          % nn
                'seriesModel';'krischerModel,a=0.03';...     
                'geometricModel';'EMT,f=6';...
                'RNM_1,modeTortuosity=1,a=0.03';'RNM_2,modeTortuosity=1,a=0.001';
                'ZSM_1,curveName=''curveRAreaContact'',modelAdditiveName=''percolationModel,kc=0.3,vc=0.15,nExp=0.51'',modeTortuosity=1,a=0,c=0,e=0,g=0';...
                'ZSM_1,curveName=''curveRAreaContact'',modelAdditiveName=''percolationModel,kc=0.3,vc=0.15,nExp=0.51'',modeTortuosity=2,a=0,c=0,e=0,g=0';...
                'ZSM_1,curveName=''curveRAreaContact'',modelAdditiveName=''percolationModel,kc=0.3,vc=0.15,nExp=0.51'',modeTortuosity=1,a=0,c=''automatic'',e=0,g=0';...
                'ZSM_1,curveName=''curveRAreaContact'',modelAdditiveName=''percolationModel,kc=0.3,vc=0.15,nExp=0.51'',modeTortuosity=2,a=0,c=''automatic'',e=0,g=0';...
                'ZSM_1,curveName=''curveRAreaContact'',modelAdditiveName=''percolationModel,kc=0.3,vc=0.15,nExp=0.51'',modeTortuosity=1,a=0,c=0,e=0.5,g=0';...
                'ZSM_1,curveName=''curveRAreaContact'',modelAdditiveName=''percolationModel,kc=0.3,vc=0.15,nExp=0.51'',modeTortuosity=2,a=0,c=0,e=0.5,g=0';...
                'ZSM_1,curveName=''curveRAreaContact'',modelAdditiveName=''percolationModel,kc=0.3,vc=0.15,nExp=0.51'',modeTortuosity=1,a=0,c=0,e=0,g=0.3';...
                'ZSM_1,curveName=''curveRAreaContact'',modelAdditiveName=''percolationModel,kc=0.3,vc=0.15,nExp=0.51'',modeTortuosity=2,a=0,c=0,e=0,g=0.3';...
                'ZSM_1,curveName=''curveRAreaContact'',modelAdditiveName=''MEM_1,f=3.2'',modeTortuosity=1,a=0,c=0,e=0,g=0';...
                'ZSM_1,curveName=''curveRAreaContact'',modelAdditiveName=''MEM_1,f=3.2'',modeTortuosity=2,a=0,c=0,e=0,g=0';...
                };
            % 6.2 corresponding cell vector for legends: TO CHECK
            legendNames_model = {   'parallel';...
                        'series';'krischer,a=0.03';...
                        'geometric mean';'EMT,f=6';...
                        'RNM 1,tau 1,a=0.03';'RNM 2,tau 1,a=0.001';...
                        'ZBS 1(percolation),tau 1'; 'ZBS 1(percolation),tau 2';...
                        'ZBS 2(percolation),tau 1'; 'ZBS 2(percolation),tau 2';...
                        'ZBS 3(percolation),tau 1'; 'ZBS 3(percolation),tau 2';...
                        'ZBS 4(percolation),tau 1'; 'ZBS 4(percolation),tau 2';...
                        'ZBS 1(MEM,f=3.2),tau 1';   'ZBS 1(MEM,f=3.2),tau 2';...
                        };
                % =================================== NOT TO FILL BEGIN ===================================
                if size(names_model,1) > size(legendNames_model,1)
                    error('The dimension of names_model cannot be bigger than that of legendNames_model.')
                end
                % =================================== NOT TO FILL   END ===================================
            % 6.3 corresponding cell vector for file names: TO CHECK
            fileNames_model = {   'par';...
                        'ser';'kris';...
                        'geo';'EMT';...
                        'RNM_1_1';'RNM_2_1';
                        'ZBS_1_1_P'; 'ZBS_1_2_P';...
                        'ZBS_2_1_P'; 'ZBS_2_2_P';...
                        'ZBS_3_1_P'; 'ZBS_3_2_P';...
                        'ZBS_4_1_P'; 'ZBS_4_2_P';...
                        'ZBS_1_1_M';   'ZBS_1_2_M';...
                        };
                % =================================== NOT TO FILL BEGIN ===================================
                if size(names_model,1) > size(fileNames_model,1)
                    error('The dimension of names_model cannot be bigger than that of fileNames_model.')
                end
                % =================================== NOT TO FILL   END ===================================

% -------------------------------------------------- INPUT   END --------------------------------------------------

% ---------------------------------------- POSTPROCESSING OF INPUT BEGIN ----------------------------------------
name_currentCollector = cell(size(name_electrode,1),1);
currentCollector = cell(size(name_electrode,1),1);
volumeFraction_currentCollector = zeros(size(name_electrode,1),1);
for ii = 1 : size(name_electrode,1)
    if strcmp(name_electrode{ii,1}(end-4:end),'Anode') && ~strcmp(name_electrode{ii,1}(end-6:end),'Cathode')
        name_currentCollector{ii,1} = 'copper';
        currentCollector{ii,1} = statistics(name_currentCollector{ii,1},:);
        volumeFraction_currentCollector(ii,1) = 11.8333/124;
    elseif ~strcmp(name_electrode{ii,1}(end-4:end),'Anode') && strcmp(name_electrode{ii,1}(end-6:end),'Cathode')
        name_currentCollector{ii,1} = 'aluminium';
        currentCollector{ii,1} = statistics(name_currentCollector{ii,1},:);
        volumeFraction_currentCollector(ii,1) = 16.7667/146;
    end
end 
clear ii


fileNames_model = fileNames_model(1:size(names_model,1),1);
lineStyles = {'-';'--';'-.';':'};
colors = {  [106,90,205]/255;   [255,69,0]/255;     [56,94,15]/255;     [0,255,127]/255;    [128,42,42]/255;...
            [255,215,0]/255;    [250,128,114]/255;  [30,144,255]/255;   [255,0,255]/255;    [50,205,50]/255;...
            [65,105,255]/255;   [227,23,13]/255;    [12,23,70]/255;     [115,74,18]/255; 	[176,48,96]/255};
        
massFractions_matrix_all = cell(size(massFraction_activeMaterial,1) * size(ratio_conductiveAdditive_binder,1) + size(massFractions_matrix_additional,1),1);    % pp
for ll = 1 : size(ratio_conductiveAdditive_binder,1)
    for hh = 1 : size(massFraction_activeMaterial,1)
        massFractions_matrix_all{(ll - 1) * size(massFraction_activeMaterial,1) + hh,1} = [massFraction_activeMaterial(hh,1);...
                              (1 - massFraction_activeMaterial(hh,1)) * ratio_conductiveAdditive_binder(ll,1) /...
                              (ratio_conductiveAdditive_binder(ll,1) + 1)];
    end
    clear hh
end
clear ll

for ll = 1 : size(massFractions_matrix_additional,1)
    massFractions_matrix_all{size(ratio_conductiveAdditive_binder,1) * size(massFraction_activeMaterial,1) + ll,1} = massFractions_matrix_additional{ll,1};
end
clear ll

% ---------------------------------------- POSTPROCESSING OF INPUT   END ----------------------------------------

% --------------------------------------------- CREATE FOLDER BEGIN ---------------------------------------------

if ispc
    if ~exist([currentFolder,'\','models'],'dir')
        mkdir('models')
    end
elseif isunix
    if ~exist([currentFolder,'/','models'],'dir')
        mkdir('models')
    end
else
    disp('Platform not supported')
end

% --------------------------------------------- CREATE FOLDER   END ---------------------------------------------

% -------------------------------------------------- Core PART BEGIN --------------------------------------------------

for ii = 1 : 1 : size(name_electrode,1)
    fprintf([num2str(ii),'.',' ','For ',name_electrode{ii,1},':\n\n'])
    if ispc
        if ~exist([currentFolder,'\','models\',name_electrode{ii,1}],'dir')
            mkdir(['models\',name_electrode{ii,1}])
        end
    elseif isunix
        if ~exist([currentFolder,'/','models/',name_electrode{ii,1}],'dir')
            mkdir(['models/',name_electrode{ii,1}])
        end
    else
        disp('Platform not supported')
    end
    % load names of matrix materials from electrode
    thisElectrode = electrode(name_electrode{ii,1},:);
    names_matrix = cell(3,1);
    matrix = cell(3,1);
    for kk = 1 : 3
        names_matrix{kk,1} =  thisElectrode{1,kk}{1,1};
        matrix{kk,1} = statistics(names_matrix{kk,1},:);
    end
    clear kk
    for jj = 1 : size(name_filler,1)
        fprintf([num2str(ii),'.',num2str(jj),'.',' ','For ',name_filler{jj,1},':\n\n'])
        if ispc
            if ~exist([currentFolder,'\','models\',name_electrode{ii,1},'\',name_filler{jj,1}],'dir')
                mkdir(['models\',name_electrode{ii,1},'\',name_filler{jj,1}])
            end
        elseif isunix
            if ~exist([currentFolder,'/','models/',name_electrode{ii,1},'/',name_filler{jj,1}],'dir')
                mkdir(['models/',name_electrode{ii,1},'/',name_filler{jj,1}])
            end
        else
            disp('Platform not supported')
        end
        for pp = 1 : size(massFractions_matrix_all,1)
            massFractions_matrix = massFractions_matrix_all{pp,1};
            % convert mass fraction to volume fraction
            [volumeFractions_matrix,~] = fractionsMatrix_xPorosity_transfer(...
                    names_matrix,massFractions_matrix,'none',0,1,0,0,0);
            % calculate the last element of fraction
            massFractions_matrix(3,1) = 1 - sum(massFractions_matrix(1:2,1));
            volumeFractions_matrix(3,1) = 1 - sum(volumeFractions_matrix(1:2,1));
            % core part of file name
            name_file_massFraction = '';
            name_file_volumeFraction = '';

            for kk = 1 : 3
                strlength_name_file_massFraction = strlength(name_file_massFraction);
                name_file_massFraction = insertAfter(name_file_massFraction,strlength_name_file_massFraction,...
                                            [names_matrix{kk,1},nonNegativeDecimal_to_string(massFractions_matrix(kk,1) * 100)]);
                strlength_name_file_volumeFraction = strlength(name_file_volumeFraction);
                name_file_volumeFraction = insertAfter(name_file_volumeFraction,strlength_name_file_volumeFraction,...
                                            [names_matrix{kk,1},nonNegativeDecimal_to_string(volumeFractions_matrix(kk,1) * 100)]);                                         
            end
            clear kk
            fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'.',' ','For ',name_file_massFraction,':\n\n'])
            if ispc
                dirName = ['models\',name_electrode{ii,1},'\',name_filler{jj,1},'\',name_file_massFraction];
                if ~exist([currentFolder,'\',dirName],'dir')
                    mkdir(dirName)
                end
            elseif isunix
                dirName = ['models/',name_electrode{ii,1},'/',name_filler{jj,1},'/',name_file_massFraction];
                if ~exist([currentFolder,'/',dirName],'dir')
                    mkdir(dirName)
                end
            else
                disp('Platform not supported')
            end
            if ispc
                if ~exist([currentFolder,'\',dirName,'\pictures'],'dir')
                    mkdir([dirName,'\pictures'])
                end
            elseif isunix
                if ~exist([currentFolder,'/',dirName,'/pictures'],'dir')
                    mkdir([dirName,'/pictures'])
                end
            else
                disp('Platform not supported')
            end
            if ispc
                if ~exist([currentFolder,'\',dirName,'\vector_graphs'],'dir')
                    mkdir([dirName,'\vector_graphs'])
                end
            elseif isunix
                if ~exist([currentFolder,'/',dirName,'/vector_graphs'],'dir')
                    mkdir([dirName,'/vector_graphs'])
                end
            else
                disp('Platform not supported')
            end
            if ispc
                if ~exist([currentFolder,'\',dirName,'\tables'],'dir')
                    mkdir([dirName,'\tables'])
                end
            elseif isunix
                if ~exist([currentFolder,'/',dirName,'/tables'],'dir')
                    mkdir([dirName,'/tables'])
                end
            else
                disp('Platform not supported')
            end
            strlength_name_file_massFraction = strlength(name_file_massFraction);
            clear strlength_name_file_volumeFraction strlength_name_file_massFraction kk
            
            % temperature dependence of density and heat capacity
            if strcmp(name_electrode{ii,1}(end - 4:end),'Anode')
                name_electrode_compare = 'BMWi3Anode';
            elseif strcmp(name_electrode{ii,1}(end - 6:end),'Cathode')
                name_electrode_compare = 'BMWi3Cathode';
            end
            name_yPhysicalQuantities = {'density';'heatCapacity'};
            titleNames_yPhysicalQuantities = {'rho';'cp'};
            for mm = 1 : size(name_yPhysicalQuantities,1)
                try
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-1-',num2str(mm),'.',' ','Start to plot temperature dependence of ',name_yPhysicalQuantities{mm,1},'...\n\n'])
                    plot_y_vs_x_electrode_compositions(...
                        names_matrix,massFractions_matrix,name_filler{jj,1},0,name_electrode_compare,...
                        'temperature',name_yPhysicalQuantities{mm,1},[10,40],[0,6],500,25,'plot');
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-1-',num2str(mm),'.',' ','End of plot temperature dependence of ',name_yPhysicalQuantities{mm,1},'...\n\n'])  
                catch
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-1-',num2str(mm),'.',' ','Failed plot temperature dependence of ',name_yPhysicalQuantities{mm,1},'...\n\n'])  
                end
                if ispc
                    eval(['saveas(gcf,''',dirName,'\',name_file_massFraction,'_',name_filler{jj,1},'_','t_',titleNames_yPhysicalQuantities{mm,1},''',''fig'')'])
                    eval(['saveas(gcf,''',dirName,'\pictures\',name_file_massFraction,'_',name_filler{jj,1},'_','t_',titleNames_yPhysicalQuantities{mm,1},''',''png'')'])
                    eval(['saveas(gcf,''',dirName,'\vector_graphs\',name_file_massFraction,'_',name_filler{jj,1},'_','t_',titleNames_yPhysicalQuantities{mm,1},''',''epsc'')'])
                    try
                        eval(['saveas(gcf,''',dirName,'\vector_graphs\',name_file_massFraction,'_',name_filler{jj,1},'_','t_',titleNames_yPhysicalQuantities{mm,1},''',''emf'')'])
                    catch
                        disp('emf not possible')
                    end
                elseif isunix
                    eval(['saveas(gcf,''',dirName,'/',name_file_massFraction,'_',name_filler{jj,1},'_','t_',titleNames_yPhysicalQuantities{mm,1},''',''fig'')'])
                    eval(['saveas(gcf,''',dirName,'/pictures/',name_file_massFraction,'_',name_filler{jj,1},'_','t_',titleNames_yPhysicalQuantities{mm,1},''',''png'')'])
                    eval(['saveas(gcf,''',dirName,'/vector_graphs/',name_file_massFraction,'_',name_filler{jj,1},'_','t_',titleNames_yPhysicalQuantities{mm,1},''',''epsc'')'])
                    try
                        eval(['saveas(gcf,''',dirName,'/vector_graphs/',name_file_massFraction,'_',name_filler{jj,1},'_','t_',titleNames_yPhysicalQuantities{mm,1},''',''emf'')'])
                    catch
                        disp('emf not possible')
                    end
                else
                    disp('Platform not supported')
                end
                close(figure(gcf))
                clear fig h              
            end
            clear mm
            clear nameYPhysicalQuantities name_electrode_compare
            % density and heat capacity
                % calculate points 
                M = 1000;
                x = linspace(0,1,M)';
                mass_x = zeros(M,1);
                for mm = 1 : M
                [~,mass_x(mm,1)] = fractionsMatrix_xPorosity_transfer(...
                             names_matrix,massFractions_matrix,name_filler{jj,1},x(mm,1),1,0,0,1);
                end
                clear mm
                f_densityCoating = @(x) averageDensity(names_matrix,volumeFractions_matrix,name_filler{jj,1},x);
                y_densityCoating = arrayfun(f_densityCoating,x);
                y_densityAverage = volumeFraction_currentCollector(ii,1) * y_densityCoating + (1 - volumeFraction_currentCollector(ii,1)) * currentCollector{ii,1}.density;
                f_heatCapacityCoating = @(mass_x) averageHeatCapacity(names_matrix,massFractions_matrix,name_filler{jj,1},mass_x);
                y_heatCapacityCoating = arrayfun(f_heatCapacityCoating,mass_x);
                massFraction_currentCollector = currentCollector{ii,1}.density * volumeFraction_currentCollector(ii,1) ./ y_densityAverage;
                y_heatCapacityAverage = massFraction_currentCollector .* y_heatCapacityCoating  + (1 - massFraction_currentCollector) * currentCollector{ii,1}.heatCapacity;
                % plot density
                try
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-2-1.',' ','Start to plot density...\n\n'])
                    fig = figure;
                    set(fig,'Unit','normalized','Position',[0.1,0.1,0.35,0.65])
                    hold on
                    plot(x,y_densityCoating,'LineStyle','-','LineWidth',1.5)
                    plot(x,y_densityAverage,'LineStyle','-','LineWidth',1.5)
                    hold off
                    grid on
                    xlabel('\phi / -')
                    ylabel('\rho / g/cm^3')
                    legend({['coating (without ',name_currentCollector{ii,1},')'];...
                            ['whole electrode (with ',name_currentCollector{ii,1},')']})
                    title({ 'density against porosity';...
                            [' without/with ',name_currentCollector{ii,1},' (',num2str(round(volumeFraction_currentCollector(ii,1),4) * 100),' vol.%)'];...
                            [  'for ',thisElectrode.name{1,1},' with ',titleName_filler{jj,1}];...
                            ['(',   matrix{1,1}.name{1,1},' [',num2str(round(massFractions_matrix(1,1),4) * 100),' wt.%], '...
                                    matrix{2,1}.name{1,1},' [',num2str(round(massFractions_matrix(2,1),4) * 100),' wt.%], '...
                                    matrix{3,1}.name{1,1},' [',num2str(100 - 100 * sum(round(massFractions_matrix(1:2,1),4))),' wt.%]',')']})
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-2-1.',' ','End of plot of density.\n\n'])
                catch
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-2-1.',' ','Failed to plot of density.\n\n'])
                end
                if ispc
                    eval(['saveas(gcf,''',dirName,'\',name_file_massFraction,'_',name_filler{jj,1},'_','rho',''',''fig'')'])
                    eval(['saveas(gcf,''',dirName,'\pictures\',name_file_massFraction,'_',name_filler{jj,1},'_','rho',''',''png'')'])
                    eval(['saveas(gcf,''',dirName,'\vector_graphs\',name_file_massFraction,'_',name_filler{jj,1},'_','rho',''',''epsc'')'])
                    try
                        eval(['saveas(gcf,''',dirName,'\vector_graphs\',name_file_massFraction,'_',name_filler{jj,1},'_','rho',''',''emf'')'])
                    catch
                        disp('emf not possible')
                    end
                elseif isunix
                    eval(['saveas(gcf,''',dirName,'/',name_file_massFraction,'_',name_filler{jj,1},'_','rho',''',''fig'')'])
                    eval(['saveas(gcf,''',dirName,'/pictures/',name_file_massFraction,'_',name_filler{jj,1},'_','rho',''',''png'')'])
                    eval(['saveas(gcf,''',dirName,'/vector_graphs/',name_file_massFraction,'_',name_filler{jj,1},'_','rho',''',''epsc'')'])
                    try
                        eval(['saveas(gcf,''',dirName,'/vector_graphs/',name_file_massFraction,'_',name_filler{jj,1},'_','rho',''',''emf'')'])
                    catch
                        disp('emf not possible')
                    end
                else
                    disp('Platform not supported')
                end
                close(figure(gcf))
                clear fig

                % plot heat capacity
                try
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-2-2.',' ','Start to plot heat capacity...\n\n'])
                    fig = figure;
                    set(fig,'Unit','normalized','Position',[0.1,0.1,0.35,0.65])
                    hold on
                    plot(x,y_heatCapacityCoating,'LineStyle','-','LineWidth',1.5)
                    plot(x,y_heatCapacityAverage,'LineStyle','-','LineWidth',1.5)
                    hold off
                    grid on
                    xlabel('\phi / -')
                    ylabel('c_{P} / J/(g K)')
                    legend({['coating (without ',name_currentCollector{ii,1},')'];...
                            ['whole electrode (with ',name_currentCollector{ii,1},')']})
                    title({ 'heat capacity against porosity';...
                            [' without/with ',name_currentCollector{ii,1},' (',num2str(round(volumeFraction_currentCollector(ii,1),4) * 100),' vol.%)'];...
                            [  'for ',thisElectrode.name{1,1},' with ',titleName_filler{jj,1}];...
                            ['(',   matrix{1,1}.name{1,1},' [',num2str(round(massFractions_matrix(1,1),4) * 100),' wt.%], '...
                                    matrix{2,1}.name{1,1},' [',num2str(round(massFractions_matrix(2,1),4) * 100),' wt.%], '...
                                    matrix{3,1}.name{1,1},' [',num2str(100 - 100 * sum(round(massFractions_matrix(1:2,1),4))),' wt.%]',')']})
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-2-2.',' ','End of plot of heat capacity.\n\n'])
                catch
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-2-2.',' ','Failed to plot of heat capacity.\n\n'])
                end
                if ispc
                    eval(['saveas(gcf,''',dirName,'\',name_file_massFraction,'_',name_filler{jj,1},'_','cp',''',''fig'')'])
                    eval(['saveas(gcf,''',dirName,'\pictures\',name_file_massFraction,'_',name_filler{jj,1},'_','cp',''',''png'')'])
                    eval(['saveas(gcf,''',dirName,'\vector_graphs\',name_file_massFraction,'_',name_filler{jj,1},'_','cp',''',''epsc'')'])
                    try
                        eval(['saveas(gcf,''',dirName,'\vector_graphs\',name_file_massFraction,'_',name_filler{jj,1},'_','cp',''',''emf'')'])
                    catch
                        disp('emf not possible')
                    end
                elseif isunix
                    eval(['saveas(gcf,''',dirName,'/',name_file_massFraction,'_',name_filler{jj,1},'_','cp',''',''fig'')'])
                    eval(['saveas(gcf,''',dirName,'/pictures/',name_file_massFraction,'_',name_filler{jj,1},'_','cp',''',''png'')'])
                    eval(['saveas(gcf,''',dirName,'/vector_graphs/',name_file_massFraction,'_',name_filler{jj,1},'_','cp',''',''epsc'')'])
                    try
                        eval(['saveas(gcf,''',dirName,'/vector_graphs/',name_file_massFraction,'_',name_filler{jj,1},'_','cp',''',''emf'')'])
                    catch
                        disp('emf not possible')
                    end
                else
                    disp('Platform not supported')
                end
                close(figure(gcf))
                clear fig
                clear y_heatCapacityAverage y_heatCapacityCoating f_heatCapacityCoating y_densityAverage y_densityCoating f_densityCoating mass_x x M

            % thermal conductivity and in-plane, through-plane thermal conductivity
                fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3.',' ','Start of thermal conductivity...\n\n'])
                x = cell(1,size(names_model,1));
                f_thermalConductivity = cell(size(names_model,1),1);
                y_thermalConductivity = cell(1,size(names_model,1));
                y_thermalConductivity_inPlane = cell(1,size(names_model,1));
                y_thermalConductivity_throughPlane = cell(1,size(names_model,1));
                legend_thermalConductivity = cell(size(names_model,1),1);
                % generate the function for calcualting the effective thermal conductivity
                % find the execute xMin and xMax using try...catch...structure
                for nn = 1 : size(names_model,1)
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-0.',num2str(nn),'.',' ','Start to generate the function for ',legendNames_model{nn,1},'...\n\n'])
                    f_thermalConductivity{nn,1} = @(x) k_model_out_of_name(...
                        names_matrix,volumeFractions_matrix,name_filler{jj,1},x,names_model{nn,1});
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-0.',num2str(nn),'.',' ','End of generating the function for ',legendNames_model{nn,1},'...\n\n'])
                end
                clear nn

                % thermal conductivity
                fig = figure;
                set(fig,'Unit','normalized','Position',[0.1,0.1,0.35,0.65])
                hold on
                fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-1.',' ','Start to plot effective thermal conductivity...\n\n'])
                nZSM = 0;
                for nn = 1 : size(names_model,1)
                    try
                    % calculation
                        fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-1.',num2str(nn),'.',' ','Start to calculate the effective thermal conductivity for ',legendNames_model{nn,1},'...\n\n'])
                        if strcmp(legendNames_model{nn,1}(1:5),'ZBS 1') || strcmp(legendNames_model{nn,1}(1:5),'ZBS 3') || strcmp(legendNames_model{nn,1}(1:5),'ZBS 4')
                            deltaN = 0.01;
                        elseif strcmp(legendNames_model{nn,1}(1:5),'ZBS 2')
                            deltaN = 0.01;
                        else
                            deltaN = 0.001;      
                        end
                        x{1,nn} = (0:deltaN:1)';
                        for oo = 1:(1/deltaN+1)
                            try
                                y_thermalConductivity{1,nn}(oo,1) = f_thermalConductivity{nn,1}(x{1,nn}(oo,1));
                            catch
                                y_thermalConductivity{1,nn}(oo,1) = NaN;
                                fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-1.',num2str(nn),'.',' ','Error at x = ',num2str(x{1,nn}(oo,1)),' for ',legendNames_model{nn,1},'.\n\n'])
                            end
                        end  
                        clear deltaN
                        %y_thermalConductivity{1,nn} = arrayfun(f_thermalConductivity{nn,1},x{1,nn});
                        fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-1.',num2str(nn),'.',' ','End of Calculation of the effective thermal conductivity for ',legendNames_model{nn,1},'.\n\n'])
                    % plot
                        fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-1.',num2str(nn),'.',' ','Start to plot the effective thermal conductivity for ',legendNames_model{nn,1},'...\n\n'])
                        plot(x{1,nn},y_thermalConductivity{1,nn},'LineWidth',1.5,'LineStyle',lineStyles{mod(nn - 1,size(lineStyles,1)) + 1,1},...
                            'Color',colors{mod(nn - 1,size(colors,1)) + 1,1})
                        fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-1.',num2str(nn),'.',' ','End of plot of the effective thermal conductivity for ',legendNames_model{nn,1},'.\n\n'])
                        legend_thermalConductivity{nn,1} = legendNames_model{nn,1};
                    catch
                        fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-1.',num2str(nn),'.',' ','Failed to plot the effective thermal conductivity for ',legendNames_model{nn,1},'...\n\n'])
                        continue
                    end
                    if strcmp(legendNames_model{nn,1}(1:3),'ZBS')
                       nZSM = nZSM + 1; 
                    end
                end
                clear nn
                hold off
                grid on
                legend_thermalConductivity(cellfun(@isempty,legend_thermalConductivity)) = [];
                legend(legend_thermalConductivity)
                title({ 'effective thermal conductivity against porosity';...
                        [' without ',name_currentCollector{ii,1},];...
                        [  'for ',thisElectrode.name{1,1},' with ',titleName_filler{jj,1}];...
                        ['(',   matrix{1,1}.name{1,1},' [',num2str(round(massFractions_matrix(1,1),4) * 100),' wt.%], '...
                                matrix{2,1}.name{1,1},' [',num2str(round(massFractions_matrix(2,1),4) * 100),' wt.%], '...
                                matrix{3,1}.name{1,1},' [',num2str(100 - 100 * sum(round(massFractions_matrix(1:2,1),4))),' wt.%]',')']})
                 xlabel('\phi / -')
                 ylabel('\lambda_{eff} / W/(m \cdot K)')
                % save
                if ispc
                    eval(['saveas(gcf,''',dirName,'\',name_file_massFraction,'_',name_filler{jj,1},'_','k_eff',''',''fig'')'])
                    eval(['saveas(gcf,''',dirName,'\pictures\',name_file_massFraction,'_',name_filler{jj,1},'_','k_eff',''',''png'')'])
                    eval(['saveas(gcf,''',dirName,'\vector_graphs\',name_file_massFraction,'_',name_filler{jj,1},'_','k_eff',''',''epsc'')'])
                    try
                        eval(['saveas(gcf,''',dirName,'\vector_graphs\',name_file_massFraction,'_',name_filler{jj,1},'_','k_eff',''',''emf'')'])
                    catch
                        disp('emf not possible')
                    end
                elseif isunix
                    eval(['saveas(gcf,''',dirName,'/',name_file_massFraction,'_',name_filler{jj,1},'_','k_eff',''',''fig'')'])
                    eval(['saveas(gcf,''',dirName,'/pictures/',name_file_massFraction,'_',name_filler{jj,1},'_','k_eff',''',''png'')'])
                    eval(['saveas(gcf,''',dirName,'/vector_graphs/',name_file_massFraction,'_',name_filler{jj,1},'_','k_eff',''',''epsc'')'])
                    try
                        eval(['saveas(gcf,''',dirName,'/vector_graphs/',name_file_massFraction,'_',name_filler{jj,1},'_','k_eff',''',''emf'')'])
                    catch
                        disp('emf not possible')
                    end
                else
                    disp('Platform not supported')
                end
                clear nn
                close(figure(gcf))
                clear fig
                fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-1.',' ','End of plot of effective thermal conductivity.\n\n'])
                
                % in-plane thermal conductivity
                fig = figure;
                set(fig,'Unit','normalized','Position',[0.1,0.1,0.35,0.65])
                hold on
                fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-2.',' ','Start to plot in-plane thermal conductivity...\n\n'])
                for nn = 1 : size(names_model,1)
                    try
                    % calculation
                        fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-2.',num2str(nn),'.',' ','Start to calculate the in-plane thermal conductivity for ',legendNames_model{nn,1},'...\n\n'])   
                        y_thermalConductivity_inPlane{1,nn} =...
                            y_thermalConductivity{1,nn} * (1 - volumeFraction_currentCollector(ii,1)) +...
                            currentCollector{ii,1}.thermalConductivity * volumeFraction_currentCollector(ii,1);
                        fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-2.',num2str(nn),'.',' ','End of Calculation of the in-plane thermal conductivity for ',legendNames_model{nn,1},'.\n\n'])
                    % plot
                        fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-2.',num2str(nn),'.',' ','Start to plot the in-plane thermal conductivity for ',legendNames_model{nn,1},'...\n\n'])
                        plot(x{1,nn},y_thermalConductivity_inPlane{1,nn},'LineWidth',1.5,'LineStyle',lineStyles{mod(nn - 1,size(lineStyles,1)) + 1,1},...
                            'Color',colors{mod(nn - 1,size(colors,1)) + 1,1})
                        fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-2.',num2str(nn),'.',' ','End of plot of the in-plane thermal conductivity for ',legendNames_model{nn,1},'.\n\n'])
                    catch
                        fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-2.',num2str(nn),'.',' ','Failed to plot the in-plane thermal conductivity for ',legendNames_model{nn,1},'...\n\n'])
                        continue
                    end
                end
                clear nn
                hold off
                grid on
                legend(legend_thermalConductivity)
                title({ 'in-plane thermal conductivity against porosity';...
                        [' with ',name_currentCollector{ii,1},' (',num2str(round(volumeFraction_currentCollector(ii,1),4) * 100),' vol.%)'];...
                        [  'for ',thisElectrode.name{1,1},' with ',titleName_filler{jj,1}];...
                        ['(',   matrix{1,1}.name{1,1},' [',num2str(round(massFractions_matrix(1,1),4) * 100),' wt.%], '...
                                matrix{2,1}.name{1,1},' [',num2str(round(massFractions_matrix(2,1),4) * 100),' wt.%], '...
                                matrix{3,1}.name{1,1},' [',num2str(100 - 100 * sum(round(massFractions_matrix(1:2,1),4))),' wt.%]',')']})
                 xlabel('\phi / -')
                 ylabel('\lambda_{eff} / W/(m \cdot K)')
                % save
                if ispc
                    eval(['saveas(gcf,''',dirName,'\',name_file_massFraction,'_',name_filler{jj,1},'_','k_inPlane',''',''fig'')'])
                    eval(['saveas(gcf,''',dirName,'\pictures\',name_file_massFraction,'_',name_filler{jj,1},'_','k_inPlane',''',''png'')'])
                    eval(['saveas(gcf,''',dirName,'\vector_graphs\',name_file_massFraction,'_',name_filler{jj,1},'_','k_inPlane',''',''epsc'')'])
                    try
                        eval(['saveas(gcf,''',dirName,'\vector_graphs\',name_file_massFraction,'_',name_filler{jj,1},'_','k_inPlane',''',''emf'')'])
                    catch
                        disp('emf not possible')
                    end
                elseif isunix
                    eval(['saveas(gcf,''',dirName,'/',name_file_massFraction,'_',name_filler{jj,1},'_','k_inPlane',''',''fig'')'])
                    eval(['saveas(gcf,''',dirName,'/pictures/',name_file_massFraction,'_',name_filler{jj,1},'_','k_inPlane',''',''png'')'])
                    eval(['saveas(gcf,''',dirName,'/vector_graphs/',name_file_massFraction,'_',name_filler{jj,1},'_','k_inPlane',''',''epsc'')'])
                    try
                        eval(['saveas(gcf,''',dirName,'/vector_graphs/',name_file_massFraction,'_',name_filler{jj,1},'_','k_inPlane',''',''emf'')'])
                    catch
                        disp('emf not possible')
                    end
                else
                    disp('Platform not supported')
                end
                clear nn
                close(figure(gcf))
                clear fig
                fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-2.',' ','End of plot of in-plane thermal conductivity.\n\n'])
                
                % through-plane thermal conductivity
                fig = figure;
                set(fig,'Unit','normalized','Position',[0.1,0.1,0.35,0.65])
                hold on
                fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-3.',' ','Start to plot through-plane thermal conductivity...\n\n'])
                for nn = 1 : size(names_model,1)
                    try
                    % calculation
                        fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-3.',num2str(nn),'.',' ','Start to calculate the through-plane thermal conductivity for ',legendNames_model{nn,1},'...\n\n'])   
                        y_thermalConductivity_throughPlane{1,nn} = 1 ./ (...
                            (1 - volumeFraction_currentCollector(ii,1)) ./ y_thermalConductivity{1,nn} +...
                            volumeFraction_currentCollector(ii,1) / currentCollector{ii,1}.thermalConductivity);
                        fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-3.',num2str(nn),'.',' ','End of Calculation of the through-plane thermal conductivity for ',legendNames_model{nn,1},'.\n\n'])
                    % plot
                        fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-3.',num2str(nn),'.',' ','Start to plot the through-plane thermal conductivity for ',legendNames_model{nn,1},'...\n\n'])
                        plot(x{1,nn},y_thermalConductivity_throughPlane{1,nn},'LineWidth',1.5,'LineStyle',lineStyles{mod(nn - 1,size(lineStyles,1)) + 1,1},...
                            'Color',colors{mod(nn - 1,size(colors,1)) + 1,1})
                        fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-3.',num2str(nn),'.',' ','End of plot of the through-plane thermal conductivity for ',legendNames_model{nn,1},'.\n\n'])
                    catch
                        fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-3.',num2str(nn),'.',' ','Failed to plot the through-plane thermal conductivity for ',legendNames_model{nn,1},'...\n\n'])
                        continue
                    end
                end
                clear nn
                hold off
                grid on
                legend(legend_thermalConductivity)
                title({ 'through-plane thermal conductivity against porosity';...
                        [' with ',name_currentCollector{ii,1},' (',num2str(round(volumeFraction_currentCollector(ii,1),4) * 100),' vol.%)'];...
                        [  'for ',thisElectrode.name{1,1},' with ',titleName_filler{jj,1}];...
                        ['(',   matrix{1,1}.name{1,1},' [',num2str(round(massFractions_matrix(1,1),4) * 100),' wt.%], '...
                                matrix{2,1}.name{1,1},' [',num2str(round(massFractions_matrix(2,1),4) * 100),' wt.%], '...
                                matrix{3,1}.name{1,1},' [',num2str(100 - 100 * sum(round(massFractions_matrix(1:2,1),4))),' wt.%]',')']})
                 xlabel('\phi / -')
                 ylabel('\lambda_{eff} / W/(m \cdot K)')
                % save
                if ispc
                    eval(['saveas(gcf,''',dirName,'\',name_file_massFraction,'_',name_filler{jj,1},'_','k_throughPlane',''',''fig'')'])
                    eval(['saveas(gcf,''',dirName,'\pictures\',name_file_massFraction,'_',name_filler{jj,1},'_','k_throughPlane',''',''png'')'])
                    eval(['saveas(gcf,''',dirName,'\vector_graphs\',name_file_massFraction,'_',name_filler{jj,1},'_','k_throughPlane',''',''epsc'')'])
                    try
                        eval(['saveas(gcf,''',dirName,'\vector_graphs\',name_file_massFraction,'_',name_filler{jj,1},'_','k_throughPlane',''',''emf'')'])
                    catch
                        disp('emf not possible')
                    end
                elseif isunix
                    eval(['saveas(gcf,''',dirName,'/',name_file_massFraction,'_',name_filler{jj,1},'_','k_throughPlane',''',''fig'')'])
                    eval(['saveas(gcf,''',dirName,'/pictures/',name_file_massFraction,'_',name_filler{jj,1},'_','k_throughPlane',''',''png'')'])
                    eval(['saveas(gcf,''',dirName,'/vector_graphs/',name_file_massFraction,'_',name_filler{jj,1},'_','k_throughPlane',''',''epsc'')'])
                    try
                        eval(['saveas(gcf,''',dirName,'/vector_graphs/',name_file_massFraction,'_',name_filler{jj,1},'_','k_throughPlane',''',''emf'')'])
                    catch
                        disp('emf not possible')
                    end
                else
                    disp('Platform not supported')
                end
                clear nn
                close(figure(gcf))
                clear fig
                fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-3.',' ','End of plot of through-plane thermal conductivity.\n\n'])
                
                %save to xls-file
                try
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3.',' ','Start to save thermal conductivities to xls-file...\n\n'])
                    for nn = 1 : size(names_model,1)
                        fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3.',num2str(nn),'.',' ','Start to save thermal conductivities for ',legendNames_model{nn,1},'...\n\n'])
                        if ispc
                            xlswrite([dirName,'\tables\t_',name_file_massFraction,'_',name_filler{jj,1},'_k_',fileNames_model{nn,1}],[x{1,nn},y_thermalConductivity{1,nn},y_thermalConductivity_inPlane{1,nn},y_thermalConductivity_throughPlane{1,nn}])
                        elseif isunix
                            xlswrite([dirName,'/tables/t_',name_file_massFraction,'_',name_filler{jj,1},'_k_',fileNames_model{nn,1}],[x{1,nn},y_thermalConductivity{1,nn},y_thermalConductivity_inPlane{1,nn},y_thermalConductivity_throughPlane{1,nn}])
                        else
                            disp('Platform not supported')
                        end
                        fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3.',num2str(nn),'.',' ','End of saving thermal conductivities for ',legendNames_model{nn,1},'...\n\n'])
                    end
                    clear nn
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3.',' ','End of saving thermal conductivities to xls-file...\n\n'])
                catch
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3.',' ','Failed to save thermal conductivities to xls-file...\n\n'])
                end
                
                try
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3.',' ','Start to plot thermal conductivities only for ZBS...\n\n'])
                    % thermal conductivity for ZBS
                    fig = figure;
                    set(fig,'Unit','normalized','Position',[0.1,0.1,0.35,0.65])
                    hold on
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-4.',' ','Start to plot effective thermal conductivity for ZBS...\n\n'])
                    for nn = size(names_model,1) - nZSM + 1 : size(names_model,1)
                        try
                        % plot
                            fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-4.',num2str(nn),'.',' ','Start to plot the effective thermal conductivity for ',legendNames_model{nn,1},'...\n\n'])
                            plot(x{1,nn},y_thermalConductivity{1,nn},'LineWidth',1.5,'LineStyle',lineStyles{mod(nn - 1,size(lineStyles,1)) + 1,1},...
                                'Color',colors{mod(nn - 1,size(colors,1)) + 1,1})
                            fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-4.',num2str(nn),'.',' ','End of plot of the effective thermal conductivity for ',legendNames_model{nn,1},'.\n\n'])
                        catch
                            fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-4.',num2str(nn),'.',' ','Failed to plot the effective thermal conductivity for ',legendNames_model{nn,1},'.\n\n'])
                            continue
                        end
                    end
                    clear nn
                    hold off
                    grid on
                    legend(legend_thermalConductivity(end - nZSM + 1:end))
                    title({ 'effective thermal conductivity against porosity for ZBS';...
                            [' without ',name_currentCollector{ii,1},];...
                            [  'for ',thisElectrode.name{1,1},' with ',titleName_filler{jj,1}];...
                            ['(',   matrix{1,1}.name{1,1},' [',num2str(round(massFractions_matrix(1,1),4) * 100),' wt.%], '...
                                    matrix{2,1}.name{1,1},' [',num2str(round(massFractions_matrix(2,1),4) * 100),' wt.%], '...
                                    matrix{3,1}.name{1,1},' [',num2str(100 - 100 * sum(round(massFractions_matrix(1:2,1),4))),' wt.%]',')']})
                     xlabel('\phi / -')
                     ylabel('\lambda_{eff} / W/(m \cdot K)')
                    % save
                    if ispc
                        eval(['saveas(gcf,''',dirName,'\',name_file_massFraction,'_',name_filler{jj,1},'_','k_eff_ZBS',''',''fig'')'])
                        eval(['saveas(gcf,''',dirName,'\pictures\',name_file_massFraction,'_',name_filler{jj,1},'_','k_eff_ZBS',''',''png'')'])
                        eval(['saveas(gcf,''',dirName,'\vector_graphs\',name_file_massFraction,'_',name_filler{jj,1},'_','k_eff_ZBS',''',''epsc'')'])
                        try
                            eval(['saveas(gcf,''',dirName,'\vector_graphs\',name_file_massFraction,'_',name_filler{jj,1},'_','k_eff_ZBS',''',''emf'')'])
                        catch
                            disp('emf not possible')
                        end
                    elseif isunix
                        eval(['saveas(gcf,''',dirName,'/',name_file_massFraction,'_',name_filler{jj,1},'_','k_eff_ZBS',''',''fig'')'])
                        eval(['saveas(gcf,''',dirName,'/pictures/',name_file_massFraction,'_',name_filler{jj,1},'_','k_eff_ZBS',''',''png'')'])
                        eval(['saveas(gcf,''',dirName,'/vector_graphs/',name_file_massFraction,'_',name_filler{jj,1},'_','k_eff_ZBS',''',''epsc'')'])
                        try
                            eval(['saveas(gcf,''',dirName,'/vector_graphs/',name_file_massFraction,'_',name_filler{jj,1},'_','k_eff_ZBS',''',''emf'')'])
                        catch
                            disp('emf not possible')
                        end
                    else
                        disp('Platform not supported')
                    end
                    clear nn
                    close(figure(gcf))
                    clear fig
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-4.',' ','End of plot of effective thermal conductivity for ZBS.\n\n'])

                    % in-plane thermal conductivity for ZBS
                    fig = figure;
                    set(fig,'Unit','normalized','Position',[0.1,0.1,0.35,0.65])
                    hold on
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-5.',' ','Start to plot in-plane thermal conductivity for ZBS...\n\n'])
                    for nn = size(names_model,1) - nZSM + 1 : size(names_model,1)
                        try
                        % plot
                            fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-5.',num2str(nn),'.',' ','Start to plot the in-plane thermal conductivity for ',legendNames_model{nn,1},'...\n\n'])
                            plot(x{1,nn},y_thermalConductivity_inPlane{1,nn},'LineWidth',1.5,'LineStyle',lineStyles{mod(nn - 1,size(lineStyles,1)) + 1,1},...
                                'Color',colors{mod(nn - 1,size(colors,1)) + 1,1})
                            fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-5.',num2str(nn),'.',' ','End of plot of the in-plane thermal conductivity for ',legendNames_model{nn,1},'.\n\n'])
                        catch
                            fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-5.',num2str(nn),'.',' ','Failed to plot the in-plane thermal conductivity for ',legendNames_model{nn,1},'.\n\n'])
                            continue
                        end
                    end
                    clear nn
                    hold off
                    grid on
                    legend(legend_thermalConductivity(end - nZSM + 1:end))
                    title({ 'in-plane thermal conductivity against porosity for ZBS';...
                            [' with ',name_currentCollector{ii,1},' (',num2str(round(volumeFraction_currentCollector(ii,1),4) * 100),' vol.%)'];...
                            [  'for ',thisElectrode.name{1,1},' with ',titleName_filler{jj,1}];...
                            ['(',   matrix{1,1}.name{1,1},' [',num2str(round(massFractions_matrix(1,1),4) * 100),' wt.%], '...
                                    matrix{2,1}.name{1,1},' [',num2str(round(massFractions_matrix(2,1),4) * 100),' wt.%], '...
                                    matrix{3,1}.name{1,1},' [',num2str(100 - 100 * sum(round(massFractions_matrix(1:2,1),4))),' wt.%]',')']})
                     xlabel('\phi / -')
                     ylabel('\lambda_{eff} / W/(m \cdot K)')
                    % save
                    if ispc
                        eval(['saveas(gcf,''',dirName,'\',name_file_massFraction,'_',name_filler{jj,1},'_','k_inPlane_ZBS',''',''fig'')'])
                        eval(['saveas(gcf,''',dirName,'\pictures\',name_file_massFraction,'_',name_filler{jj,1},'_','k_inPlane_ZBS',''',''png'')'])
                        eval(['saveas(gcf,''',dirName,'\vector_graphs\',name_file_massFraction,'_',name_filler{jj,1},'_','k_inPlane_ZBS',''',''epsc'')'])
                        try
                            eval(['saveas(gcf,''',dirName,'\vector_graphs\',name_file_massFraction,'_',name_filler{jj,1},'_','k_inPlane_ZBS',''',''emf'')'])
                        catch
                            disp('emf not possible')
                        end
                    elseif isunix
                        eval(['saveas(gcf,''',dirName,'/',name_file_massFraction,'_',name_filler{jj,1},'_','k_inPlane_ZBS',''',''fig'')'])
                        eval(['saveas(gcf,''',dirName,'/pictures/',name_file_massFraction,'_',name_filler{jj,1},'_','k_inPlane_ZBS',''',''png'')'])
                        eval(['saveas(gcf,''',dirName,'/vector_graphs/',name_file_massFraction,'_',name_filler{jj,1},'_','k_inPlane_ZBS',''',''epsc'')'])
                        try
                            eval(['saveas(gcf,''',dirName,'/vector_graphs/',name_file_massFraction,'_',name_filler{jj,1},'_','k_inPlane_ZBS',''',''emf'')'])
                        catch
                            disp('emf not possible')
                        end
                    else
                        disp('Platform not supported')
                    end
                    clear nn
                    close(figure(gcf))
                    clear fig
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-5.',' ','End of plot of in-plane thermal conductivity for ZBS.\n\n'])

                    % through-plane thermal conductivity for ZBS
                    fig = figure;
                    set(fig,'Unit','normalized','Position',[0.1,0.1,0.35,0.65])
                    hold on
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-6.',' ','Start to plot through-plane thermal conductivity for ZBS...\n\n'])
                    for nn = size(names_model,1) - nZSM + 1 : size(names_model,1)
                        try
                        % plot
                            fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-6.',num2str(nn),'.',' ','Start to plot the through-plane thermal conductivity for ',legendNames_model{nn,1},'...\n\n'])
                            plot(x{1,nn},y_thermalConductivity_throughPlane{1,nn},'LineWidth',1.5,'LineStyle',lineStyles{mod(nn - 1,size(lineStyles,1)) + 1,1},...
                                'Color',colors{mod(nn - 1,size(colors,1)) + 1,1})
                            fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-6.',num2str(nn),'.',' ','End of plot of the through-plane thermal conductivity for ',legendNames_model{nn,1},'.\n\n'])
                        catch
                            fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-6.',num2str(nn),'.',' ','Failed to plot the through-plane thermal conductivity for ',legendNames_model{nn,1},'.\n\n'])
                            continue
                        end
                    end
                    clear nn
                    hold off
                    grid on
                    legend(legend_thermalConductivity(end - nZSM + 1:end))
                    title({ 'through-plane thermal conductivity against porosity for ZBS';...
                            [' with ',name_currentCollector{ii,1},' (',num2str(round(volumeFraction_currentCollector(ii,1),4) * 100),' vol.%)'];...
                            [  'for ',thisElectrode.name{1,1},' with ',titleName_filler{jj,1}];...
                            ['(',   matrix{1,1}.name{1,1},' [',num2str(round(massFractions_matrix(1,1),4) * 100),' wt.%], '...
                                    matrix{2,1}.name{1,1},' [',num2str(round(massFractions_matrix(2,1),4) * 100),' wt.%], '...
                                    matrix{3,1}.name{1,1},' [',num2str(100 - 100 * sum(round(massFractions_matrix(1:2,1),4))),' wt.%]',')']})
                     xlabel('\phi / -')
                     ylabel('\lambda_{eff} / W/(m \cdot K)')
                    % save
                    if ispc
                        eval(['saveas(gcf,''',dirName,'\',name_file_massFraction,'_',name_filler{jj,1},'_','k_throughPlane_ZBS',''',''fig'')'])
                        eval(['saveas(gcf,''',dirName,'\pictures\',name_file_massFraction,'_',name_filler{jj,1},'_','k_throughPlane_ZBS',''',''png'')'])
                        eval(['saveas(gcf,''',dirName,'\vector_graphs\',name_file_massFraction,'_',name_filler{jj,1},'_','k_throughPlane_ZBS',''',''epsc'')'])
                        try
                            eval(['saveas(gcf,''',dirName,'\vector_graphs\',name_file_massFraction,'_',name_filler{jj,1},'_','k_throughPlane_ZBS',''',''emf'')'])
                        catch
                            disp('emf not possible')
                        end
                    elseif isunix
                        eval(['saveas(gcf,''',dirName,'/',name_file_massFraction,'_',name_filler{jj,1},'_','k_throughPlane_ZBS',''',''fig'')'])
                        eval(['saveas(gcf,''',dirName,'/pictures/',name_file_massFraction,'_',name_filler{jj,1},'_','k_throughPlane_ZBS',''',''png'')'])
                        eval(['saveas(gcf,''',dirName,'/vector_graphs/',name_file_massFraction,'_',name_filler{jj,1},'_','k_throughPlane_ZBS',''',''epsc'')'])
                        try
                            eval(['saveas(gcf,''',dirName,'/vector_graphs/',name_file_massFraction,'_',name_filler{jj,1},'_','k_throughPlane_ZBS',''',''emf'')'])
                        catch
                            disp('emf not possible')
                        end
                    else
                        disp('Platform not supported')
                    end
                    clear nn
                    close(figure(gcf))
                    clear fig
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3-6.',' ','End of plot of through-plane thermal conductivity for ZBS.\n\n'])
                    
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3.',' ','End of plot thermal conductivities only for ZBS...\n\n'])
                catch
                    fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'-3.',' ','Failed to plot thermal conductivities only for ZBS...\n\n'])
                end
            fprintf([num2str(ii),'.',num2str(jj),'.',num2str(pp),'.',' ','End of ',name_file_massFraction,'.\n\n'])
            clear legend_thermalConductivity y_thermalConductivity_throughPlane y_thermalConductivity_inPlane y_thermalConductivity f_thermalConductivity x N
        end

        clear pp
        clear volumeFractions_matrix massFractions_matrix
        fprintf([num2str(ii),'.',num2str(jj),'.',' ','End of ',name_filler{jj,1},'.\n\n'])
 
    end
    clear jj
    clear names_matrix thisElectrode
    fprintf([num2str(ii),'.',' ','End of ',name_electrode{ii,1},'.\n\n'])
end
clear ii
fprintf('End of Part 2.\n\n\n')

% -------------------------------------------------- Core PART   END --------------------------------------------------

clear currentFolder

%% Part 3: influence of electrolytes£¬composition for k and k
clear
currentFolder = pwd;
fprintf('Start of Part 3...\n\n\n')
load tables electrode statistics
load massFractionsMatrix_BMWi3Electrodes

% -------------------------------------------------- INPUT START --------------------------------------------------
% 1. electrode: TO FILL
name_electrode = {'graphiteAnode';'NMCCathode';'LCOCathode'};              % ii
% 2. filler/fluid: TO FILL
name_filler = {'air';'He';'CO2';'LP30';'LP50'};                            % jj
        % 2.2 corresponding cell vector for titles: TO CHECK
        legendName_filler = {'air';'He';'CO_{2}';'LP30';'LP50'};            % jj: It should correspond name_filler
        % =================================== NOT TO FILL BEGIN ===================================
        if size(name_filler,1) > size(legendName_filler,1)
            error('The dimension of name_filler cannot be bigger than that of legendName_filler.')
        end
        % =================================== NOT TO FILL   END ===================================
% 3. mass fraction of conductive additive to binder: TO FILL
ratio_conductiveAdditive_binder_all = [1/1;1/2;2/1];                        % ll
% 4. mass fraction of active material: TO FILL
massFraction_activeMaterial = [0.85;0.9;0.95];                              % hh
% 5. additional compositions
massFractions_matrix_additional = { [0.918;0.028];...                       % common composition for anode
                                    [0.9;0.06];...                          % common composition for cathode
                                    [0.9;0.05];...                          % common composition for cathode
                                   };
% 6. model: TO FILL
name_model = 'ZSM_1,curveName=''curveRAreaContact'',modelAdditiveName=''percolationModel,kc=0.3,vc=0.15,nExp=0.51'',modeTortuosity=1,a=0,c=0,e=0,g=0';
    % 6.2 corresponding cell vectors for titles: TO CHECK
    legendName_model = 'ZSM 1(percolation),tau 1';
    fileName_model ='ZBS1_1_P';
% 7. filler for changing compositions and thermal conductivities
filler = statistics(name_filler{1,1},:);
    
% -------------------------------------------------- INPUT   END --------------------------------------------------

% ---------------------------------------- POSTPROCESSING OF INPUT BEGIN ----------------------------------------
name_currentCollector = cell(size(name_electrode,1),1);
currentCollector = cell(size(name_electrode,1),1);
volumeFraction_currentCollector = zeros(size(name_electrode,1),1);
for ii = 1 : size(name_electrode,1)
    if strcmp(name_electrode{ii,1}(end-4:end),'Anode') && ~strcmp(name_electrode{ii,1}(end-6:end),'Cathode')
        name_currentCollector{ii,1} = 'copper';
        currentCollector{ii,1} = statistics(name_currentCollector{ii,1},:);
        volumeFraction_currentCollector(ii,1) = 11.8333/124;
    elseif ~strcmp(name_electrode{ii,1}(end-4:end),'Anode') && strcmp(name_electrode{ii,1}(end-6:end),'Cathode')
        name_currentCollector{ii,1} = 'aluminium';
        currentCollector{ii,1} = statistics(name_currentCollector{ii,1},:);
        volumeFraction_currentCollector(ii,1) = 16.7667/146;
    end
end 
clear ii


massFractions_matrix_all = cell(size(massFraction_activeMaterial,1) * size(ratio_conductiveAdditive_binder_all,1) + size(massFractions_matrix_additional,1),1);    % pp
for ll = 1 : size(ratio_conductiveAdditive_binder_all,1)
    for hh = 1 : size(massFraction_activeMaterial,1)
        massFractions_matrix_all{(ll - 1) * size(massFraction_activeMaterial,1) + hh,1} = [massFraction_activeMaterial(hh,1);...
                              (1 - massFraction_activeMaterial(hh,1)) * ratio_conductiveAdditive_binder_all(ll,1) /...
                              (ratio_conductiveAdditive_binder_all(ll,1) + 1)];
    end
    clear hh
end
clear ll
for ll = 1 : size(massFractions_matrix_additional,1)
    massFractions_matrix_all{size(massFraction_activeMaterial,1) * size(ratio_conductiveAdditive_binder_all,1) + ll,1} = massFractions_matrix_additional{ll,1}; 
end

lineStyles = {'-';'--';'-.';':'};
colors = {  [106,90,205]/255;   [255,69,0]/255;     [56,94,15]/255;     [0,255,127]/255;    [128,42,42]/255;...
            [255,215,0]/255;    [250,128,114]/255;  [30,144,255]/255;   [255,0,255]/255;    [50,205,50]/255;...
            [65,105,255]/255;   [227,23,13]/255;    [12,23,70]/255;     [115,74,18]/255; 	[176,48,96]/255};
% ---------------------------------------- POSTPROCESSING OF INPUT   END ----------------------------------------

% --------------------------------------------- CREATE FOLDER BEGIN ---------------------------------------------
if ispc
    if ~exist([currentFolder,'\','influences'],'dir')
        mkdir('influences')
    end
elseif isunix
    if ~exist([currentFolder,'/','influences'],'dir')
        mkdir('influences')
    end
else
    disp('Platform not supported')
end
% --------------------------------------------- CREATE FOLDER   END ---------------------------------------------

% -------------------------------------------------- Core PART BEGIN --------------------------------------------------
for ii = 1 : size(name_electrode,1)
    fprintf([num2str(ii),'.',' ','For ',name_electrode{ii,1},':\n\n'])
    if ispc
        if ~exist([currentFolder,'\','influences\',name_electrode{ii,1}],'dir')
            mkdir(['influences\',name_electrode{ii,1}])
        end
    elseif isunix
        if ~exist([currentFolder,'/','influences/',name_electrode{ii,1}],'dir')
            mkdir(['influences/',name_electrode{ii,1}])
        end
    else
        disp('Platform not supported')
    end
    if ispc
        if ~exist([currentFolder,'\','influences\',name_electrode{ii,1},'\pictures'],'dir')
            mkdir(['influences\',name_electrode{ii,1},'\pictures'])
        end
    elseif isunix
        if ~exist([currentFolder,'/','influences/',name_electrode{ii,1},'/pictures'],'dir')
            mkdir(['influences/',name_electrode{ii,1},'/pictures'])
        end
    else
        disp('Platform not supported')
    end
    if ispc
        if ~exist([currentFolder,'\','influences\',name_electrode{ii,1},'\vector_graphs'],'dir')
            mkdir(['influences\',name_electrode{ii,1},'\vector_graphs'])
        end
    elseif isunix
        if ~exist([currentFolder,'/','influences/',name_electrode{ii,1},'/vector_graphs'],'dir')
            mkdir(['influences/',name_electrode{ii,1},'/vector_graphs'])
        end
    else
        disp('Platform not supported')
    end    
    % load names of matrix materials from electrode
    thisElectrode = electrode(name_electrode{ii,1},:);
    names_matrix = cell(3,1);
    matrix = cell(3,1);
    for kk = 1 : 3
        names_matrix{kk,1} =  thisElectrode{1,kk}{1,1};
        matrix{kk,1} = statistics(names_matrix{kk,1},:);
    end
    clear kk
    
    massFractions_matrix = massFractions_matrix_all{size(massFraction_activeMaterial,1) * size(ratio_conductiveAdditive_binder_all,1) + ii,1};
    [volumeFractions_matrix,~] = fractionsMatrix_xPorosity_transfer(...
        names_matrix,massFractions_matrix,'none',0,1,0,0,0);

  % different electrolytes
    fprintf([num2str(ii),'-1.',' ','Start of thermal conductivity of ',thisElectrode.name{1,1},' with differnt electrolytes...\n\n'])
    fig = figure;
    set(fig,'Unit','normalized','Position',[0.1,0.1,0.35,0.65])
    hold on
    fprintf([num2str(ii),'-1.',' ','Start to plot effective thermal conductivity of ',thisElectrode.name{1,1},' with different electrolytes for',legendName_model,'...\n\n'])
    legend_thermalConductivity = cell(size(name_filler,1),1);
    deltaX = 0.01;
    x = (0:deltaX:1)';
    y_thermalConductivity = zeros(1/deltaX + 1,1);
    for jj = 1 : size(name_filler,1)
        try
        % calculation
            f_thermalConductivity = @(x) k_model_out_of_name(...
                        names_matrix,volumeFractions_matrix,name_filler{jj,1},x,name_model);
            fprintf([num2str(ii),'-1.',num2str(jj),'.',' ','Start to calculate the effective thermal conductivity of ',thisElectrode.name{1,1},' with ',name_filler{jj,1},' for ',legendName_model,'...\n\n'])
            for oo = 1 : 1 / deltaX + 1
                try
                    y_thermalConductivity(oo,1) = f_thermalConductivity(x(oo,1));
                catch
                    y_thermalConductivity(oo,1) = NaN;
                    fprintf([num2str(ii),'-1.',num2str(jj),'.',' ','Failed to calculate the effective thermal conductivity of ',thisElectrode.name{1,1},' with ',name_filler{jj,1},' for ',legendName_model,'...\n\n'])
                end
            end
            fprintf([num2str(ii),'-1.',num2str(jj),'.',' ','End of Calculation of the effective thermal conductivity of ',thisElectrode.name{1,1},' with ',name_filler{jj,1},' for ',legendName_model,' at x = ',num2str(x(oo,1)),'...\n\n'])
        % plot
            fprintf([num2str(ii),'-1.',num2str(jj),'.',' ','Start to plot the effective thermal conductivity of ',thisElectrode.name{1,1},' with ',name_filler{jj,1},' for ',legendName_model,'...\n\n'])
            plot(x,y_thermalConductivity,'LineWidth',1.5,'LineStyle',lineStyles{mod(jj - 1,size(lineStyles,1)) + 1,1},...
                'Color',colors{mod(jj - 1,size(colors,1)) + 1,1})
            fprintf([num2str(ii),'-1.',num2str(jj),'.',' ','End of plot of the effective thermal conductivity of ',thisElectrode.name{1,1},' with ',name_filler{jj,1},' for ',legendName_model,'...\n\n'])
            legend_thermalConductivity{jj,1} = legendName_filler{jj,1};
        catch
            fprintf([num2str(ii),'-1.',num2str(jj),'.',' ','Failed to plot the effective thermal conductivity of ',thisElectrode.name{1,1},' with ',name_filler{jj,1},' for ',legendName_model,'...\n\n'])
            continue
        end
        clear y_thermalConductivity f_thermalConductivity
    end
    clear jj
    hold off
    grid on
    legend_thermalConductivity(cellfun(@isempty,legend_thermalConductivity)) = [];
    legend(legend_thermalConductivity)
    title({ 'effective thermal conductivity against porosity';...
            [' without ',name_currentCollector{ii,1},];...
            [  'for ',thisElectrode.name{1,1},' with different electrolytes for ',legendName_model];...
            ['(',   matrix{1,1}.name{1,1},' [',num2str(round(massFractions_matrix(1,1),4) * 100),' wt.%], '...
                    matrix{2,1}.name{1,1},' [',num2str(round(massFractions_matrix(2,1),4) * 100),' wt.%], '...
                    matrix{3,1}.name{1,1},' [',num2str(100 - 100 * sum(round(massFractions_matrix(1:2,1),4))),' wt.%]',')']})
     xlabel('\phi / -')
     ylabel('\lambda_{eff} / W/(m \cdot K)')
    % save
    if ispc
        eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\','k_diffElectrolytes_',fileName_model,''',''fig'')'])
        eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\pictures\','k_diffElectrolytes_',fileName_model,''',''png'')'])
        eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\vector_graphs\','k_diffElectrolytes_',fileName_model,''',''epsc'')'])
        try
            eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\vector_graphs\','k_diffElectrolytes_',fileName_model,''',''emf'')'])
        catch
            disp('emf not possible')
        end
    elseif isunix
        eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/','k_diffElectrolytes_',fileName_model,''',''fig'')'])
        eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/pictures/','k_diffElectrolytes_',fileName_model,''',''png'')'])
        eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/vector_graphs/','k_diffElectrolytes_',fileName_model,''',''epsc'')'])
        try
            eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/vector_graphs/','k_diffElectrolytes_',fileName_model,''',''emf'')'])
        catch
            disp('emf not possible')
        end
    else
        disp('Platform not supported')
    end
    close(figure(gcf))
    clear fig
	clear volumeFractions_matrix legend_thermalConductivity x deltaX
    fprintf([num2str(ii),'-1.',' ','End of thermal conductivity of ',thisElectrode.name{1,1},' with differnt electrolytes...\n\n'])

    % composition changes
    fprintf([num2str(ii),'-2.',' ','Start of thermal conductivity of ',thisElectrode.name{1,1},' with differnt compositions...\n\n'])
    deltaX = 0.01;
    x = (0:deltaX:1)';
    N = 5;
    qqInterval = linspace(-2,2,5);
    if ~all(qqInterval == fix(qqInterval)) || size(qqInterval,2) ~= N
        error(['Every element in qqInterval should be integer and the number of qqInterval should be ',num2str(N),'.'])
    end
    diff = 0.05;
    
        % change in active material
        y_thermalConductivity = zeros(1/deltaX + 1,1);
        fig = figure;
        set(fig,'Unit','normalized','Position',[0.1,0.1,0.35,0.65])
        hold on 
        legend_thermalConductivity = cell(size(N,1),1);    
        fprintf([num2str(ii),'-2-1.',' ','Start to plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
        ratio_conductiveAdditive_binder = massFractions_matrix(2,1) / (1 - massFractions_matrix(1,1));
        for qq = qqInterval
            try
                fprintf([num2str(ii),'-2-1.',num2str(qq - qqInterval(1,1) + 1),' ','Start to calculate the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' wt.%% ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                massFractions_matrix_temporary = [massFractions_matrix(1,1) * (diff * qq + 1);(1 - massFractions_matrix(1,1) * (diff * qq + 1)) * ratio_conductiveAdditive_binder];
                [volumeFractions_matrix,~] = fractionsMatrix_xPorosity_transfer(...
                    names_matrix,massFractions_matrix_temporary,'none',0,1,0,0,0);
                f_thermalConductivity = @(x) k_model_out_of_name(...
                                names_matrix,volumeFractions_matrix,name_filler{1,1},x,name_model);
                for oo = 1 : 1 / deltaX + 1
                    try
                        y_thermalConductivity(oo,1) = f_thermalConductivity(x(oo,1));
                    catch
                        y_thermalConductivity(oo,1) = NaN;
                        fprintf([num2str(ii),'-2-1.',num2str(qq - qqInterval(1,1) + 1),' ','Start to calculate the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' wt.%% ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,' at x = ',num2str(x(oo,1)),'...\n\n'])
                    end
                end
                fprintf([num2str(ii),'-2-1.',num2str(qq - qqInterval(1,1) + 1),'.',' ','End of calculation of the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' wt.%% ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                fprintf([num2str(ii),'-2-1.',num2str(qq - qqInterval(1,1) + 1),'.',' ','Start to plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' wt.%% ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                plot(x,y_thermalConductivity,'LineWidth',1.5,'LineStyle',lineStyles{mod(qq - qqInterval(1,1),size(lineStyles,1)) + 1,1},...
                    'Color',colors{mod(qq - qqInterval(1,1),size(colors,1)) + 1,1})
                fprintf([num2str(ii),'-2-1.',num2str(qq - qqInterval(1,1) + 1),'.',' ','End of plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' wt.%% ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                legend_thermalConductivity{qq - qqInterval(1,1) + 1,1} = [num2str(diff * 100 * qq),' wt.% ',names_matrix{1,1},': ',...
                                                                            '[',num2str(round(massFractions_matrix_temporary(1,1),4) * 100),' %,',...
                                                                                num2str(round(massFractions_matrix_temporary(2,1),4) * 100),' %,',...
                                                                                num2str(100 - round(massFractions_matrix_temporary(1,1),4) * 100 - round(massFractions_matrix_temporary(2,1),4) * 100),' %]'];
            catch
                fprintf([num2str(ii),'-2-1.',num2str(qq - qqInterval(1,1) + 1),'.',' ','Failed to plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' wt.%% ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
            end
            fprintf([num2str(ii),'-2-1.',num2str(qq - qqInterval(1,1) + 1),'.',' ','End of plot of the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])

            clear y_thermalConductivity f_thermalConductivity volumeFractions_matrix massFractions_matrix_temporary
        end
        clear qq
        hold off
        grid on
        legend_thermalConductivity(cellfun(@isempty,legend_thermalConductivity)) = [];
        legend(legend_thermalConductivity)
        title({ 'effective thermal conductivity against porosity';...
                [' without ',name_currentCollector{ii,1},];...
                [  'for ',thisElectrode.name{1,1},' with ',legendName_filler{1,1},' for ',legendName_model];...
                ['(',   matrix{1,1}.name{1,1},' [',num2str(round(massFractions_matrix(1,1),4) * 100),' wt.%], '...
                        matrix{2,1}.name{1,1},' [',num2str(round(massFractions_matrix(2,1),4) * 100),' wt.%], '...
                        matrix{3,1}.name{1,1},' [',num2str(100 - 100 * sum(round(massFractions_matrix(1:2,1),4))),' wt.%]',')']})
         xlabel('\phi / -')
         ylabel('\lambda_{eff} / W/(m \cdot K)')
        % save
        if ispc
            eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\','k_diffCompositions_',names_matrix{1,1},'_',fileName_model,''',''fig'')'])
            eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\pictures\','k_diffCompositions_',names_matrix{1,1},'_',fileName_model,''',''png'')'])
            eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\vector_graphs\','k_diffCompositions_',names_matrix{1,1},'_',fileName_model,''',''epsc'')'])
            try
                eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\vector_graphs\','k_diffCompositions_',names_matrix{1,1},'_',fileName_model,''',''emf'')'])
            catch
                disp('emf not possible')
            end
        elseif isunix
            eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/','k_diffCompositions_',names_matrix{1,1},'_',fileName_model,''',''fig'')'])
            eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/pictures/','k_diffCompositions_',names_matrix{1,1},'_',fileName_model,''',''png'')'])
            eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/vector_graphs/','k_diffCompositions_',names_matrix{1,1},'_',fileName_model,''',''epsc'')'])
            try
                eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/vector_graphs/','k_diffCompositions_',names_matrix{1,1},'_',fileName_model,''',''emf'')'])
            catch
                disp('emf not possible')
            end
        else
            disp('Platform not supported')
        end
        close(figure(gcf))
        clear fig
        clear legend_thermalConductivity ratio_conductiveAdditive_binder    
        fprintf([num2str(ii),'-2-1.',' ','End of plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])

        % change in conductive additive
        y_thermalConductivity = zeros(1 / deltaX + 1,1);
        fig = figure;
        set(fig,'Unit','normalized','Position',[0.1,0.1,0.35,0.65])
        hold on
        legend_thermalConductivity = cell(size(5,1),1);    
        fprintf([num2str(ii),'-2-2.',' ','Start to plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',names_matrix{2,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
        ratio_activeMaterial_binder = massFractions_matrix(1,1) / (1 - massFractions_matrix(2,1));
        for qq = qqInterval
            try
                fprintf([num2str(ii),'-2-2.',num2str(qq - qqInterval(1,1) + 1),' ','Start to calculate the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' wt.%% ',names_matrix{2,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                massFractions_matrix_temporary = [(1 - massFractions_matrix(2,1) * (diff * qq + 1)) * ratio_activeMaterial_binder;massFractions_matrix(2,1) * (diff * qq + 1)];
                [volumeFractions_matrix,~] = fractionsMatrix_xPorosity_transfer(...
                    names_matrix,massFractions_matrix_temporary,'none',0,1,0,0,0);
                f_thermalConductivity = @(x) k_model_out_of_name(...
                    names_matrix,volumeFractions_matrix,name_filler{1,1},x,name_model);
                for oo = 1 : 1 / deltaX + 1
                    try
                        y_thermalConductivity(oo,1) = f_thermalConductivity(x(oo,1));
                    catch
                        y_thermalConductivity(oo,1) = NaN;
                        fprintf([num2str(ii),'-2-2.',num2str(qq - qqInterval(1,1) + 1),' ','Start to calculate the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' wt.%% ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,' at x = ',num2str(x(oo,1)),'...\n\n'])
                    end
                end
                fprintf([num2str(ii),'-2-2.',num2str(qq - qqInterval(1,1) + 1),'.',' ','End of calculation of the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' wt.%% ',names_matrix{2,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                fprintf([num2str(ii),'-2-2.',num2str(qq - qqInterval(1,1) + 1),'.',' ','Start to plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' wt.%% ',names_matrix{2,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                plot(x,y_thermalConductivity,'LineWidth',1.5,'LineStyle',lineStyles{mod(qq - qqInterval(1,1),size(lineStyles,1)) + 1,1},...
                    'Color',colors{mod(qq - qqInterval(1,1),size(colors,1)) + 1,1})
                fprintf([num2str(ii),'-2-2.',num2str(qq - qqInterval(1,1) + 1),'.',' ','End of plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' wt.%% ',names_matrix{2,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                legend_thermalConductivity{qq - qqInterval(1,1) + 1,1} = [num2str(diff * 100 * qq),' wt.% ',names_matrix{2,1},': ',...
                                                                            '[',num2str(round(massFractions_matrix_temporary(1,1),4) * 100),' %,',...
                                                                                num2str(round(massFractions_matrix_temporary(2,1),4) * 100),' %,',...
                                                                                num2str(100 - round(massFractions_matrix_temporary(1,1),4) * 100 - round(massFractions_matrix_temporary(2,1),4) * 100),' %]'];
            catch
                fprintf([num2str(ii),'-2-2.',num2str(qq - qqInterval(1,1) + 1),'.',' ','Failed to plot the effective thermal conductivity  (changing ',num2str(diff * 100 * qq),' wt.%% ',names_matrix{2,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
            end
            fprintf([num2str(ii),'-2-2.',num2str(qq - qqInterval(1,1) + 1),'.',' ','End of plot of the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',names_matrix{2,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
            clear y_thermalConductivity f_thermalConductivity volumeFractions_matrix massFractions_matrix_temporary
        end
        clear qq
        hold off   
        grid on
        legend_thermalConductivity(cellfun(@isempty,legend_thermalConductivity)) = [];
        legend(legend_thermalConductivity)
        title({ 'effective thermal conductivity against porosity';...
                [' without ',name_currentCollector{ii,1},];...
                [  'for ',thisElectrode.name{1,1},' with ',legendName_filler{1,1},' for ',legendName_model];...
                ['(',   matrix{1,1}.name{1,1},' [',num2str(round(massFractions_matrix(1,1),4) * 100),' wt.%], '...
                        matrix{2,1}.name{1,1},' [',num2str(round(massFractions_matrix(2,1),4) * 100),' wt.%], '...
                        matrix{3,1}.name{1,1},' [',num2str(100 - 100 * sum(round(massFractions_matrix(1:2,1),4))),' wt.%]',')']})
         xlabel('\phi / -')
         ylabel('\lambda_{eff} / W/(m \cdot K)')
        % save
        if ispc
            eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\','k_diffCompositions_',names_matrix{2,1},'_',fileName_model,''',''fig'')'])
            eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\pictures\','k_diffCompositions_',names_matrix{2,1},'_',fileName_model,''',''png'')'])
            eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\vector_graphs\','k_diffCompositions_',names_matrix{2,1},'_',fileName_model,''',''epsc'')'])
            try
                eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\vector_graphs\','k_diffCompositions_',names_matrix{2,1},'_',fileName_model,''',''emf'')'])
            catch
                disp('emf not possible')
            end
        elseif isunix
            eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/','k_diffCompositions_',names_matrix{2,1},'_',fileName_model,''',''fig'')'])
            eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/pictures/','k_diffCompositions_',names_matrix{2,1},'_',fileName_model,''',''png'')'])
            eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/vector_graphs/','k_diffCompositions_',names_matrix{2,1},'_',fileName_model,''',''epsc'')'])
            try
                eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/vector_graphs/','k_diffCompositions_',names_matrix{2,1},'_',fileName_model,''',''emf'')'])
            catch
                disp('emf not possible')
            end
        else
            disp('Platform not supported')
        end
        close(figure(gcf))
        clear fig
        clear ratio_conductiveAdditive_binder legend_thermalConductivity
        fprintf([num2str(ii),'-2-2.',' ','End of plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',names_matrix{2,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])

        % change in binder
        y_thermalConductivity = zeros(1 / deltaX + 1,1);
        fig = figure;
        set(fig,'Unit','normalized','Position',[0.1,0.1,0.35,0.65])
        hold on
        legend_thermalConductivity = cell(size(5,1),1);    
        fprintf([num2str(ii),'-2-3.',' ','Start to plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',names_matrix{3,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
        ratio_activeMaterial_conductiveAdditive = massFractions_matrix(1,1) / sum(massFractions_matrix(1:2,1));
        for qq = qqInterval
            try
                fprintf([num2str(ii),'-2-3.',num2str(qq - qqInterval(1,1) + 1),' ','Start to calculate the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' wt.%% ',names_matrix{3,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                massFractions_matrix_temporary = [(1 - (1 - sum(massFractions_matrix(1:2,1))) * (diff * qq + 1)) * ratio_activeMaterial_conductiveAdditive;...
                                                  (1 - (1 - sum(massFractions_matrix(1:2,1))) * (diff * qq + 1)) * (1 - ratio_activeMaterial_conductiveAdditive)];
                [volumeFractions_matrix,~] = fractionsMatrix_xPorosity_transfer(...
                names_matrix,massFractions_matrix_temporary,'none',0,1,0,0,0);
                f_thermalConductivity = @(x) k_model_out_of_name(...
                    names_matrix,volumeFractions_matrix,name_filler{1,1},x,name_model);
                for oo = 1 : 1 / deltaX + 1
                    try
                        y_thermalConductivity(oo,1) = f_thermalConductivity(x(oo,1));
                    catch
                        y_thermalConductivity(oo,1) = NaN;
                        fprintf([num2str(ii),'-2-3.',num2str(qq - qqInterval(1,1) + 1),' ','Start to calculate the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' wt.%% ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,' at x = ',num2str(x(oo,1)),'...\n\n'])
                    end
                end
                fprintf([num2str(ii),'-2-3.',num2str(qq - qqInterval(1,1) + 1),'.',' ','End of calculation of the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' wt.%% ',names_matrix{3,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                fprintf([num2str(ii),'-2-3.',num2str(qq - qqInterval(1,1) + 1),'.',' ','Start to plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' wt.%% ',names_matrix{3,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                plot(x,y_thermalConductivity,'LineWidth',1.5,'LineStyle',lineStyles{mod(qq - qqInterval(1,1),size(lineStyles,1)) + 1,1},...
                    'Color',colors{mod(qq - qqInterval(1,1),size(colors,1)) + 1,1})
                fprintf([num2str(ii),'-2-3.',num2str(qq - qqInterval(1,1) + 1),'.',' ','End of plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' wt.%% ',names_matrix{3,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                legend_thermalConductivity{qq - qqInterval(1,1) + 1,1} = [num2str(diff * 100 * qq),' wt.% ',names_matrix{3,1},': ',...
                                                                            '[',num2str(round(massFractions_matrix_temporary(1,1),4) * 100),' %,',...
                                                                                num2str(round(massFractions_matrix_temporary(2,1),4) * 100),' %,',...
                                                                                num2str(100 - round(massFractions_matrix_temporary(1,1),4) * 100 - round(massFractions_matrix_temporary(2,1),4) * 100),' %]'];
            catch
                fprintf([num2str(ii),'-2-3.',num2str(qq - qqInterval(1,1) + 1),'.',' ','Failed to plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing',num2str(diff * 100 * qq),' wt.%% ',names_matrix{3,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
            end
            fprintf([num2str(ii),'-2-3.',num2str(qq - qqInterval(1,1) + 1),'.',' ','End of plot of the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',names_matrix{3,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
            clear y_thermalConductivity f_thermalConductivity volumeFractions_matrix massFractions_matrix_temporary
        end
        clear qq    
        hold off
        grid on
        legend_thermalConductivity(cellfun(@isempty,legend_thermalConductivity)) = [];
        legend(legend_thermalConductivity)
        title({ 'effective thermal conductivity against porosity';...
                [' without ',name_currentCollector{ii,1},];...
                [  'for ',thisElectrode.name{1,1},' with ',legendName_filler{1,1},' for ',legendName_model];...
                ['(',   matrix{1,1}.name{1,1},' [',num2str(round(massFractions_matrix(1,1),4) * 100),' wt.%], '...
                        matrix{2,1}.name{1,1},' [',num2str(round(massFractions_matrix(2,1),4) * 100),' wt.%], '...
                        matrix{3,1}.name{1,1},' [',num2str(100 - 100 * sum(round(massFractions_matrix(1:2,1),4))),' wt.%]',')']})
         xlabel('\phi / -')
         ylabel('\lambda_{eff} / W/(m \cdot K)')
        % save
        if ispc
            eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\','k_diffCompositions_',names_matrix{3,1},'_',fileName_model,''',''fig'')'])
            eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\pictures\','k_diffCompositions_',names_matrix{3,1},'_',fileName_model,''',''png'')'])
            eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\vector_graphs\','k_diffCompositions_',names_matrix{3,1},'_',fileName_model,''',''epsc'')'])
            try
                eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\vector_graphs\','k_diffCompositions_',names_matrix{3,1},'_',fileName_model,''',''emf'')'])
            catch
                disp('emf not possible')
            end
        elseif isunix
            eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/','k_diffCompositions_',names_matrix{3,1},'_',fileName_model,''',''fig'')'])
            eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/pictures/','k_diffCompositions_',names_matrix{3,1},'_',fileName_model,''',''png'')'])
            eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/vector_graphs/','k_diffCompositions_',names_matrix{3,1},'_',fileName_model,''',''epsc'')'])
            try
                 eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/vector_graphs/','k_diffCompositions_',names_matrix{3,1},'_',fileName_model,''',''emf'')'])
            catch
                disp('emf not possible')
            end
        else
            disp('Platform not supported')
        end
        close(figure(gcf))
        clear fig
        clear ratio_activeMaterial_conductiveAdditive legend_thermalConductivity
        fprintf([num2str(ii),'-2-3.',' ','End of plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',names_matrix{3,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])

    clear diff qqInterval N x deltaX
    fprintf([num2str(ii),'.',' ','End of thermal conductivity of ',thisElectrode.name{1,1},' with differnt compositions...\n\n'])
    
    clear massFractions_matrix

    % changes in thermal conductivities
        thermalConductivities_matrix = zeros(3,1);
        for kk = 1 : 3
            thermalConductivities_matrix(kk,1) = matrix{kk,1}.thermalConductivity;
        end
        clear kk
        thermalConductivity_filler = filler.thermalConductivity;
        fprintf([num2str(ii),'-3.',' ','Start of thermal conductivity of ',thisElectrode.name{1,1},' with ',name_filler{1,1},'...\n\n'])
        deltaX = 0.01;
        x = (0:deltaX:1)';
        N = 5;
        qqInterval = linspace(-2,2,5);
        if ~all(qqInterval == fix(qqInterval)) || size(qqInterval,2) ~= N
            error(['Every element in qqInterval should be integer and the number of qqInterval should be ',num2str(N),'.'])
        end
        diff = 0.05;

    for pp = size(massFraction_activeMaterial,1) * size(ratio_conductiveAdditive_binder_all,1) + ii : size(massFraction_activeMaterial,1) * size(ratio_conductiveAdditive_binder_all,1) + ii% 1 : size(massFraction_activeMaterial,1) * size(ratio_conductiveAdditive_binder_all,1)
        massFractions_matrix_temporary = massFractions_matrix_all{pp,1};
        [volumeFractions_matrix,~] = fractionsMatrix_xPorosity_transfer(...
            names_matrix,massFractions_matrix_temporary,'none',0,1,0,0,0);
        fileName_composition = [names_matrix{1,1},nonNegativeDecimal_to_string(round(massFractions_matrix_temporary(1,1),4) * 100),...
                names_matrix{2,1},nonNegativeDecimal_to_string(round(massFractions_matrix_temporary(2,1),4) * 100),...
                names_matrix{3,1},nonNegativeDecimal_to_string(100 - 100 * sum(round(massFractions_matrix_temporary(1:2,1),4)))];
            
        if ispc
            if ~exist([currentFolder,'\','influences\',name_electrode{ii,1},'\',fileName_composition],'dir')
                mkdir(['influences\',name_electrode{ii,1},'\',fileName_composition])
            end
        elseif isunix
            if ~exist([currentFolder,'/','influences/',name_electrode{ii,1},'/',fileName_composition],'dir')
                mkdir(['influences/',name_electrode{ii,1},'/',fileName_composition])
            end
        else
            disp('Platform not supported')
        end
        if ispc
            if ~exist([currentFolder,'\','influences\',name_electrode{ii,1},'\',fileName_composition,'\pictures'],'dir')
                mkdir(['influences\',name_electrode{ii,1},'\',fileName_composition,'\pictures'])
            end
        elseif isunix
            if ~exist([currentFolder,'/','influences/',name_electrode{ii,1},'/',fileName_composition,'/pictures'],'dir')
                mkdir(['influences/',name_electrode{ii,1},'/',fileName_composition,'/pictures'])
            end
        else
            disp('Platform not supported')
        end
        if ispc
            if ~exist([currentFolder,'\','influences\',name_electrode{ii,1},'\',fileName_composition,'\vector_graphs'],'dir')
                mkdir(['influences\',name_electrode{ii,1},'\',fileName_composition,'\vector_graphs'])
            end
        elseif isunix
            if ~exist([currentFolder,'/','influences/',name_electrode{ii,1},'/',fileName_composition,'/vector_graphs'],'dir')
                mkdir(['influences/',name_electrode{ii,1},'/',fileName_composition,'/vector_graphs'])
            end
        else
            disp('Platform not supported')
        end         

        % change in active material
        y_thermalConductivity = zeros(1/deltaX + 1,1);
        fig = figure;
        set(fig,'Unit','normalized','Position',[0.1,0.1,0.35,0.65])
        hold on 
        legend_thermalConductivity = cell(size(N,1),1);    
        fprintf([num2str(ii),'-3-1-',num2str(pp),'.',' ','Start to plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
        for qq = qqInterval
            try
                fprintf([num2str(ii),'-3-1-',num2str(pp),'.',num2str(qq - qqInterval(1,1) + 1),' ','Start to calculate the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' %% k ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                f_thermalConductivity = @(x) k_model_out_of_name_calculator(...
                                [thermalConductivities_matrix(1,1) * (1 + diff * qq);thermalConductivities_matrix(2,1);thermalConductivities_matrix(3,1)],volumeFractions_matrix,thermalConductivity_filler,x,name_model);
                for oo = 1:1/deltaX + 1
                    try
                        y_thermalConductivity(oo,1) = f_thermalConductivity(x(oo,1));
                    catch
                        y_thermalConductivity(oo,1) = NaN;
                        fprintf([num2str(ii),'-3-1-',num2str(pp),'.',num2str(qq - qqInterval(1,1) + 1),' ','Failed to calculate the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' %% k ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,' at x = ',num2str(x(oo,1)),'...\n\n'])
                    end
                end
                fprintf([num2str(ii),'-3-1-',num2str(pp),'.',num2str(qq - qqInterval(1,1) + 1),'.',' ','End of calculation of the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' %% k ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                fprintf([num2str(ii),'-3-1-',num2str(pp),'.',num2str(qq - qqInterval(1,1) + 1),'.',' ','Start to plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' %% k ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                plot(x,y_thermalConductivity,'LineWidth',1.5,'LineStyle',lineStyles{mod(qq - qqInterval(1,1),size(lineStyles,1)) + 1,1},...
                    'Color',colors{mod(qq - qqInterval(1,1),size(colors,1)) + 1,1})
                fprintf([num2str(ii),'-3-1-',num2str(pp),'.',num2str(qq - qqInterval(1,1) + 1),'.',' ','End of plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' %% l ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                legend_thermalConductivity{qq - qqInterval(1,1) + 1,1} = [num2str(diff * 100 * qq),' % k of ',names_matrix{1,1},': ',...
                                                        '[',num2str(round(thermalConductivities_matrix(1,1) * (1 + diff * qq),2)),',',...
                                                        num2str(round(thermalConductivities_matrix(2,1),2)),',',...
                                                        num2str(round(thermalConductivities_matrix(3,1),2)),']'];
                title_str = { 'effective thermal conductivity against porosity';...
                [' without ',name_currentCollector{ii,1},];...
                [  'for ',thisElectrode.name{1,1},' with ',legendName_filler{1,1},' for ',legendName_model];...
                ['(',   matrix{1,1}.name{1,1},' [',num2str(round(massFractions_matrix_temporary(1,1),4) * 100),' wt.%], '...
                        matrix{2,1}.name{1,1},' [',num2str(round(massFractions_matrix_temporary(2,1),4) * 100),' wt.%], '...
                        matrix{3,1}.name{1,1},' [',num2str(100 - 100 * sum(round(massFractions_matrix_temporary(1:2,1),4))),' wt.%]',')']};
            catch
                fprintf([num2str(ii),'-3-1-',num2str(pp),'.',num2str(qq - qqInterval(1,1) + 1),'.',' ','Failed to plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' %% k ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
            end
            clear y_thermalConductivity f_thermalConductivity
        end
        clear qq
        fprintf([num2str(ii),'-3-1-',num2str(pp),'.',' ','End of plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
        hold off
        grid on
        legend_thermalConductivity(cellfun(@isempty,legend_thermalConductivity)) = [];
        legend(legend_thermalConductivity)
        title(title_str)
        xlabel('\phi / -')
        ylabel('\lambda_{eff} / W/(m \cdot K)')
        % save       
        if ispc
            eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\',fileName_composition,'\','k_diffKs_',fileName_composition,'_',names_matrix{1,1},''',''fig'')'])
            eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\',fileName_composition,'\pictures\','k_diffKs_',fileName_composition,'_',names_matrix{1,1},''',''png'')'])
            eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\',fileName_composition,'\vector_graphs\','k_diffKs_',fileName_composition,'_',names_matrix{1,1},''',''epsc'')'])
            try
                eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\',fileName_composition,'\vector_graphs\','k_diffKs_',fileName_composition,'_',names_matrix{1,1},''',''emf'')'])
            catch
                disp('emf not possible')
            end
        elseif isunix
            eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/',fileName_composition,'/','k_diffKs_',fileName_composition,'_',names_matrix{1,1},''',''fig'')'])
            eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/',fileName_composition,'/pictures/','k_diffKs_',fileName_composition,'_',names_matrix{1,1},''',''png'')'])
            eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/',fileName_composition,'/vector_graphs/','k_diffKs_',fileName_composition,'_',names_matrix{1,1},''',''epsc'')'])
            try
                eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/',fileName_composition,'/vector_graphs/','k_diffKs_',fileName_composition,'_',names_matrix{1,1},''',''emf'')'])
            catch
                disp('emf not possible')
            end
        else
            disp('Platform not supported')
        end
        close(figure(gcf))
        clear fig
        clear legend_thermalConductivity
        fprintf([num2str(ii),'-3-1-',num2str(pp),'.',' ','End of plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])

    % change in conductive additive
            y_thermalConductivity = zeros(1/deltaX + 1,1);
            fig = figure;
            set(fig,'Unit','normalized','Position',[0.1,0.1,0.35,0.65])
            hold on 
            legend_thermalConductivity = cell(size(N,1),1);    
            fprintf([num2str(ii),'-3-2-',num2str(pp),'.',' ','Start to plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',names_matrix{2,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
            for qq = qqInterval
                try
                    fprintf([num2str(ii),'-3-2-',num2str(pp),'.',num2str(qq - qqInterval(1,1) + 1),' ','Start to calculate the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' %% k ',names_matrix{2,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                    f_thermalConductivity = @(x) k_model_out_of_name_calculator(...
                                    [thermalConductivities_matrix(1,1);thermalConductivities_matrix(2,1) * (1 + diff * qq);thermalConductivities_matrix(3,1)],volumeFractions_matrix,thermalConductivity_filler,x,name_model);
                    for oo = 1:1/deltaX + 1
                        try
                            y_thermalConductivity(oo,1) = f_thermalConductivity(x(oo,1));
                        catch
                            y_thermalConductivity(oo,1) = NaN;
                            fprintf([num2str(ii),'-3-2-',num2str(pp),'.',num2str(qq - qqInterval(1,1) + 1),' ','Failed to calculate the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' %% k ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,' at x = ',num2str(x(oo,1)),'...\n\n'])
                        end
                    end
                    fprintf([num2str(ii),'-3-2-',num2str(pp),'.',num2str(qq - qqInterval(1,1) + 1),'.',' ','End of calculation of the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' %% k ',names_matrix{2,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                    fprintf([num2str(ii),'-3-2-',num2str(pp),'.',num2str(qq - qqInterval(1,1) + 1),'.',' ','Start to plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' %% k ',names_matrix{2,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                    plot(x,y_thermalConductivity,'LineWidth',1.5,'LineStyle',lineStyles{mod(qq - qqInterval(1,1),size(lineStyles,1)) + 1,1},...
                        'Color',colors{mod(qq - qqInterval(1,1),size(colors,1)) + 1,1})
                    fprintf([num2str(ii),'-3-2-',num2str(pp),'.',num2str(qq - qqInterval(1,1) + 1),'.',' ','End of plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' %% l ',names_matrix{2,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                    legend_thermalConductivity{qq - qqInterval(1,1) + 1,1} = [num2str(diff * 100 * qq),' % k of ',names_matrix{2,1},': ',...
                                                            '[',num2str(round(thermalConductivities_matrix(1,1),2)),',',...
                                                            num2str(round(thermalConductivities_matrix(2,1) * (1 + diff * qq),2)),',',...
                                                            num2str(round(thermalConductivities_matrix(3,1),2)),']'];
                    title_str = { 'effective thermal conductivity against porosity';...
                    [' without ',name_currentCollector{ii,1},];...
                    [  'for ',thisElectrode.name{1,1},' with ',legendName_filler{1,1},' for ',legendName_model];...
                    ['(',   matrix{1,1}.name{1,1},' [',num2str(round(massFractions_matrix_temporary(1,1),4) * 100),' wt.%], '...
                            matrix{2,1}.name{1,1},' [',num2str(round(massFractions_matrix_temporary(2,1),4) * 100),' wt.%], '...
                            matrix{3,1}.name{1,1},' [',num2str(100 - 100 * sum(round(massFractions_matrix_temporary(1:2,1),4))),' wt.%]',')']};
                catch
                    fprintf([num2str(ii),'-3-2-',num2str(pp),'.',num2str(qq - qqInterval(1,1) + 1),'.',' ','Failed to plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' %% k ',names_matrix{2,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                end
                clear y_thermalConductivity f_thermalConductivity 
            end
            clear qq
            fprintf([num2str(ii),'-3-2-',num2str(pp),'.',' ','End of plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',names_matrix{2,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
            hold off
            grid on
            legend_thermalConductivity(cellfun(@isempty,legend_thermalConductivity)) = [];
            legend(legend_thermalConductivity)
            title(title_str)
            xlabel('\phi / -')
            ylabel('\lambda_{eff} / W/(m \cdot K)')
            % save       
            if ispc
                eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\',fileName_composition,'\','k_diffKs_',fileName_composition,'_',names_matrix{2,1},''',''fig'')'])
                eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\',fileName_composition,'\pictures\','k_diffKs_',fileName_composition,'_',names_matrix{2,1},''',''png'')'])
                eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\',fileName_composition,'\vector_graphs\','k_diffKs_',fileName_composition,'_',names_matrix{2,1},''',''epsc'')'])
                try
                    eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\',fileName_composition,'\vector_graphs\','k_diffKs_',fileName_composition,'_',names_matrix{2,1},''',''emf'')'])
                catch
                    disp('emf not possible')
                end
            elseif isunix
                eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/',fileName_composition,'/','k_diffKs_',fileName_composition,'_',names_matrix{2,1},''',''fig'')'])
                eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/',fileName_composition,'/pictures/','k_diffKs_',fileName_composition,'_',names_matrix{2,1},''',''png'')'])
                eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/',fileName_composition,'/vector_graphs/','k_diffKs_',fileName_composition,'_',names_matrix{2,1},''',''epsc'')'])
                try
                    eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/',fileName_composition,'/vector_graphs/','k_diffKs_',fileName_composition,'_',names_matrix{2,1},''',''emf'')'])
                catch
                    disp('emf not possible')
                end
            else
                disp('Platform not supported')
            end
            close(figure(gcf))
            clear fig
            clear legend_thermalConductivity     
            fprintf([num2str(ii),'-3-2-',num2str(pp),'.',' ','End of plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',names_matrix{2,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
        
        % change in binder
            y_thermalConductivity = zeros(1/deltaX + 1,1);
            fig = figure;
            set(fig,'Unit','normalized','Position',[0.1,0.1,0.35,0.65])
            hold on 
            legend_thermalConductivity = cell(size(N,1),1);    
            fprintf([num2str(ii),'-3-3-',num2str(pp),'.',' ','Start to plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',names_matrix{3,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
            for qq = qqInterval
                try
                    fprintf([num2str(ii),'-3-3-',num2str(pp),'.',num2str(qq - qqInterval(1,1) + 1),' ','Start to calculate the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' %% k ',names_matrix{3,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                    f_thermalConductivity = @(x) k_model_out_of_name_calculator(...
                                    [thermalConductivities_matrix(1,1);thermalConductivities_matrix(2,1);thermalConductivities_matrix(3,1) * (1 + diff * qq)],volumeFractions_matrix,thermalConductivity_filler,x,name_model);
                    for oo = 1:1/deltaX + 1
                        try
                            y_thermalConductivity(oo,1) = f_thermalConductivity(x(oo,1));
                        catch
                            y_thermalConductivity(oo,1) = NaN;
                            fprintf([num2str(ii),'-3-3-',num2str(pp),'.',num2str(qq - qqInterval(1,1) + 1),' ','Failed to calculate the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' %% k ',names_matrix{1,1},') with ',name_filler{1,1},' for ',legendName_model,' at x = ',num2str(x(oo,1)),'...\n\n'])
                        end
                    end
                    fprintf([num2str(ii),'-3-3-',num2str(pp),'.',num2str(qq - qqInterval(1,1) + 1),'.',' ','End of calculation of the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' %% k ',names_matrix{3,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                    fprintf([num2str(ii),'-3-3-',num2str(pp),'.',num2str(qq - qqInterval(1,1) + 1),'.',' ','Start to plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' %% k ',names_matrix{3,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                    plot(x,y_thermalConductivity,'LineWidth',1.5,'LineStyle',lineStyles{mod(qq - qqInterval(1,1),size(lineStyles,1)) + 1,1},...
                        'Color',colors{mod(qq - qqInterval(1,1),size(colors,1)) + 1,1})
                    fprintf([num2str(ii),'-3-3-',num2str(pp),'.',num2str(qq - qqInterval(1,1) + 1),'.',' ','End of plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' %% l ',names_matrix{3,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                    legend_thermalConductivity{qq - qqInterval(1,1) + 1,1} = [num2str(diff * 100 * qq),' % k of ',names_matrix{3,1},': ',...
                                                            '[',num2str(round(thermalConductivities_matrix(1,1)),2),',',...
                                                            num2str(round(thermalConductivities_matrix(2,1),2)),',',...
                                                            num2str(round(thermalConductivities_matrix(3,1) * (1 + diff * qq),2)),']'];
                    title_str = { 'effective thermal conductivity against porosity';...
                    [' without ',name_currentCollector{ii,1},];...
                    [  'for ',thisElectrode.name{1,1},' with ',legendName_filler{1,1},' for ',legendName_model];...
                    ['(',   matrix{1,1}.name{1,1},' [',num2str(round(massFractions_matrix_temporary(1,1),4) * 100),' wt.%], '...
                            matrix{2,1}.name{1,1},' [',num2str(round(massFractions_matrix_temporary(2,1),4) * 100),' wt.%], '...
                            matrix{3,1}.name{1,1},' [',num2str(100 - 100 * sum(round(massFractions_matrix_temporary(1:2,1),4))),' wt.%]',')']};
                catch
                    fprintf([num2str(ii),'-3-3-',num2str(pp),'.',num2str(qq - qqInterval(1,1) + 1),'.',' ','Failed to plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',num2str(diff * 100 * qq),' %% k ',names_matrix{3,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
                end
                clear y_thermalConductivity f_thermalConductivity 
            end
            clear qq
            fprintf([num2str(ii),'-3-3-',num2str(pp),'.',' ','End of plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',names_matrix{3,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n'])
            hold off
            grid on
            legend_thermalConductivity(cellfun(@isempty,legend_thermalConductivity)) = [];
            legend(legend_thermalConductivity)
            title(title_str)
            xlabel('\phi / -')
            ylabel('\lambda_{eff} / W/(m \cdot K)')
            % save       
            if ispc
                eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\',fileName_composition,'\','k_diffKs_',fileName_composition,'_',names_matrix{3,1},''',''fig'')'])
                eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\',fileName_composition,'\pictures\','k_diffKs_',fileName_composition,'_',names_matrix{3,1},''',''png'')'])
                eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\',fileName_composition,'\vector_graphs\','k_diffKs_',fileName_composition,'_',names_matrix{3,1},''',''epsc'')'])
                try
                    eval(['saveas(gcf,''','influences\',name_electrode{ii,1},'\',fileName_composition,'\vector_graphs\','k_diffKs_',fileName_composition,'_',names_matrix{3,1},''',''emf'')'])
                catch
                    disp('emf not possible')
                end
            elseif isunix
                eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/',fileName_composition,'/','k_diffKs_',fileName_composition,'_',names_matrix{3,1},''',''fig'')'])
                eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/',fileName_composition,'/pictures/','k_diffKs_',fileName_composition,'_',names_matrix{3,1},''',''png'')'])
                eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/',fileName_composition,'/vector_graphs/','k_diffKs_',fileName_composition,'_',names_matrix{3,1},''',''epsc'')'])
                try
                    eval(['saveas(gcf,''','influences/',name_electrode{ii,1},'/',fileName_composition,'/vector_graphs/','k_diffKs_',fileName_composition,'_',names_matrix{3,1},''',''emf'')'])
                catch
                    disp('emf not possible')
                end
            else
                disp('Platform not supported')
            end
            close(figure(gcf))
            clear fig
            clear legend_thermalConductivity     
            fprintf([num2str(ii),'-3-3-',num2str(pp),'.',' ','End of plot the effective thermal conductivity of ',thisElectrode.name{1,1},' (changing ',names_matrix{2,1},') with ',name_filler{1,1},' for ',legendName_model,'...\n\n']) 

        clear fileName_composition
    end
    clear pp
    clear volumeFractions_matrix massFractions_matrix_temporary
    clear diff qqInterval N x deltaX
    
    fprintf([num2str(ii),'-3.',' ','End of thermal conductivity of ',thisElectrode.name{1,1},' with ',name_filler{1,1},'...\n\n'])
   
    fprintf([num2str(ii),'.',' ','End of ',name_electrode{ii,1},':\n\n'])
end
clear ii
fprintf('End of Part 3.\n\n\n')
% -------------------------------------------------- Core PART BEGIN --------------------------------------------------

clear currentFolder
%% Part 4: Percolation model and Maxwell-Euken model with f = 3.2 for different carbon black - PVDF ratio
clear
currentFolder = pwd;
fprintf('Start of Part 4...\n\n\n')
load tables electrode statistics
% -------------------------------------------------- INPUT BEGIN --------------------------------------------------
names_matrix = {'PVDF'};
name_filler = 'carbonBlack';
titleNames_matrix = {'PVDF'};
titleName_filler = 'carbon black';
names_model = {'percolationModel,kc=0.3,vc=0.15,nExp=0.51';'MEM_1,f=3.2'};
legendNames_model = {'percolation,k_{c}=0.44,v_{c}=0.15,n=0.51';'Maxwell-Euken,f=3.2'}; % nn
% -------------------------------------------------- INPUT   END --------------------------------------------------

lineStyles = {'-';'--';'-.';':'};
colors = {  [106,90,205]/255;   [255,69,0]/255;     [56,94,15]/255;     [0,255,127]/255;    [128,42,42]/255;...
            [255,215,0]/255;    [250,128,114]/255;  [30,144,255]/255;   [255,0,255]/255;    [50,205,50]/255;...
            [65,105,255]/255;   [227,23,13]/255;    [12,23,70]/255;     [115,74,18]/255; 	[176,48,96]/255};
if ispc
    if ~exist([currentFolder,'\','binarySystem'],'dir')
        mkdir('binarySystem')
    end
elseif isunix
    if ~exist([currentFolder,'/','binarySystem'],'dir')
        mkdir('binarySystem')
    end
else
    
end
    
if ispc
    if ~exist([currentFolder,'\','binarySystem\pictures'],'dir')
        mkdir('binarySystem\pictures')
    end
elseif isunix
    if ~exist([currentFolder,'/','binarySystem/pictures'],'dir')
        mkdir('binarySystem/pictures')
    end
else
    disp('Platform not supported')
end
if ispc
    if ~exist([currentFolder,'\','binarySystem\vector_graphs'],'dir')
        mkdir('binarySystem\vector_graphs')
    end
elseif isunix
    if ~exist([currentFolder,'/','binarySystem/vector_graphs'],'dir')
        mkdir('binarySystem/vector_graphs')
    end
else
    disp('Platform not supported')
end
fig = figure;
set(fig,'Unit','normalized','Position',[0.1,0.1,0.35,0.65])
legend_thermalConductivity = cell(size(names_model,1),1);
M = 1000;
hold on
x = linspace(0,1,M)';   % mass fraction of filler
porosity = zeros(M,1);
for kk = 1 : M
    [~,porosity(kk,1)] = fractionsMatrix_xPorosity_transfer(...
        names_matrix,1,name_filler,x(kk,1),1,1,0,0);
end
clear kk
fprintf(['Start to plot thermal conductivity of ',titleNames_matrix{1,1},' - ',titleName_filler,' system in mass fraction...\n\n']) 

% -------------------------------------------------- CORE PART BEGIN --------------------------------------------------
for nn = 1 : size(names_model,1)
    try
        fprintf([num2str(nn),'.',' ','Start to calculate the thermal conductivity of ',titleNames_matrix{1,1},' - ',titleName_filler,' system for ',legendNames_model{nn,1},' in mass fraction...\n\n'])  
        f_thermalConductivity = @(porosity) k_model_out_of_name(...
            names_matrix,1,name_filler,porosity,names_model{nn,1});
        y_thermalConductivity = arrayfun(f_thermalConductivity,porosity);
        fprintf([num2str(nn),'.',' ','End of calculation of the thermal conductivity of ',titleNames_matrix{1,1},' - ',titleName_filler,' system for ',legendNames_model{nn,1},' in mass fraction...\n\n'])
        fprintf([num2str(nn),'.',' ','Start to plot the thermal conductivity of ',titleNames_matrix{1,1},' - ',titleName_filler,' system for ',legendNames_model{nn,1},' in mass fraction...\n\n'])
        plot(x,y_thermalConductivity,'LineWidth',1.5,'LineStyle',lineStyles{mod(nn - 1,size(lineStyles,1)) + 1,1},...
                'Color',colors{mod(nn - 1,size(colors,1)) + 1,1})
        fprintf([num2str(nn),'.',' ','End of plot the thermal conductivity of ',titleNames_matrix{1,1},' - ',titleName_filler,' system for ',legendNames_model{nn,1},' in mass fraction...\n\n'])
        legend_thermalConductivity{nn,1} = legendNames_model{nn,1};
    catch
        fprintf([num2str(nn),'.',' ','Failed to plot the thermal conductivity of ',titleNames_matrix{1,1},' - ',titleName_filler,' system for ',legendNames_model{nn,1},' in mass fraction...\n\n'])
    end
    clear y_thermalConductivity f_thermalConductivity
end
clear nn
grid on
legend_thermalConductivity(cellfun(@isempty,legend_thermalConductivity)) = [];
legend(legend_thermalConductivity)
title({ 'effective thermal conductivity against porosity';...
        'of binary system in mass fraction';...
        [titleNames_matrix{1,1},' - ',titleName_filler];...
        })
 xlabel([titleName_filler,' wt.%'])
 ylabel('\lambda_{eff} / W/(m \cdot K)')
% save
if ispc
    eval(['saveas(gcf,''','binarySystem\','k_binarySystem_',names_matrix{1,1},'_',name_filler,'_M',''',''fig'')'])
    eval(['saveas(gcf,''','binarySystem\pictures\','k_binarySystem_',names_matrix{1,1},'_',name_filler,'_M',''',''png'')'])
    eval(['saveas(gcf,''','binarySystem\vector_graphs\','k_binarySystem_',names_matrix{1,1},'_',name_filler,'_M',''',''epsc'')'])
    try
        eval(['saveas(gcf,''','binarySystem\vector_graphs\','k_binarySystem_',names_matrix{1,1},'_',name_filler,'_M',''',''emf'')'])
    catch
        disp('emf not possible')
    end
elseif isunix
    eval(['saveas(gcf,''','binarySystem/','k_binarySystem_',names_matrix{1,1},'_',name_filler,'_M',''',''fig'')'])
    eval(['saveas(gcf,''','binarySystem/pictures/','k_binarySystem_',names_matrix{1,1},'_',name_filler,'_M',''',''png'')'])
    eval(['saveas(gcf,''','binarySystem/vector_graphs/','k_binarySystem_',names_matrix{1,1},'_',name_filler,'_M',''',''epsc'')'])
    try
        eval(['saveas(gcf,''','binarySystem/vector_graphs/','k_binarySystem_',names_matrix{1,1},'_',name_filler,'_M',''',''emf'')'])
    catch
        disp('emf not possible')
    end
else
    disp('Platform not supported')
end
close(figure(gcf))
clear fig h
fprintf(['End of plot of thermal conductivity of ',titleNames_matrix{1,1},' - ',name_filler,' system in mass fraction...\n\n'])       

clear porosity x legend_thermalConductivity

fig = figure;
set(fig,'Unit','normalized','Position',[0.1,0.1,0.35,0.65])
legend_thermalConductivity = cell(size(names_model,1),1);
M = 100;
hold on
x = linspace(0,1,M)';   % volume fraction of filler
fprintf(['Start to plot thermal conductivity of ',titleNames_matrix{1,1},' - ',titleName_filler,' system in volume fraction...\n\n'])       
for nn = 1 : size(names_model,1)
    try
        fprintf([num2str(nn),'.',' ','Start to calculate the thermal conductivity of ',titleNames_matrix{1,1},' - ',titleName_filler,' system for ',legendNames_model{nn,1},' in volume fraction...\n\n'])  
        f_thermalConductivity = @(x) k_model_out_of_name(...
            names_matrix,1,name_filler,x,names_model{nn,1});
        y_thermalConductivity = arrayfun(f_thermalConductivity,x);
        fprintf([num2str(nn),'.',' ','End of calculation of the thermal conductivity of ',titleNames_matrix{1,1},' - ',titleName_filler,' system for ',legendNames_model{nn,1},' in volume fraction...\n\n'])
        fprintf([num2str(nn),'.',' ','Start to plot the thermal conductivity of ',titleNames_matrix{1,1},' - ',titleName_filler,' system for ',legendNames_model{nn,1},' in volume fraction...\n\n'])
        plot(x,y_thermalConductivity,'LineWidth',1.5,'LineStyle',lineStyles{mod(nn - 1,size(lineStyles,1)) + 1,1},...
                'Color',colors{mod(nn - 1,size(colors,1)) + 1,1})
        fprintf([num2str(nn),'.',' ','End of plot the thermal conductivity of ',titleNames_matrix{1,1},' - ',titleName_filler,' system for ',legendNames_model{nn,1},' in volume fraction...\n\n'])
        legend_thermalConductivity{nn,1} = legendNames_model{nn,1};
    catch
        fprintf([num2str(nn),'.',' ','Failed to plot the thermal conductivity of ',titleNames_matrix{1,1},' - ',titleName_filler,' system for ',legendNames_model{nn,1},' in volume fraction...\n\n'])
    end
    clear y_thermalConductivity f_thermalConductivity
end
clear nn
grid on
legend_thermalConductivity(cellfun(@isempty,legend_thermalConductivity)) = [];
legend(legend_thermalConductivity)
title({ 'effective thermal conductivity against porosity';...
        'of binary system in volume fraction';...
        [titleNames_matrix{1,1},' - ',titleName_filler];...
        })
 xlabel([titleName_filler,' vol.%'])
 ylabel('\lambda_{eff} / W/(m \cdot K)')
% save
if ispc
    eval(['saveas(gcf,''','binarySystem\','k_binarySystem_',names_matrix{1,1},'_',name_filler,'_V',''',''fig'')'])
    eval(['saveas(gcf,''','binarySystem\pictures\','k_binarySystem_',names_matrix{1,1},'_',name_filler,'_V',''',''png'')'])
    eval(['saveas(gcf,''','binarySystem\vector_graphs\','k_binarySystem_',names_matrix{1,1},'_',name_filler,'_V',''',''epsc'')'])
    try
        eval(['saveas(gcf,''','binarySystem\vector_graphs\','k_binarySystem_',names_matrix{1,1},'_',name_filler,'_V',''',''emf'')'])
    catch
        disp('emf not possible')
    end
elseif isunix
    eval(['saveas(gcf,''','binarySystem/','k_binarySystem_',names_matrix{1,1},'_',name_filler,'_V',''',''fig'')'])
    eval(['saveas(gcf,''','binarySystem/pictures/','k_binarySystem_',names_matrix{1,1},'_',name_filler,'_V',''',''png'')'])
    eval(['saveas(gcf,''','binarySystem/vector_graphs/','k_binarySystem_',names_matrix{1,1},'_',name_filler,'_V',''',''epsc'')'])
    try
        eval(['saveas(gcf,''','binarySystem/vector_graphs/','k_binarySystem_',names_matrix{1,1},'_',name_filler,'_V',''',''emf'')'])
    catch
        disp('emf not possible')
    end
else
    disp('Platform not supported')
end
close(figure(gcf))
clear fig
fprintf(['End of plot of thermal conductivity of ',titleNames_matrix{1,1},' - ',name_filler,' system in volume fraction...\n\n'])       

clear porosity x legend_thermalConductivity

fprintf('End of Part 4.\n\n\n')

% -------------------------------------------------- CORE PART   END --------------------------------------------------
clear currentFolder
