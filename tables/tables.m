%%
clear

%% Table for parameters of pure materials
statistics   =   table(                     [],             [],                     [],             [],                     [],             {},                 {},                                 {},...
                            'VariableNames',...
                                        {   'temperature',  'thermalConductivity',  'heatCapacity', 'thermalDiffusivity',   'density',      'stateOfMatter',    'remark',                           'name',                        });
    statistics.Properties.VariableUnits =    ...
                                        {   'degree C',     'W/(m * K)',            'J/(g * K)',    'm^2/s',                'g/cm^3',       '',                 '',                                 '',};
    % different materials are listed in the followings
    statistics('graphiteParallel',:) =      {   25,             167.36,                 0.7151502,      NaN,                    2.26,           'solid',            'anode active material',        'parallel graphite' };
    statistics('graphiteVertical',:) =      {   25,             109.86,                 0.7151502,      NaN,                    2.26,           'solid',            'anode active material',        'vertical graphite' };
    statistics('graphite',:)         =      {   25,             138.61,                 0.7151502,      NaN,                    2.26,           'solid',            'anode active material',        'graphite'          };    
    statistics('LCO',:)              =      {   25,             6,                      0.725486189,    NaN,                    4.6,            'solid',            'cathode active material',      'LCO'               };
    statistics('NMC',:)              =      {   25,             4.3,                    0.7239,         2.2e-7,                 4.68,           'solid',            'cathode active material',      'NMC'               };                   
    statistics('LMO',:)              =      {   25,             233.1301086,            0.812433945,    6.72178e-5,             4.269,          'solid',            'cathode active material',      'LMO'               };
    statistics('LPF',:)              =      {   25,             NaN,                    NaN,            NaN,                    nan,            'solid',            'cathode active material',      'LFP'               };
    statistics('LP30',:)             =      {   25,             0.17685,                1.6575,         NaN,                    1.28636,        'liquid',           'electrolyte',                  'LP30'              };
    statistics('LP30_0P1',:)             =      {   25,             0.1,                1.6575,         NaN,                    1.28636,        'liquid',           'electrolyte',                  'LP30'              };
    statistics('LP30_0P3',:)             =      {   25,             0.3,                1.6575,         NaN,                    1.28636,        'liquid',           'electrolyte',                  'LP30'              };
    statistics('LP50',:)             =      {   25,             0.1741,                 1.6444,         NaN,                    1.2510,         'liquid',           'electrolyte',                  'LP50'              };
    statistics('DMC',:)              =      {   25,             0.1607,                 NaN,            NaN,                    NaN,            'liquid',           'electrolyte',                  'DMC'               };
    statistics('carbonBlack',:)      =      {   25,             23.8488,                0.65,           NaN,                    2.26,           'solid',            'conductive additive',          'carbon black'      };
    statistics('EC-600-JD',:)        =      {   23,             23.8488,                NaN,            NaN,                    1.8,            'solid',            'conductive additive',          'EC-600-JD'         };
    statistics('TC-300-inplane',:)   =      {   23,             600,                    NaN ,           NaN,                    2.24,           'solid',            'conductive additive',          'TC-300-inplane'    }; % SG
    statistics('Fortafil-243',:)     =      {   23,             20,                     NaN ,           NaN,                    1.74,           'solid',            'conductive additive',          'Fortafil-243'      }; % SG
    statistics('Al2O3',:)            =      {   NaN,            42.34,                  NaN ,           NaN,                    3.987,          'solid',            'conductive additive',          'Al2O3'             }; % 65 mum : 9 mum = 4 : 1
    statistics('SiO2',:)             =      {   NaN,            7.5,                    NaN ,           NaN,                    2.648,          'solid',            'conductive additive',          'SiO2'              }; % 65 mum : 9 mum = 4 : 1
    statistics('MWNT',:)             =      {   NaN,            3000,                   NaN ,           NaN,                    1.75,           'solid',            'conductive additive',          'MWNT'              }; % 65 mum : 9 mum = 4 : 1
    statistics('PVDF',:)             =      {   25,             0.196470588,            1.198827496,    7.66667e-08,            1.752941176,    'solid',            'binder',                       'PVDF'              };            
    statistics('pCBT',:)             =      {   25,             0.3182,                 NaN,            NaN,                    1.3,            'solid',            'binder',                       'pCBT'              };            
    statistics('PEO-300000',:)       =      {   25              0.14,                   NaN,            NaN,                    0.5,            'liquid',           'binder',                       'PEO-300000'        };
    statistics('PE',:)               =      {   NaN,            0.36,                   NaN,            NaN,                    0.92,           'liquid',           'binder',                       'PE'                };
    statistics('epoxy',:)            =      {   NaN,            0.242,                  NaN,            NaN,                    1.25,           'liquid',           'binder',                       'epoxy'             };
    statistics('PBT',:)              =      {   20,             0.255,                  NaN,            NaN,                    1.31,           'liquid',           'binder',                       'PBT'               };
    statistics('EVA',:)              =      {   NaN,            0.34,                   NaN,            NaN,                    0.965,          'liquid',           'binder',                       'EVA'               };
    statistics('PTFE',:)             =      {   NaN,            0.34,                   NaN,            NaN,                    2.2,            'liquid',           'binder',                       'PTFE'              };
    statistics('naturalRubber',:)    =      {   NaN,            0.1496,                 NaN,            NaN,                    0.93,           'liquid',           'binder',                       'natural rubber'    };
    statistics('EEA',:)              =      {   NaN,            0.25                    NaN,            NaN,                    0.93,           'liquid',           'binder',                       'EEA'               };
    statistics('PEBAX',:)            =      {   NaN,            0.22,                   NaN,            NaN,                    1,              'liquid',           'binder',                       'PEBAX'             };
    statistics('Vectra-A950RX',:)...
                                     =      {   23              1,                      NaN,            NaN,                    1.4,            'liquid',           'binder',                       'Vectra-A950RX'     };
    statistics('air',:)              =      {   25,             0.026,                  1.005,          1.9e-5,                 1.1839e-3,      'gas',              'filling gas',                  'air'               };
    statistics('N2',:)               =      {   25              0.02583,                1.039,          2.198e-5,               1.132e-3,       'gas',              'filling gas',                  'N2'                };
    statistics('He',:)               =      {   25              0.151,                  5.1932,         1.9e-4,                 0.1664e-3,      'gas',              'filling gas',                  'He'                };
    statistics('CO2',:)              =      {   25              0.0166,                 0.846,          9.9e-6,                 1.98e-3,        'gas',              'filling gas',                  'CO2'               };
    statistics('copper',:)           =      {   25              398,                    0.385,          1.16e-4,                8.933,          'solid',            'current collector',            'copper'            };
    statistics('aluminium',:)        =      {   25              238,                    0.903,          9.98e-5,                2.702,          'solid',            'current collector',            'aluminium'         };
    
    
    statistics.Properties.Description    =   'This table contains several parameters of various materials which will be applied in lithium ion batteries.';
    statistics.Properties.DimensionNames =   {'materials','parameters'};

writetable(statistics,'statistics.xlsx')
%% Table for morphology of matrix materials of electrode in mass fraction
electrode	=   table(                              {},                                     {},                                     {},                                     [],                                 [],                                     [],                         [],             {},...
                            'VariableNames',...
                                    {               'activeMaterialStatistics',             'conductiveAdditiveStatistics',         'binderStatistics',                     'activeMaterialSolidMassFraction',  'conductingAdditiveSolidMassFraction',  'binderSolidMassFraction',  'porosity',     'name'});
    electrode.Properties.VariableUnits =    ...
                                    {               '',                                     '',                                     '',                                     'g/g',                              'g/g',                                  'g/g',                      '-',            '',     };
    % different electrodes are listed in the followings
    electrode('graphiteParallelAnode',:)    = {     'graphiteParallel',                     'carbonBlack',                          'PVDF',                                 0.918,                              0.028,                                  0.054,                      0.54,           'parallel graphite anode'   };
    electrode('graphiteVerticalAnode',:)    = {     'graphiteVertical',                     'carbonBlack',                          'PVDF',                                 0.918,                              0.028,                                  0.054,                      0.54,           'vertical graphite anode'   };
    electrode('graphiteAnode',:)            = {     'graphite',                             'carbonBlack',                          'PVDF',                                 0.918,                              0.028,                                  0.054,                      0.54,           'graphite anode'            };
    electrode('LCOCathode',:)               = {     'LCO',                                  'carbonBlack',                          'PVDF',                                 0.9,                                0.06,                                   0.04,                       0.36,           'LCO cathode'               };
    electrode('NMCCathode',:)               = {     'NMC',                                  'carbonBlack',                          'PVDF',                                 0.9,                                0.06,                                   0.04,                       0.36,           'NMC cathode'               };
    electrode('LMOCathode',:)               = {     'LMO',                                  'carbonBlack',                          'PVDF',                                 0.9,                                0.06,                                   0.04,                       0.30\6,           'LMO cathode'               };
    
    
    
    
    electrode.Properties.Description    =   'This table contains morphology of electrodes based on solid materials in weight percentage.';  
    electrode.Properties.DimensionNames =   {'eledtrodes','information'};

writetable(electrode,'electrode.xlsx')

%% Table for depencenes of some physical quantities
dependence  =   table(                          {},             {},             {},             {},             {},             {},             {},             {},                 [],...
                            'VariableNames',...
                                    {           'material',     'xName',        'yName',        'xValues',      'yValues',      'xUnit',        'yUnit',        'functionHandle',   'fractionPorosityMode'});
    dependence.Properties.VariableUnits =   ... 
                                    {           '',             '',              '',             '-',           '-',            '',             '',             '',                 '-'};
    % different dependences are listed in the followings
    
    % ====================================================================================================================================================================================
        
    % temperature - density part
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    xValues             = [12.38;      24.22;      35.97];
    yValues         	= [2.27855;    2.28105;    2.27717];
    functionHandle   	= @(T) (-0.0583 * T + 2280.3 ) / 1000;
    dependence('graphite_temperature_density',:)...
                                    =    {      'graphite',     'temperature',  'density',      xValues,        yValues,        'degree C',     'g/cm^3',       functionHandle,     0};
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    xValues          	= {27};
    yValues           	= {4.68};
    functionHandle      = @(T)  4.68;
    dependence('NMC_temperature_density',:)...
                                    =    {      'NMC',          'temperature',  'density',      xValues,       	yValues,    	'degree C',     'g/cm^3',       functionHandle,     0};
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    xValues             = {27};
    yValues             = {5.05};
    functionHandle      = @(T)  5.05;
    dependence('LCO_temperature_density',:)...
                                    =    {      'LCO',          'temperature',  'density',      xValues,     	yValues	,      	'degree C',     'g/cm^3',       functionHandle,     0};
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    xValues             = {25};
    yValues             = {1.85};
    functionHandle      = @(T) 1.85;
    %{
    xValues             = [12.38;      24.22;      35.97];
    yValues             = [2.27855;    2.28105;    2.27717];
    functionHandle      = @(T) (-0.0583 * T + 2280.3 ) / 1000;
    %}
    dependence('carbonBlack_temperature_density',:)...
                                    =    {      'carbonBlack',  'temperature',  'density',      xValues,        yValues,        'degree C',     'g/cm^3',       functionHandle,     0};
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    xValues             = [12.63;      24.17;      36.17];
    yValues             =  [1.73197;    1.80943;    1.85487];
    functionHandle      = @(T) (5.2127 * T + 1672) / 1000;
    dependence('PVDF_temperature_density',:)...
                                    =    {      'PVDF',         'temperature',  'density',      xValues,        yValues,      	'degree C',     'g/cm^3',       functionHandle,     0};
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    xValues             = [10;     15;     20;     25;     30;     35];
    yValues             = [1.25;   1.23;   1.2;    1.18;   1.16;   1.15] / 1000;
    functionHandle      = @(T) (-0.004 * T + 1.2859) / 1000;
    dependence('air_temperature_density',:)...
                                    =    {      'air',          'temperature',  'density',      xValues,        yValues,        'degree C',     'g/cm^3',       functionHandle,     0};    
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------      
    xValues             = [15;     20;     25;     30;     35;     40;     45;     50;     55];
    yValues             = [1.2965; 1.2926; 1.2875; 1.2826; 1.2733; 1.2685; 1.263;  1.258;  1.2529]/1000;
    functionHandle      = @(T) (-0.0011 * T + 1.3148)/1000;
    dependence('LP30_temperature_density',:)...
                                    =    {      'LP30',         'temperature',  'density',      xValues,        yValues,       	'degree C',     'g/cm^3',    	functionHandle,     0};
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    xValues             = [15;     20;     25;     30;     35;     40;     45;     50;     55];
    yValues             = [1.2598; 1.2542; 1.2487; 1.2433; 1.2378; 1.2324; 1.2271; 1.223;  1.2164] / 1000;
    functionHandle      = @(T) (-0.0011 * T + 1.2756)/1000;
    dependence('LP50_temperature_density',:)...
                                    =    {      'LP50',         'temperature',  'density',      xValues,        yValues,    	'degree C',     'g/cm^3',   	functionHandle,     0};
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    xValues             = [12.83;       24.17;      36.03];
    yValues             = [2229.13;     2241.8;     2262.6] / 1000;
    functionHandle      = @(T) (1.445 * T + 2209.3) / 1000;
    dependence('BMWi3Anode_temperature_density',:)...
                                    =    {      'BMWi3Anode',   'temperature',  'density',      xValues,        yValues,        'degree C',     'g/cm^3',   	functionHandle,     0};    
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                        
    xValues             = [12.67;       24.2;       36.07];
    yValues             = [3865.53;     3874.07;    3861.5] / 1000;
    functionHandle      = @ (T) (-0.1766 * T + 3871.3) / 1000;
    dependence('BMWi3Cathode_temperature_density',:)...
                                    =    {      'BMWi3Cathode', 'temperature',  'density',      xValues,        yValues,        'degree C',     'g/cm^3',       functionHandle,     0};

    % ====================================================================================================================================================================================
    
    % temperature - heat capacity part
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------     
    xValues             = [10;     12;     14;     16;     18;     20;     22;     24;...
                                    26;     26.85;  28;     30;     32;     34;     36;     38;     40];
    yValues             = [0.6686; 0.6744; 0.6807; 0.6879; 0.6939; 0.7005; 0.7068; 0.7135;...
                                    0.7195; 0.7216; 0.725;  0.7308; 0.737;  0.7424; 0.7494; 0.7554; 0.7612];
    functionHandle      = @(T) 0.0031 * T + 0.6382;
    dependence('graphite_temperature_heatCapacity',:)...
                                    =    {      'graphite',     'temperature',  'heatCapacity', xValues,        yValues,       'degree C',     'J/(g K)',        functionHandle,     1};
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------     
    xValues             = [10;     12;     14;     16;     18;     20;     22;     24;...
                                    26;     26.85;  28;     30;     32;     34;     36;     38;     40];
    yValues             = [0.6994; 0.7028; 0.7065; 0.7096; 0.7127; 0.7156; 0.7189; 0.7221;...
                                    0.7258; 0.7271; 0.7287; 0.732;  0.7347; 0.7376; 0.7405; 0.7430; 0.7457];
    functionHandle      = @(T) 0.0016 * T + 0.6847;
    dependence('NMC_temperature_heatCapacity',:)...
                                    =    {      'NMC',          'temperature',  'heatCapacity', xValues,        yValues,       'degree C',     'J/(g K)',        functionHandle,     1};
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------     
    xValues             = [-13.15; 6.85;   25;     36.85;      56.85];
    yValues             = [0.6584; 0.702;  0.7308; 0.7495; 0.7818];
    functionHandle      = @(T) 0.0017 * T + 0.6854;
    dependence('LCO_temperature_heatCapacity',:)...
                                    =    {      'LCO',          'temperature',  'heatCapacity', xValues,        yValues,       'degree C',     'J/(g K)',        functionHandle,     1};      
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------     
    xValues             = [10;     12;     14;     16;     18;     20;     22;     24;...
                                        26;     26.85;  28;     30;     32;     34;     36;     38;     40];
    yValues             = [0.6867; 0.6928; 0.6993; 0.7052; 0.7111; 0.7171; 0.7231; 0.7302;...
                                        0.7374; 0.7402; 0.7433; 0.7498; 0.7565; 0.7636; 0.7693; 0.7762; 0.7829];
    functionHandle      = @(T) 0.0032 * T + 0.6537;
    dependence('carbonBlack_temperature_heatCapacity',:)...
                                    =    {      'carbonBlack',  'temperature',  'heatCapacity', xValues,        yValues,       'degree C',     'J/(g K)',        functionHandle,     1};        
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------     
    xValues             = [10;     12;     14;     16;     18;     20;     22;     24;...
                            26;     26.85;  28;     30;     32;     34;     36;     38;     40];
    yValues             = [1.0558; 1.0627; 1.0707; 1.0782; 1.0861; 1.0941; 1.1018; 1.1099;...
                            1.1176; 1.1211; 1.1257; 1.1334; 1.1422; 1.1492; 1.1571; 1.1657; 1.1738];
    functionHandle      = @(T) 0.0039 * T + 1.0155;
    dependence('PVDF_temperature_heatCapacity',:)...
                                    =    {      'PVDF',         'temperature',  'heatCapacity', xValues,        yValues,       'degree C',     'J/(g K)',        functionHandle,     1};        
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------     
    xValues             = [7;      27;     47];
    yValues             = [1.004;  1.005;  1.006];
    functionHandle      = @(T) 5e-5 * T + 1.0037;
    dependence('air_temperature_heatCapacity',:)...
                                    =    {      'air',          'temperature',  'heatCapacity', xValues,        yValues,       'degree C',     'J/(g K)',        functionHandle,     1};                                     
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    xValues             = [10;     12;     14;     16;     18;     20;     22;     24;...
                            26;     26.85;  28;     30;     32;     34;     36;     38;     40];
    yValues             = [1.6250; 1.628;  1.6305; 1.6335; 1.636;  1.639;  1.642;  1.645;...
                            1.651;  1.6525; 1.655;  1.6575; 1.661;  1.6635; 1.668;  1.671;  1.674];
    functionHandle      = @(T) 0.0017 * T + 1.6067;
    dependence('LP30_temperature_heatCapacity',:)...
                                    =    {      'LP30',         'temperature',  'heatCapacity', xValues,        yValues,       'degree C',     'J/(g K)',        functionHandle,     1};                                     
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------     
    xValues             = [10;     12;     14;     16;     18;     20;     22;     24;...
                            26;     26.85;  28;     30;     32;     34;     36;     38;     40];
    yValues             = [1.6188; 1.6212; 1.624;  1.6267; 1.6298; 1.633;  1.636;  1.6403;....
                            1.6457; 1.6478; 1.6497; 1.6527; 1.6563; 1.6595; 1.6632; 1.6667; 1.6698];
    functionHandle      = @(T) 0.0018 * T + 1.599;
    dependence('LP50_temperature_heatCapacity',:)...
                                    =    {      'LP50',         'temperature',  'heatCapacity', xValues,        yValues,       'degree C',     'J/(g K)',        functionHandle,     1};     
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------     
    xValues             = [10;     12;     14;     16;     18;     20;     22;     24;...
                            26;     26.85;  28;     30;     32;     34;     36;     38;     40];
    yValues             = [ 0.7023; 0.7079; 0.7137; 0.72;   0.7261; 0.7321; 0.7381; 0.744;...
                                0.75;   0.7527; 0.7565; 0.7627; 0.7685; 0.774;  0.7809; 0.7871; 0.7938];
    functionHandle      = @(T) 0.003 * T + 0.6714;
    dependence('BMWi3Anode_temperature_heatCapacity',:)...
                                    =    {      'BMWi3Anode',   'temperature',  'heatCapacity', xValues,        yValues,       'degree C',     'J/(g K)',        functionHandle,     1};    
    % ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------     
    xValues             = [10;     12;     14;     16;     18;     20;     22;     24;...
                            26;     26.85;  28;     30;     32;     34;     36;     38;     40];
    yValues             = [0.7595; 0.7625; 0.7663; 0.7698; 0.7735; 0.7771; 0.7802; 0.7836;...
                                0.7869; 0.7883; 0.7903; 0.7936; 0.7966; 0.8;    0.8035; 0.8070; 0.8112];
    functionHandle      = @ (T) 0.0017 * T + 0.7426;
    dependence('BMWi3Cathode_temperature_heatCapacity',:)...
                                    =    {      'BMWi3Cathode', 'temperature',  'heatCapacity', xValues,        yValues,       'degree C',     'J/(g K)',        functionHandle,     1};    
    
    
    
    
    
clear xValues yValues functionHandle
writetable(dependence,'dependence.xlsx')
%% Save all the variables in tables.m
save tables

    