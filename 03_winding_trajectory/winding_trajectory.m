%%% Hledani kinematiky s konstantni delkou lana pro pohyb kloubu

clear all, close all, clc;

parameters;

global phi %globalni promenna - natoceni kloubu

%% optimalizace delky lana

xA0=A(1);
yA0=A(2);
xB0=B(1);
yB0=B(2);

%% pocatecni delka lana (vypocet ze vzprimene polohy)
phi0=pi/2;
psi0=0;
xC0=r*cos(phi0)-a1*cos(psi0);
yC0=r*sin(phi0)-a1*sin(psi0);
xD0=r*cos(phi0)+a2*cos(psi0);
yD0=r*sin(phi0)+a2*sin(psi0);
l10=sqrt((xC0-xA0)^2 + (yC0-yA0)^2);
l20=sqrt((xB0-xD0)^2 + (yB0-yD0)^2);
l0=l10+l20;

%% optimalizacni proces
vysledky=[];
for(phi=phi_b:phi_s:phi_e)
  disp(phi)
  [x, fval]=fminsearch(@cable_length_optim, psi0);
  psi=x;
  xC=r*cos(phi)-a1*cos(psi0);
  yC=r*sin(phi)-a1*sin(psi0);
  xD=r*cos(phi)+a2*cos(psi0);
  yD=r*sin(phi)+a2*sin(psi0);
  l1=sqrt((xC-xA0)^2 + (yC-yA0)^2);
  l2=sqrt((xB0-xD)^2 + (yB0-yD)^2);
  vysledky=[vysledky; [phi, x, fval, l1, l2]];
end;


%% Animace
figure(10)
hold on;

for(i=1:size(vysledky, 1))
  phi=vysledky(i, 1);
  psi=vysledky(i, 2);
  xC=r*cos(phi)-a1*cos(psi);
  yC=r*sin(phi)-a1*sin(psi);
  xD=r*cos(phi)+a2*cos(psi);
  yD=r*sin(phi)+a2*sin(psi);
  clf;
  hold on;
  axis equal
  axis([-r r -r/2 1.5*r]);
  plot([0, r*cos(vysledky(i, 1))], [0, r*sin(vysledky(i, 1))], 'k', 'LineWidth', 3);
  plot([xC, xD], [yC, yD], 'k', 'LineWidth', 3);
  plot([xA0, xC], [yA0, yC], 'r-.', 'LineWidth', 2);
  plot([xB0, xD], [yB0, yD], 'r-.', 'LineWidth', 2);
  %[phi, x, fval, l1, l2]
  title(['l1+l2=', num2str(vysledky(i, 4)+vysledky(i,5)), ' psi=', num2str(vysledky(i, 2)), ' err=', num2str(vysledky(i, 3))])
  pause(0.01);
  hold off;
end;

figure(20);
hold on
plot(vysledky(:,1), vysledky(:,3))
title('Cable length deviation');

figure(30);
hold on
plot(vysledky(:,1), ((pi/2-vysledky(:,1)+vysledky(:,2)-pi/2))*180/pi)
title('Top platform rotation');



