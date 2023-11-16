function krit=optim_fun(x)
a=x(1);
d=x(2);
e=x(3);

%% Rozmery pocatecni
%a=0.03;
b=0.2;
%d=0.05;
%e=0.02;

%% Vypocet rozmeru
%pocatecni rozmery
phi0=0;
xA0=b*sin(phi0)-a*cos(phi0);
yA0=b*cos(phi0)+a*sin(phi0);
xB0=b*sin(phi0)+a*cos(phi0);
yB0=b*cos(phi0)-a*sin(phi0);
xC0=-d;
yC0=e;
xD0=d;
yD0=e;

l10=sqrt((xA0-xC0)^2 + (yA0-yC0)^2);
l40=sqrt((xB0-xD0)^2 + (yB0-yD0)^2);
lc0=l10+l40+2*a;

%s promennymi rozmery v optimalizaci
xC=-d;
yC=e;
xD=d;
yD=e;
%cyklus pres phi=<-pi/4; pi/4>
odchylka_sum=0;
for (phi=-pi/4:0.1:pi/4);
  xA=b*sin(phi)-a*cos(phi);
  yA=b*cos(phi)+a*sin(phi);
  xB=b*sin(phi)+a*cos(phi);
  yB=b*cos(phi)-a*sin(phi);

  l1=sqrt((xA-xC)^2 + (yA-yC)^2);
  l4=sqrt((xB-xD)^2 + (yB-yD)^2);

  %celkova delka lana;
  lc=l1+l4+2*a;
  odchylka=(lc-lc0)^2;
  odchylka_sum=odchylka_sum+odchylka;

  popis=['phi=', num2str(phi), ', a=', num2str(a), ', b=', num2str(b), ', d=', num2str(d), ', e=', num2str(e), ', ODCH=', num2str(odchylka_sum) ];
  structure_plot(a, b, d, e, phi, popis);
  pause(0.1)
end;

krit=odchylka_sum;
