function krit=cable_length_optim(psi)

%globalni promenna - natoceni
global phi

%% nacteni rozmeru 
parameters;

xA=A(1);
yA=A(2);
xB=B(1);
yB=B(2);

%% pocatecni delka lana (vypocet ze vzprimene polohy)
phi0=pi/2;
psi0=0;
xC0=r*cos(phi0)-a1*cos(psi0);
yC0=r*sin(phi0)-a1*sin(psi0);
xD0=r*cos(phi0)+a2*cos(psi0);
yD0=r*sin(phi0)+a2*sin(psi0);
l10=sqrt((xC0-xA)^2 + (yC0-yA)^2);
l20=sqrt((xB-xD0)^2 + (yB-yD0)^2);
l0=l10+l20;

%% skutecna delka lana
xC=r*cos(phi)-a1*cos(psi);
yC=r*sin(phi)-a1*sin(psi);
xD=r*cos(phi)+a2*cos(psi);
yD=r*sin(phi)+a2*sin(psi);
l1=sqrt((xC-xA)^2 + (yC-yA)^2);
l2=sqrt((xB-xD)^2 + (yB-yD)^2);
l=l1+l2;

%%optim kriterium
krit=l0^2-l^2;
if(krit<=0)
    krit=1e5;
end;
