function alpha_0_s = calc_alpha_0(ineq,support,g_i)
for i = 1:ineq-1
  alpha_0_s_i(i) = support(i)/g_i(i);
end
alpha_0_s = max(alpha_0_s_i);
end