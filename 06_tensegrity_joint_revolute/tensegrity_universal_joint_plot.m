%%% Tensegrity universal joint plot

clear all, close all, clc;

parameters_tensegrity_joint;

% selected position
fix=0;
fiz=0;


%l1=|A2U3|
%l2=|B2V3|
%l3=|V3V2|
%l4=|U3V2|
%l5=|U3U2|
%l6=|U2V3|
%l7=|V2B3|
%l8=|U2A3|

r1A2=[0, 0, w/2, 1]';
r1B2=[0, 0, -w/2, 1]';
r1U2=[-w/2, h+b, 0, 1]';
r1V2=[w/2, h+b, 0, 1]';

h1=h+b/2;
l3=h+b/2;
T13=Ty(h1)*Tfiz(fiz)*Tfix(fix);
r1E3=T13*[0, l3, 0, 1]';
r1A3=T13*[w/2, h+b/2, 0, 1]';
r1B3=T13*[-w/2, h+b/2, 0, 1]';
r1V3=T13*[0, -b/2, w/2, 1]';
r1U3=T13*[0, -b/2, -w/2, 1]';

l01=sqrt(sum((r1A2(1:3)-r1U3(1:3)).^2));
l02=sqrt(sum((r1B2(1:3)-r1V3(1:3)).^2));
l03=sqrt(sum((r1V3(1:3)-r1V2(1:3)).^2));
l04=sqrt(sum((r1U3(1:3)-r1V2(1:3)).^2));
l05=sqrt(sum((r1U3(1:3)-r1U2(1:3)).^2));
l06=sqrt(sum((r1U2(1:3)-r1V3(1:3)).^2));
l07=sqrt(sum((r1V2(1:3)-r1B3(1:3)).^2));
l08=sqrt(sum((r1U2(1:3)-r1A3(1:3)).^2));

l0_all=[l01, l02, l03, l04, l05, l06, l07, l08];


%% tensegrity plot
%bottom body
r1M2=[0, h, 0, 1]';
r1E2=[0 0 0 1]';
r1U2B=[-w/2, h, 0, 1]';
r1V2B=[w/2, h, 0, 1]';
r1U2=[-w/2, h+b, 0, 1]';
r1V2=[w/2, h+b, 0, 1]';
A2=r1A2(1:3);
B2=r1B2(1:3);
M2=r1M2(1:3);
E2=r1E2(1:3);
U2B=r1U2B(1:3);
V2B=r1V2B(1:3);
U2=r1U2(1:3);
V2=r1V2(1:3);

%upper body
r1M3=T13*[0, b/2, 0, 1]';
r1E3=T13*[0 b/2+h 0 1]';
r1U3B=T13*[0, b/2, -w/2, 1]';
r1V3B=T13*[0, b/2, w/2, 1]';
r1U3=T13*[0, -b/2, -w/2, 1]';
r1V3=T13*[0, -b/2, w/2, 1]';
A3=r1A3(1:3);
B3=r1B3(1:3);
M3=r1M3(1:3);
E3=r1E3(1:3);
U3B=r1U3B(1:3);
V3B=r1V3B(1:3);
U3=r1U3(1:3);
V3=r1V3(1:3);


tloustka_teleso=5;
style_teleso_2='-b';
figure(10);
hold on;
grid on;
view(60, 30);
view(103, 15);
xlabel('x [m]');
ylabel('y [m]');
zlabel('z [m]');
%bottom body
plot3([A2(1), B2(1)], [A2(2), B2(2)], [A2(3), B2(3)], style_teleso_2, 'LineWidth', tloustka_teleso);
plot3([E2(1), M2(1)], [E2(2), M2(2)], [E2(3), M2(3)], style_teleso_2, 'LineWidth', tloustka_teleso);
plot3([U2B(1), V2B(1)], [U2B(2), V2B(2)], [U2B(3), V2B(3)], style_teleso_2, 'LineWidth', tloustka_teleso);
plot3([U2B(1), U2(1)], [U2B(2), U2(2)], [U2B(3), U2(3)], style_teleso_2, 'LineWidth', tloustka_teleso);
plot3([V2B(1), V2(1)], [V2B(2), V2(2)], [V2B(3), V2(3)], style_teleso_2, 'LineWidth', tloustka_teleso);
%upper body
style_teleso_3='-m';
plot3([A3(1), B3(1)], [A3(2), B3(2)], [A3(3), B3(3)], style_teleso_3, 'LineWidth', tloustka_teleso);
plot3([E3(1), M3(1)], [E3(2), M3(2)], [E3(3), M3(3)], style_teleso_3, 'LineWidth', tloustka_teleso);
plot3([U3B(1), V3B(1)], [U3B(2), V3B(2)], [U3B(3), V3B(3)], style_teleso_3, 'LineWidth', tloustka_teleso);
plot3([U3B(1), U3(1)], [U3B(2), U3(2)], [U3B(3), U3(3)], style_teleso_3, 'LineWidth', tloustka_teleso);
plot3([V3B(1), V3(1)], [V3B(2), V3(2)], [V3B(3), V3(3)], style_teleso_3, 'LineWidth', tloustka_teleso);

%cables
tloustka_lano=1;
style_lano='-.r';
%l1=|A2U3|
Z=A2; DO=U3;
plot3([Z(1), DO(1)], [Z(2), DO(2)], [Z(3), DO(3)], style_lano, 'LineWidth', tloustka_lano);
text([(Z(1)+DO(1))/2], [(Z(2)+DO(2))/2], [(Z(3)+DO(3))/2+0.005], 'c_1', 'Color', 'k', 'FontSize', 16);
%l2=|B2V3|
Z=B2; DO=V3;
plot3([Z(1), DO(1)], [Z(2), DO(2)], [Z(3), DO(3)], style_lano, 'LineWidth', tloustka_lano);
text([(Z(1)+DO(1))/2], [(Z(2)+DO(2))/2+0.005], [(Z(3)+DO(3))/2-0.01], 'c_2', 'Color', 'k', 'FontSize', 16);
%l3=|V3V2|
Z=V3; DO=V2;
plot3([Z(1), DO(1)], [Z(2), DO(2)], [Z(3), DO(3)], style_lano, 'LineWidth', tloustka_lano);
text([(Z(1)+DO(1))/2], [(Z(2)+DO(2))/2], [(Z(3)+DO(3))/2+0.005], 'c_3', 'Color', 'k', 'FontSize', 16);
%l4=|U3V2|
Z=U3; DO=V2;
plot3([Z(1), DO(1)], [Z(2), DO(2)], [Z(3), DO(3)], style_lano, 'LineWidth', tloustka_lano);
text([(Z(1)+DO(1))/2], [(Z(2)+DO(2))/2], [(Z(3)+DO(3))/2+0.005], 'c_4', 'Color', 'k', 'FontSize', 16);
%l5=|U3U2|
Z=U3; DO=U2;
plot3([Z(1), DO(1)], [Z(2), DO(2)], [Z(3), DO(3)], style_lano, 'LineWidth', tloustka_lano);
text([(Z(1)+DO(1))/2], [(Z(2)+DO(2))/2], [(Z(3)+DO(3))/2+0.005], 'c_5', 'Color', 'k', 'FontSize', 16);
%l6=|U2V3|
Z=U2; DO=V3;
plot3([Z(1), DO(1)], [Z(2), DO(2)], [Z(3), DO(3)], style_lano, 'LineWidth', tloustka_lano);
text([(Z(1)+DO(1))/2], [(Z(2)+DO(2))/2], [(Z(3)+DO(3))/2+0.005], 'c_6', 'Color', 'k', 'FontSize', 16);
%l7=|V2B3|
Z=V2; DO=B3;
plot3([Z(1), DO(1)], [Z(2), DO(2)], [Z(3), DO(3)], style_lano, 'LineWidth', tloustka_lano);
text([(Z(1)+DO(1))/2], [(Z(2)+DO(2))/2], [(Z(3)+DO(3))/2+0.005], 'c_7', 'Color', 'k', 'FontSize', 16);
%l8=|U2A3|
Z=U2; DO=A3;
plot3([Z(1), DO(1)], [Z(2), DO(2)], [Z(3), DO(3)], style_lano, 'LineWidth', tloustka_lano);
text([(Z(1)+DO(1))/2], [(Z(2)+DO(2))/2+0.005], [(Z(3)+DO(3))/2-0.01], 'c_8', 'Color', 'k', 'FontSize', 16);

%points
points_color='k';
text(A2(1)+0.005, A2(2)+0.005, A2(3)+0.005, 'A_2', 'Color', points_color, 'FontSize', 16)
text(B2(1)+0.005, B2(2)+0.005, B2(3)+0.005, 'B_2', 'Color', points_color, 'FontSize', 16)
text(U2(1)+0.005, U2(2)+0.005, U2(3)+0.005, 'U_2', 'Color', points_color, 'FontSize', 16)
text(V2(1)+0.005, V2(2)+0.005, V2(3)+0.005, 'V_2', 'Color', points_color, 'FontSize', 16)
text(A3(1)+0.005, A3(2)+0.005, A3(3)+0.005, 'A_3', 'Color', points_color, 'FontSize', 16)
text(B3(1)+0.005, B3(2)+0.005, B3(3)+0.005, 'B_3', 'Color', points_color, 'FontSize', 16)
text(U3(1)+0.005, U3(2)+0.005, U3(3)+0.005, 'U_3', 'Color', points_color, 'FontSize', 16)
text(V3(1)+0.005, V3(2)+0.005, V3(3)+0.005, 'V_3', 'Color', points_color, 'FontSize', 16)
text(E2(1)+0.005, E2(2)+0.005, E2(3)+0.005, 'E_2', 'Color', points_color, 'FontSize', 16)
text(E3(1)+0.005, E3(2)+0.005, E3(3)+0.005, 'E_3', 'Color', points_color, 'FontSize', 16)
text(U2B(1)+0.005, U2B(2)+0.005, U2B(3)+0.005, 'U_{2B}', 'Color', points_color, 'FontSize', 16)
text(V2B(1)+0.005, V2B(2)+0.005, V2B(3)+0.005, 'V_{2B}', 'Color', points_color, 'FontSize', 16)
text(U3B(1)+0.005, U3B(2)+0.005, U3B(3)+0.005, 'U_{3B}', 'Color', points_color, 'FontSize', 16)
text(V3B(1)+0.005, V3B(2)+0.005, V3B(3)+0.005, 'V_{3B}', 'Color', points_color, 'FontSize', 16)
% text((1)+0.005, (2)+0.005, (3)+0.005, '', 'Color', points_color, 'FontSize', 16)
