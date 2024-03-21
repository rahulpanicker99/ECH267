clear
close
load('A_nominal.mat')
MI_attack = Output_set;
clear Output_set;
load('NA_nominal.mat')
MI_NA = Output_set;
load('python_variable_attack.mat')
% Plot MI_attack with a red face color
% plot(MI_attack);
% hold on
% plot(MI_NA)
% f1 = figure(1);
% set(f1, 'Units', 'Inches', ...
% 'Position', [8,8,7,6])
% movegui('center')
% hold on
% a1 = plot(MI_attack, 'Facealpha', 0.1, 'Color', 'b');
% hold on
% a2 = plot(MI_NA);
% hold on
% % a3 = scatter(output(1, :), output(2, :), 20, 'filled'); % 'filled' option fills the markers with color
% % colormap('viridis'); % Set the colormap (you can choose another colormap if desired)
% box on
% set(a1,'FaceColor','[1 1 1]','FaceAlpha',0.1)
% % xticks([-10 -5 0 5 10])
% % yticks([-5 0 5])
% ax = gca;
% set(ax, 'FontSize', 16);
% ylabel('$$ y_2(K)$$','FontSize',24,'Interpreter','LaTex')
% xlabel('$$ y_1(kmol/m^3)$$','FontSize',24,'Interpreter','LaTex')
% legend('$$ {D}_{y_a}  $$','$$ {D}_{y}  $$','Interpreter','LaTex', 'FontSize', 20)
% % legend('$$ {D}_{y_a}  $$','$$ {D}_{y}  $$', '$$ {(y_1,y_2)}  $$','Interpreter','LaTex', 'FontSize', 20)
% 
% % legend('$$ {D}_{y}  $$','$$ {(y_1,y_2)}  $$','Interpreter','LaTex', 'FontSize', 20)
% Create a VideoWriter object

f2 = figure(1);
set(f2, 'Units', 'Inches', ...
'Position', [8,8,7,6])
movegui('center')
hold on
% a1 = plot(MI_attack, 'Facealpha', 0.1, 'Color', 'r');
% hold on
a2 = plot(MI_NA,'Facealpha', 0.1, 'Color', 'b');
vertices=MI_NA.V;
% a3 = scatter(output(1, :), output(2, :), 20,"magenta", 'filled'); % 'filled' option fills the markers with color
% yticks([-0.8 -0.6 -0.4 -0.2 -0.0 0.2 0.4 0.6 0.8])
% xticks([-0.015 -0.01 -0.005 0 0.005 0.01 0.015])
hold on
for i = 1:102
    % isInside = inpolygon(output(1, i), output(2, i), vertices(:,1), vertices(:,2));
    a3 = scatter(output(1, i), output(2, i), 20,"green",'filled'); % 'filled' option fills the markers with color
    % a3.MarkerFaceColor = [0.9290 0.6940 0.1250];
    % colormap('viridis'); % Set the colormap (you can choose another colormap if desired)
    box on
    % set(a1,'FaceColor','[1 1 1]','FaceAlpha',0.1)
    ax = gca;

    xlim([-0.02 0.020])
    ylim([-1 1])
    yticks([-0.8 -0.6 -0.4 -0.2 -0.0 0.2 0.4 0.6 0.8])
    xticks([ -0.015 -0.01 -0.005 0 0.005 0.01 0.015 ])
    set(ax, 'FontSize', 16);
    ylabel('$$ y_2(K)$$','FontSize',24,'Interpreter','LaTex')
    xlabel('$$ y_1(kmol/m^3)$$','FontSize',24,'Interpreter','LaTex')
    % legend('$$ {D}_{y_a}  $$','$$ {D}_{y}  $$','Interpreter','LaTex', 'FontSize', 20)
    % legend('$$ {D}_{y_a}  $$','$$ {D}_{y}  $$', '$$ {(y_1,y_2)}  $$','Interpreter','LaTex', 'FontSize', 20)

    legend('$$ {D}_{y}  $$','$$ {(y_1,y_2)}  $$','Interpreter','LaTex', 'FontSize', 20)

    % Capture the frame and write it to the video
    exportgraphics(gca,"scatter.gif","Append",true);
    % if ~isInside
    %      % Plot the point outside the polytope and exit the loop
    %      a3 = scatter(output(1, i), output(2, i), 20,"blue", 'filled'); % 'filled' option fills the markers with color
    %      break;
    %  end
end
box on
% % set(a1,'FaceColor','[1 1 1]','FaceAlpha',0.1)
% ax = gca;

% xlim([-0.02 0.020])
% ylim([-1 1])
% yticks([-0.8 -0.6 -0.4 -0.2 -0.0 0.2 0.4 0.6 0.8])
% xticks([ -0.015 -0.01 -0.005 0 0.005 0.01 0.015 ])
% set(ax, 'FontSize', 16);
% ylabel('$$ y_2(K)$$','FontSize',24,'Interpreter','LaTex')
% xlabel('$$ y_1(kmol/m^3)$$','FontSize',24,'Interpreter','LaTex')
% legend('$$ {D}_{y_a}  $$','$$ {D}_{y}  $$','Interpreter','LaTex', 'FontSize', 20)
% legend('$$ {D}_{y_a}  $$','$$ {D}_{y}  $$', '$$ {(y_1,y_2)}  $$','Interpreter','LaTex', 'FontSize', 20)

% legend('$$ {D}_{y}  $$','$$ {(y_1,y_2)}  $$','Interpreter','LaTex', 'FontSize', 20)










