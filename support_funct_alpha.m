
function [support,max_funct,obj] = support_funct_alpha(ineq,f_i,g_i,A_s)
for i= 1:ineq
    obj(i,:) = f_i(i,:)*A_s;
    max_funct(i,:) = linprog(-obj(i,:),f_i,g_i);
    support(i,:) = obj(i,:)*(max_funct(i,:))'; % Support function for the ith inequality
end
end
