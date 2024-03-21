function [A,B,G] = Lin_Funct(X)
[T0,V,k, Cp, rho, Qs, F,E,dH, R, CA0s,CAs,Ts] = variables();



A(1,1) = - (F/V) -2*k*exp(-E/(R*(X(2)+Ts)))*(X(1) + CAs);
A(1,2) = - k*( (X(1) + CAs)^2 )*exp(-E/(R*(X(2)+Ts)))*(E/(R*( X(2)+Ts)^2));
A(2,1) = - 2* (X(1) + CAs)*((dH*k)/(rho*Cp)) * exp(-E/(R*(X(2)+Ts)));
A(2,2) =  -(F/V) - ((dH*k*( (X(1)+CAs)^2 ))/(rho*Cp)) * exp(-E/(R*(X(2)+Ts)))*(E/(R*(X(2)+Ts)^2));

B(1,1) = 0; 
B(2,1) = 1/(rho*Cp*V);

G(1,1) = F/V;
G(2,1) = 0;
G(1,2) = 0;
G(2,2) = F/V;

end