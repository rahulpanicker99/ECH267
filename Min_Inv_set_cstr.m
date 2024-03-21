clear all
close all
clc
%% CSTR model

[T0,V,k, Cp, rho, Qs, Flow,E,dH, R, CA0s,CAs,Ts] = variables();
SS = [0;0];
[A_sys,B_sys,G_sys] = Lin_Funct(SS);
%% Attack

% Concentration attack %% Comment out lines 10-20 to obtain data for temperature attack
conc_attack = 0;
temp_attack = 0;
detectable = 1; %% Set this variable to "0" for data for undetectable attack, set to "1" for data for potentially detectable attack case-1
if detectable ==0
   poles = [0.5 -0.1];
    obs_poles = [-0.45 -0.5];
elseif detectable == 1
    poles = [0.3 0.2];
    obs_poles = [-0.5 0.5];
end
% %% Temperature attack (Potentially detectable attack case-2) %% Comment out lines 21-25 to obtain data for concentration attack
% temp_attack =1;
% conc_attack = 0;
%    poles = [0.3 -0.1];
%     obs_poles = [0.2 0.2];
%% parameters
t_sample = 10^-2;
[Ad,Bd,Gd] = Cont_to_disc(A_sys,B_sys,G_sys ,t_sample);

Cont_gain = place(Ad,Bd,poles);

C = eye(2);
L = place(Ad',C',obs_poles)';

%% Kerrigan et al example
state = [];

alpha1 = 1*10^-3;
alpha2 = 1*10^-3;

% Flower = [-alpha1 -alpha2;
%         -alpha1 -alpha2];
% Fupper = [alpha1 alpha2;
%         alpha1 alpha2];
epsilon = 5*10^-5;
G = expm((Flow/V)*eye(2,2)*t_sample);
%% Sets
for attack = 0:1
    s = 0;
if attack == 0

      lambda = eye(2,2);
      
elseif attack ==1
    
      lambda = eye(2,2);
      if conc_attack ==1
            lambda(1,1) = 0.8;
      elseif temp_attack ==1
          lambda(2,2) = 0.9;
      end
end

A = [Ad-Bd*Cont_gain Bd*Cont_gain;
   L*(eye(2,2)- lambda)*C Ad-L*C ]

% Transf = [eye(2,2) zeros(2,2); 
%           eye(2,2) -L*lambda*C]; % Transformation matrix


Transf = [G zeros(2,2); 
          G -L*lambda*C]; % Transformation matrix
      
      Eigenval = max(abs(eig(A)))
  
% %% Disturbance set definition & transformation
% 
% 
% A_f = [-eye(4,4); eye(4,4)];
% b_f = [alpha1;alpha1;alpha1;alpha1;
%     alpha2;alpha2;alpha2;alpha2];
% F = Polyhedron( 'A', A_f, 'b', b_f);
% F = linear_map(F,Transf);
% old_sum = [0;0]; 
% F.minHRep();
% F.minVRep();
% 
% %% Representation of the bounds as inequalities (fi' w <= gi)
% 
% 
% num_ineq = height(F.H);
% lb = []; ub = []; Aeq = []; Beq = [];
% numvar = 4;
% Int = F.H;
% Wid = width(F.H);
% A_F = Int(:,1:end-1);
% b_F = Int(:,end);
% %% Variables for the algorithm
% step =1;
% while 1
% s =s+1; % initialized at zero
% A_s = A^s; % Matrix at corresponding s value
% [support_alpha_0,max_funct,obj] = support_funct_alpha(num_ineq,A_F,b_F,A_s);
% alpha_algo(step) = calc_alpha_0(num_ineq,support_alpha_0,b_F);
% [M_s(step),new_sum] = calc_M_s(s,A,numvar,A_F,b_F,old_sum);
% old_sum = new_sum;
% if alpha_algo(step) <= epsilon/(epsilon+M_s(step)) || s == 10000 %|| F.contains(x0)==0 %
% 
%     break;
% end
% step = step+1;
% end
% 
% %% Minkowski sums of sets
% 
% s
% for index = 1:s
%     A_s = A^(index-1);
%     Lin_map =  linear_map(F,A_s);
%     if index ==1
%         Inv_set_app = Lin_map;
% %         Inv_set_app.minHRep(); % Do not compute minHRep: Increases
% %         computation time. 
%         Inv_set_app.minVRep();
%        else
%         Inv_set_app_new = plus(Inv_set_app,Lin_map);
% %         Inv_set_app_new.minHRep(); % Do not compute minHRep: Increases
% %         computation time. 
%         Inv_set_app_new.minVRep();
% 
%         Inv_set_app = Inv_set_app_new;
% index
%     end
% 
%   if index == s
% 
%        Inv_set_app_plot = linear_map(Inv_set_app_new,(1/(1-alpha_algo(index))));
% %        Inv_set_app_plot.minHRep(); % Do not compute minHRep: Increases
% %         computation time. 
% 
%   end
% 
% end
% 
% 
% %% Residual bounds
% 
% Disturb = Polyhedron( 'A', A_f, 'b', b_f);
% 
% 
%     Transform = [lambda-eye(2) eye(2,2)];
%     Transform_dist = [zeros(2,2) lambda];
%     Disturb_trans = linear_map(Disturb,Transform_dist);
% %     Disturb_trans.minHRep(); % Do not compute minHRep: Increases
% %         computation time. 
%     Disturb_trans.minVRep();
%     Aug_transf = linear_map(Inv_set_app_plot,Transform);
% %     Aug_transf.minHRep(); % Do not compute minHRep: Increases
% %         computation time. 
%     Aug_transf.minVRep();
%     Res_set = plus(Aug_transf,Disturb_trans);
% %     Res_set.minHRep(); % Do not compute minHRep: Increases
% %         computation time. 
%     Res_set.minVRep();
% 
% 
%   if attack == 1
%       Res_set_attack = Res_set;
%   elseif attack == 0
%       Res_set_noattack = Res_set;
%   end
% 
% 
% 
% end
% %% 
% %  Do not use "Minkdiff" unless MPT toolbox "minus" returns a set with zero vertices.
% % Computationally expensive
% %%
% z = ones(1,4);
% Trans_ball = [zeros(2,2) eye(2,2)];
% ball = Polyhedron('lb', -epsilon*z, 'ub', epsilon*z);
% ball.minVRep();
% Dre = minus(Res_set_noattack,linear_map(ball,Trans_ball));
% % Dre = Minkdiff(Res_set_noattack,linear_map(ball,Trans_ball)); 
% lam_att = lambda;
% trans_ball_attack = [lam_att-eye(2,2) eye(2,2)];
% %% if vertex computation is handled properly, i.e., number of vertices ~= 0
% % Drae = minus(Res_set_attack,linear_map(ball,trans_ball_attack));
% 
% %% If vertex computation is not handeled properly by MPT toolbox
% %% Use only when MPT minus produces polytopes of 0 vertices
% Drae = Minkdiff(Res_set_attack,linear_map(ball,trans_ball_attack));
% 
% 
% for i = 1:height(Res_set_attack.V)
%     abc(i) = norm(Res_set_attack.V(i,:));
% end
% normres_A = max(abc)
% for j = 1:height(Dre.V)
%     abc2(j) = norm(Dre.V(j,:));
% end
% normres_Dre = max(abc2)
% for j = 1:height(Res_set_noattack.V)
%     abc3(j) = norm(Res_set_noattack.V(j,:));
% end
% normres_NA = max(abc3)
% for j = 1:height(Drae.V)
%     abc4(j) = norm(Drae.V(j,:));
% end
% normres_Drae = max(abc4)
% 
% 
% 
% 
% %% Functions
% 
% 
% 
% 
% function [support,max_funct,obj] = support_funct_alpha(ineq,f_i,g_i,A_s)
% for i= 1:ineq
%     obj(i,:) = f_i(i,:)*A_s;
%     max_funct(i,:) = linprog(-obj(i,:),f_i,g_i);
%     support(i,:) = obj(i,:)*(max_funct(i,:))'; % Support function for the ith inequality
% end
% end
% 
% 
% function alpha_0_s = calc_alpha_0(ineq,support,g_i)
% for i = 1:ineq
%   alpha_0_s_i(i) = support(i)/g_i(i);
% end
% alpha_0_s = max(alpha_0_s_i);
% end
% 
% 
% function [Maximum,new_sum] = calc_M_s(s,A,numvar,f_i,g_i,old_sum)
% e_j = eye(numvar,numvar);% Std unit vector
% 
% store_support = [];
% for j = 1:numvar
% 
% 
%         A_calc = e_j(j,:)*(A^(s-1));
% 
%         store_support(j,:) = support_funct_M_s(A_calc,f_i,g_i) ;
%         store_support_2(j,:) = support_funct_M_s(-A_calc,f_i,g_i) ;
% 
% 
%    act_funct = sum(store_support(j,:));
%    act_funct_2 = sum(store_support_2(j,:));
% 
% end
% act_funct = act_funct+old_sum(1);
% act_funct_2 = act_funct_2+old_sum(2);
% new_sum = [act_funct;act_funct_2];
% 
% Maximum1 = max(act_funct, [], 'all');
% Maximum2 = max(act_funct_2, [], 'all');
% Maximum = max(Maximum1,Maximum2);
% end
% 
% 
% function support = support_funct_M_s(A_calc,f_i,g_i)
% 
%     max_funct = linprog(-A_calc,f_i,g_i);
%     support = A_calc*(max_funct); % Support function for the ith inequality
% 
end
% 
% 
% 
% 
% 
abs(eig(A))