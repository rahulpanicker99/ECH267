function [Ad,Bd,Gd] = Cont_to_disc(A,B,G,delta)
%% Only for invertible matrices (A)
Ad = expm(A*delta);
I = eye(size(Ad));
Bd =  A\ (Ad - I)*B;
Gd = A\ (Ad - I)*G;
end
