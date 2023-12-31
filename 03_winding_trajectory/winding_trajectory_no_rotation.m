%%% Hledani kinematiky s konstantni delkou lana pro pohyb kloubu -
%%% rozmisteni uchytu
%% !! NO PLATFORM ROTATION !!
%% optimalizace rozmeru xA, yA (xB=-xA, yB=yA)
clear all, close all, clc;

parameters_no_rotation;

%% optimalizace delky lana
%%optimizing process
%optimalizace rozmeru xA, yA (xB=-xA, yB=yA)
x0=[p, h];
[x, fval]=fminsearch(@cable_length_optim_no_rotation, x0);
%p=x(1)
h=x(2)

xA=p;
yA=h;
xB=-p;
yB=h;

%%stredova delka lana
phi=pi/2;
psi=phi-pi/2;
xC=r*cos(phi)-a1*cos(psi);
yC=r*sin(phi)-a1*sin(psi);
xD=r*cos(phi)+a2*cos(psi);
yD=r*sin(phi)+a2*sin(psi);
l1=sqrt((xC-xA)^2 + (yC-yA)^2);
l2=sqrt((xB-xD)^2 + (yB-yD)^2);
l0=l1+l2;


%%vypocet pohybu
vysledky=[];
for(phi=phi_b:phi_s:phi_e)
%  disp(phi)
  psi=phi-pi/2;
  xC=r*cos(phi)-a1*cos(psi);
  yC=r*sin(phi)-a1*sin(psi);
  xD=r*cos(phi)+a2*cos(psi);
  yD=r*sin(phi)+a2*sin(psi);
  l1=sqrt((xC-xA)^2 + (yC-yA)^2);
  l2=sqrt((xB-xD)^2 + (yB-yD)^2);
  vysledky=[vysledky; [phi, psi, l1+l2-l0, l1, l2]];
end;

%% Animace
figure(10)
hold on;
grid on;

for(i=1:size(vysledky, 1))
  phi=vysledky(i, 1);
  psi=vysledky(i, 2);
  xC=r*cos(phi)-a1*cos(psi);
  yC=r*sin(phi)-a1*sin(psi);
  xD=r*cos(phi)+a2*cos(psi);
  yD=r*sin(phi)+a2*sin(psi);
  clf;
  hold on;
  grid on;
  axis equal
  axis([-r r -r/3 1.2*r]);
  plot([0, r*cos(vysledky(i, 1))], [0, r*sin(vysledky(i, 1))], 'k', 'LineWidth', 3);
  plot([xC, xD], [yC, yD], 'k', 'LineWidth', 3);
  plot([xA, xC], [yA, yC], 'r-.', 'LineWidth', 2);
  plot([xB, xD], [yB, yD], 'r-.', 'LineWidth', 2);
  text(xA+0.01, yA, 'A', FontSize=12, FontWeight='bold');
  text(xB-0.02, yB, 'B', FontSize=12, FontWeight='bold');
  text(xC-0.02, yC, 'U', FontSize=12, FontWeight='bold');
  text(xD+0.01, yD, 'V', FontSize=12, FontWeight='bold');
  text(0.01, 0, 'O', FontSize=12, FontWeight='bold');
  xlabel('x [m]', 'Interpreter','LaTex', 'FontSize', 16);
  ylabel('y [m]', 'Interpreter','LaTex', 'FontSize', 16);
  title('Revolute joint configuration', 'Interpreter','LaTex', 'FontSize', 16);

  %[phi, x, fval, l1, l2]
  title(['$l_1+l_2=', num2str(vysledky(i, 4)+vysledky(i,5)), ',\ \varphi=', num2str(vysledky(i, 1)), ',\ err=', num2str(vysledky(i, 3)), '$'], 'Interpreter','LaTex', 'FontSize', 16)
  pause(0.01);
  if((vysledky(i, 1)>pi/3) & (vysledky(i, 1)<(pi/3+0.01)))
    print('revolute_joint_scheme', '-dpng', '-r600');
  end;

  hold off;
end;

figure(20);
hold on;
grid on;
plot(vysledky(:,1), (vysledky(:,3)), 'LineWidth', 3)
xlabel('$\varphi [rad]$', 'Interpreter','LaTex', 'FontSize', 16);
ylabel('Deviation [m]', 'Interpreter','LaTex', 'FontSize', 16);
title('Cable length deviation', 'Interpreter','LaTex', 'FontSize', 16);
print('cable_length_deviation', '-dpng', '-r600');


figure(30);
hold on;
grid on;
plot(vysledky(:,1), k_cable*(vysledky(:,3)), 'LineWidth', 3)
xlabel('$\varphi [rad]$', 'Interpreter','LaTex', 'FontSize', 16);
ylabel('Cable force [N]', 'Interpreter','LaTex', 'FontSize', 16);
title('Cable force caused by the cable length deviation', 'Interpreter','LaTex', 'FontSize', 16);
print('cable_force_deviation', '-dpng', '-r600');
