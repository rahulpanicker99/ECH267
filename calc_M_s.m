function [Maximum,new_sum] = calc_M_s(s,A,numvar,f_i,g_i,old_sum)
e_j = eye(numvar,numvar);% Std unit vector

store_support = [];
for j = 1:numvar
 
     
        A_calc = e_j(j,:)*(A^(s-1));
        
        store_support(j,:) = support_funct_M_s(A_calc,f_i,g_i) ;
        store_support_2(j,:) = support_funct_M_s(-A_calc,f_i,g_i) ;

    
   act_funct = sum(store_support(j,:));
   act_funct_2 = sum(store_support_2(j,:));
   
end
act_funct = act_funct+old_sum(1);
act_funct_2 = act_funct_2+old_sum(2);
new_sum = [act_funct;act_funct_2];

Maximum1 = max(act_funct, [], 'all');
Maximum2 = max(act_funct_2, [], 'all');
Maximum = max(Maximum1,Maximum2);
end
