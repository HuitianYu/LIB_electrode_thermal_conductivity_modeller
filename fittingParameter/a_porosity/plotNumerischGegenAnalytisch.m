%%
clear
clc;
%%
[~,~,thermalConductivities] = xlsread('a_thermalConductivities.xlsx','Sheet1','A3:A26:O3:O26');
%%
thermalConductivities_simulated = zeros(size(thermalConductivities,1),1);
thermalConductivities_linear = zeros(size(thermalConductivities,1),1);
thermalConductivities_horizontal = zeros(size(thermalConductivities,1),1);
thermalConductivities_exponential = zeros(size(thermalConductivities,1),1);
for ii =  1 : size(thermalConductivities,1)
    thermalConductivities_simulated(ii,1) = thermalConductivities{ii,2};
    thermalConductivities_linear(ii,1) = thermalConductivities{ii,5};
    thermalConductivities_horizontal(ii,1) = thermalConductivities{ii,12};
    thermalConductivities_exponential(ii,1) = thermalConductivities{ii,17};
end
clear ii
%%
x0 = (0:0.01:5)';
y0 = (0:0.01:5)';
colors =  [ 0.9290, 0.6940, 0.1250;...
            0.8500, 0.3250, 0.0980;...
            0.4940, 0.1840, 0.5560;...
            0, 0.4470, 0.7410;...
            0.6350, 0.0780, 0.1840];
shapes = {'o';'^';'s';'x';'d'};
lineWidth = 0.5;
%% linear 
figure;
hold on
scatter(thermalConductivities_linear(1:5,1),thermalConductivities_simulated(1:5,1),shapes{1},...
    'MarkerEdgeColor',colors(1,:),'MarkerFaceColor',colors(1,:),'LineWidth',lineWidth)
scatter(thermalConductivities_linear(6:10,1),thermalConductivities_simulated(6:10,1),shapes{2},...
    'MarkerEdgeColor',colors(2,:),'MarkerFaceColor',colors(2,:),'LineWidth',lineWidth)
scatter(thermalConductivities_linear(11:15,1),thermalConductivities_simulated(11:15,1),shapes{3},...
    'MarkerEdgeColor',colors(3,:),'MarkerFaceColor',colors(3,:),'LineWidth',lineWidth)
scatter(thermalConductivities_linear(16:20,1),thermalConductivities_simulated(16:20,1),shapes{4},...
    'MarkerEdgeColor',colors(4,:),'MarkerFaceColor',colors(4,:),'LineWidth',lineWidth)
scatter(thermalConductivities_linear(21:24,1),thermalConductivities_simulated(21:24,1),shapes{5},...
    'MarkerEdgeColor',colors(5,:),'MarkerFaceColor',colors(5,:),'LineWidth',lineWidth)
plot(x0,y0,'g')
plot(x0,y0 * 0.7,'k--')
plot(x0,y0 * 1.3,'k--')
hold off
grid on
axis([0 4.5 0 4.5])
xlabel('W?rmeleitf?higkeit analytisch \lambda in W/(m*K)')
ylabel('W?rmeleitf?higkeit numerisch \lambda in W/(m*K)')
title('linear angepasst')
legend({'Variation FA; DMC';'Variation FA; Stickstoff';'LP30';'LP30; \lambda = 0,1';'LP30; \lambda = 0,3'},'location','northwest')
%% horizontal
figure;
hold on
scatter(thermalConductivities_horizontal(1:5,1),thermalConductivities_simulated(1:5,1),shapes{1},...
    'MarkerEdgeColor',colors(1,:),'MarkerFaceColor',colors(1,:),'LineWidth',lineWidth)
scatter(thermalConductivities_horizontal(6:10,1),thermalConductivities_simulated(6:10,1),shapes{2},...
    'MarkerEdgeColor',colors(2,:),'MarkerFaceColor',colors(2,:),'LineWidth',lineWidth)
scatter(thermalConductivities_horizontal(11:15,1),thermalConductivities_simulated(11:15,1),shapes{3},...
    'MarkerEdgeColor',colors(3,:),'MarkerFaceColor',colors(3,:),'LineWidth',lineWidth)
scatter(thermalConductivities_horizontal(16:20,1),thermalConductivities_simulated(16:20,1),shapes{4},...
    'MarkerEdgeColor',colors(4,:),'MarkerFaceColor',colors(4,:),'LineWidth',lineWidth)
scatter(thermalConductivities_horizontal(21:24,1),thermalConductivities_simulated(21:24,1),shapes{5},...
    'MarkerEdgeColor',colors(5,:),'MarkerFaceColor',colors(5,:),'LineWidth',lineWidth)
plot(x0,y0,'g')
plot(x0,y0 * 0.7,'k--')
plot(x0,y0 * 1.3,'k--')
hold off
grid on
axis([0 4.5 0 4.5])
xlabel('W?rmeleitf?higkeit analytisch \lambda in W/(m*K)')
ylabel('W?rmeleitf?higkeit numerisch \lambda in W/(m*K)')
title('horizontal angepasst')
legend({'Variation FA; DMC';'Variation FA; Stickstoff';'LP30';'LP30; \lambda = 0,1';'LP30; \lambda = 0,3'},'location','northwest')
%% exponential
figure;
hold on
scatter(thermalConductivities_exponential(1:5,1),thermalConductivities_simulated(1:5,1),shapes{1},...
    'MarkerEdgeColor',colors(1,:),'MarkerFaceColor',colors(1,:),'LineWidth',lineWidth)
scatter(thermalConductivities_exponential(6:10,1),thermalConductivities_simulated(6:10,1),shapes{2},...
    'MarkerEdgeColor',colors(2,:),'MarkerFaceColor',colors(2,:),'LineWidth',lineWidth)
scatter(thermalConductivities_exponential(11:15,1),thermalConductivities_simulated(11:15,1),shapes{3},...
    'MarkerEdgeColor',colors(3,:),'MarkerFaceColor',colors(3,:),'LineWidth',lineWidth)
scatter(thermalConductivities_exponential(16:20,1),thermalConductivities_simulated(16:20,1),shapes{4},...
    'MarkerEdgeColor',colors(4,:),'MarkerFaceColor',colors(4,:),'LineWidth',lineWidth)
scatter(thermalConductivities_exponential(21:24,1),thermalConductivities_simulated(21:24,1),shapes{5},...
    'MarkerEdgeColor',colors(5,:),'MarkerFaceColor',colors(5,:),'LineWidth',lineWidth)
plot(x0,y0,'g')
plot(x0,y0 * 0.7,'k--')
plot(x0,y0 * 1.3,'k--')
hold off
grid on
axis([0 4.5 0 4.5])
xlabel('W?rmeleitf?higkeit analytisch \lambda in W/(m*K)')
ylabel('W?rmeleitf?higkeit numerisch \lambda in W/(m*K)')
title('exponentiell angepasst')
legend({'Variation FA; DMC';'Variation FA; Stickstoff';'LP30';'LP30; \lambda = 0,1';'LP30; \lambda = 0,3'},'location','northwest')