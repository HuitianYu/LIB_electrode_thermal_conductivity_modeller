clear
clc
%%
% ------------------------------------------ Data START ------------------------------------------
titleName = 'graphite anode (numeric,shrink 0.99)';
data = readtable('data.xlsx','Sheet','ShrinkP98_Graphite','ReadVariableNames',false,'ReadRowNames',true);
namesMatrix = cell(1,size(data,2));
nameFiller = cell(1,size(data,2));
vFrMatrix = zeros(2,size(data,2));
porosity = zeros(1,size(data,2));
k = zeros(1,size(data,2));
for ii =  1 : size(data,2)
    namesMatrix{1,ii} = {data{2,ii}{1};data{3,ii}{1};data{4,ii}{1}};
    nameFiller{1,ii} = data{5,ii}{1};
    [vFrMatrix(1:2,ii),~] = fractionsMatrix_xPorosity_transfer(...
                              namesMatrix{1,ii},[str2num(data{6,ii}{1});str2num(data{7,ii}{1})],'none',0,str2num(data{8,ii}{1}),0,0,0);
    porosity(1,ii) = str2num(data{9,ii}{1});
    k(1,ii) = str2num(data{10,ii}{1});
end
clear ii

% ------------------------------------------ Data   END ------------------------------------------

%% Finding out PARA for each porosity
% model name
modelName = 'ZSM_1_a';

% curve name
curveName = 'curveRAreaContact';

% mode name for additive combination (conductive additive + binder)
modelAdditiveName = 'MEM_1,f=3.2';

% tortuosity mode
modeTortuosity = 1;

% parameters
PARAs = {'a','c','e','g'};
paraValues = {'vary','@(porosity_i) 0.013796 * exp(3.2251 * porosity_i)',0,0};
epsilon = 1e-3; % accuracy for the derivate at the point 0
FUNCs = '';
funcValues = '';
for jj = 1 : size(PARAs,2)
    if isnumeric(paraValues{1,jj})
       eval([PARAs{1,jj},'=',num2str(paraValues{1,jj}),';']) 
    elseif ischar(paraValues{1,jj}) && ~strcmp(paraValues{1,jj},'vary')
        eval([PARAs{1,jj},'=',paraValues{1,jj},';']) 
        strlen_FUNCs = strlength(FUNCs);
        FUNCs = insertAfter(FUNCs,strlen_FUNCs,[',',PARAs{1,jj}]);
        strlen_funcValues = strlength(funcValues);
        funcValues = insertAfter(funcValues,strlen_funcValues,[',',PARAs{1,jj},'(porosity(1,ii))']);
    else
        eval([PARAs{1,jj},'= zeros(1,size(data,2));']) 
        eval(['PARA = ','''',PARAs{1,jj},''';'])
    end
end
clear jj


% function handle to calculate the difference between simulated value and modelled value
eval(['f = @ (k_i,namesMatrix_i,vFrMatrix_i,nameFiller_i,porosity_i,',PARA,FUNCs,') k_i - k_',modelName,'(namesMatrix_i,vFrMatrix_i,nameFiller_i,porosity_i,curveName,modelAdditiveName,modeTortuosity,a,c,e,g);'])
f_PARA = cell(1,size(data,2));

for ii = 1 : size(data,2)
    eval(['f_PARA{1,ii} = @(PARA) f(k(1,ii),namesMatrix{1,ii},vFrMatrix(1:2,ii),nameFiller{1,ii},porosity(1,ii),PARA',funcValues,');'])
end
clear ii

%%

for ii = 1 : size(data,2)
    fprintf('------------ For data %d ------------\n',ii)
    options = optimset('Display','off');
    eval(['f_PARA{1,ii} = @(PARA) f(k(1,ii),namesMatrix{1,ii},vFrMatrix(1:2,ii),nameFiller{1,ii},porosity(1,ii),PARA',funcValues,');'])
 
    if f_PARA{1,ii}(0) < f_PARA{1,ii}(epsilon)  % monotonically increasing
   
        if f_PARA{1,ii}(0) == 0
            eval([PARA,'(1,ii) = 0;'])
        elseif f_PARA{1,ii}(0) > 0 && f_PARA{1,ii}(0)/k(1,ii) < 0.05
            eval([PARA,'(1,ii) = 0;'])
            fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
        elseif f_PARA{1,ii}(0) > 0 && f_PARA{1,ii}(0)/k(1,ii) >= 0.05
            fprintf('%s cannot be found for data %d.\n',PARA,ii)
            eval([PARA,'(1,ii) = NaN;'])
        elseif f_PARA{1,ii}(0) < 0 && abs(f_PARA{1,ii}(0)/k(1,ii)) < 0.05
            eval([PARA,'(1,ii) = 0;'])
            fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
        else
            fprintf('%s is being iterated for data %d.\n',PARA,ii)
            para_iter = 0;
            while f_PARA{1,ii}(para_iter) < 0
               para_iter = para_iter + 0.05; 
            end
            eval([PARA,'(1,ii) = fzero(f_PARA{1,ii},[0 para_iter],options);'])
            eval(['fprintf(''%s = %6.4f for data %d.\n'',PARA,',PARA,'(1,ii),ii)'])
        end
    elseif f_PARA{1,ii}(0) > f_PARA{1,ii}(epsilon)  % monotonically decreasing
            if f_PARA{1,ii}(0) == 0
                eval([PARA,'(1,ii) = 0;'])
            elseif f_PARA{1,ii}(0) < 0 && abs(f_PARA{1,ii}(0)/k(1,ii)) < 0.05
                eval([PARA,'(1,ii) = 0;'])
                fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
            elseif f_PARA{1,ii}(0) < 0 && abs(f_PARA{1,ii}(0)/k(1,ii)) >= 0.05
                fprintf('%s cannot be found for data %d.\n',PARA,ii)
                eval([PARA,'(1,ii) = NaN;'])
            elseif f_PARA{1,ii}(0) > 0 && f_PARA{1,ii}(0)/k(1,ii) < 0.05
                eval([PARA,'(1,ii) = 0;'])
                fprintf('%s = 0 bei very small deviation for data %d.\n',PARA,ii)
            else
                fprintf('%s is being iterated for data %d.\n',PARA,ii)
                para_iter = 0;
                while f_PARA{1,ii}(para_iter) > 0
                   para_iter = para_iter + 0.05; 
                end
                eval([PARA,'(1,ii) = fzero(f_PARA{1,ii},[0 para_iter],options);'])
                eval(['fprintf(''%s = %6.4f for data %d.\n'',PARA,',PARA,'(1,ii),ii)'])
            end
    else
        if f_PARA{1,ii}(0) == 0
                eval([PARA,'(1,ii) = 0;'])
        else
                fprintf('%s cannot be found for data %d.\n',PARA,ii)
                eval([PARA,'(1,ii) = NaN;'])
        end
    end
 
end
clear ii

eval(['xlswrite(''',PARA,'_porosity.xlsx'',[porosity'',',PARA,'''])'])

%% Polyfit for c against porosity
H = figure;
hold on
eval(['scatter(porosity,',PARA,')'])
x = linspace(0,1,101)';

% linear-fit
eval(['p = polyfit(porosity,',PARA,',0);'])
y_lin = polyval(p,x);
y_lin(y_lin<0) = 0;
plot(x,y_lin)

% expo-fit
f_exp = @(a,x) a(1) * exp(a(2) * x);
eval(['b = nlinfit(porosity,',PARA,',f_exp,[0;0]);'])
y_exp = arrayfun(@(x) f_exp(b,x),x);
plot(x,y_exp)

hold off
xlabel('Porosity \phi / -')
ylabel([PARA,' / -'])
legends = cell(3,1);
legends{1,1} = 'Numeric simulated Values';

if p(1,2) > 0
    legends{2,1} = ['linear: y = ',num2str(p(1,1)),' x + ', num2str(p(1,2))];
elseif p(1,2) == 0
    legends{2,1} = ['linear: y = ',num2str(p(1,1)),' x'];
else
   legends{2,1} = ['linear: y = ',num2str(p(1,1)),' x - ', num2str(abs(p(1,2)))]; 
end
legends{3,1} = ['exponential: y = ',num2str(b(1)),' * exp(',num2str(b(2)),' * x)'];
legend(legends)

savefig(H,[PARA,'_porosity.fig'])
clear H
%% Plot thermal conductivity
min = 31;
max = 61;
k_0 = zeros(1,size(data,2));

% linear
k_lin = zeros(1,size(data,2));
for ii = 1 : size(data,2)
    fprintf('Try to calculate k_0 and k_lin for data %d.\n',ii)
    k_0(1,ii) = k(1,ii) - f_PARA{1,ii}(0);
    try
        k_lin(1,ii) = k(1,ii) - f_PARA{1,ii}(p(1,1) * porosity(1,ii) + p(1,2));
    catch
        k_lin(1,ii) = NaN;
    end
end
clear ii

% exponential
k_exp = zeros(1,size(data,2));
for ii = 1 : size(data,2)
    fprintf('Try to calculate k_exp for data %d.\n',ii)
    try
        k_exp(1,ii) = k(1,ii) - f_PARA{1,ii}(b(1) * exp(b(2) * porosity(1,ii)));
    catch
        k_exp(1,ii) = NaN;
    end
end
clear ii

%% plot linear
H = figure;
hold on
scatter(porosity,k,'o')
scatter(porosity,k_0,'x')
scatter(porosity,k_lin,'s')

hold off
xlabel('Porosity \phi / -')
ylabel('Thermal conductivity / W/(m * K)')
legend({'Numeric simulated Values';'unfitted Values';[PARA,' linear fitted Values']})
savefig(H,[PARA,'_linear.fig'])
clear H
%% plot exponential
H = figure;
hold on
scatter(porosity,k,'o')
scatter(porosity,k_0,'x')
scatter(porosity,k_exp,'s')

hold off
xlabel('Porosity \phi / -')
ylabel('Thermal conductivity / W/(m * K)')
legend({'Numeric simulated values';'unfitted values';[PARA,' exponential fitted values']})
savefig(H,[PARA,'_exponential.fig'])
clear H
%% Save the thermal conductivities
eval(['xlswrite(''',PARA,'_thermalConductivities.xlsx'',[k'',k_0'',k_lin'',k_exp''])'])