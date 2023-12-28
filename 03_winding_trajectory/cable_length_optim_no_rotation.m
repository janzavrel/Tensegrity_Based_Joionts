function krit=cable_length_optim(x)

%% nacteni rozmeru 
parameters_no_rotation;

xA=p;
yA=x(2);
xB=-xA;
yB=yA;

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

vysledky=[];
for(phi=phi_b:phi_s:phi_e)
  psi=phi-pi/2;
  xC=r*cos(phi)-a1*cos(psi);
  yC=r*sin(phi)-a1*sin(psi);
  xD=r*cos(phi)+a2*cos(psi);
  yD=r*sin(phi)+a2*sin(psi);
  l1=sqrt((xC-xA)^2 + (yC-yA)^2);
  l2=sqrt((xB-xD)^2 + (yB-yD)^2);
  vysledky=[vysledky; [phi, l1+l2-l0, l1, l2, l0]];
end;

%%optim kriterium
krit=sum(abs(vysledky(:,2)))^2;