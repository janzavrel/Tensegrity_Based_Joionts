%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% 3D tensegrity robot Valasek like %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all, close all, clc

%parameters
parameters;

%figure numbers

fig_structure=10;

%% vykresleni struktury
figure(fig_structure);
hold on;
axis equal;
grid on
view(-37.5, 30);
xlabel('x [m]');
ylabel('y [m]');
zlabel('z [m]');
%base frame points
for(i=1:size(F, 1))
  plot3(F(i, 1), F(i, 2), F(i, 3), 'ok', 'MarkerSize', 5, 'LineWidth', 3);
end;
%base bars
for(i=1:size(F, 1))
  plot3([F(i, 1), G(i, 1)], [F(i, 2), G(i, 2)], [F(i, 3), G(i, 3)], 'k', 'LineWidth', 3);
end;

%% bars positions
%stage1
vertical_shift=0.02;
A1=[(G1+G2+G3)/3];
A1(3)=A1(3)-vertical_shift;
fix1=0.1;
fiy1=0.1;
r1B1=[Tfix(fix1)*Tfiy(fiy1)*[0, 0, l(1), 1]'];
B1=A1+r1B1(1:3, :)';
A2=[(G4+G5+G6)/3];
A2(3)=A2(3)-vertical_shift;
fix2=0.1;
fiy2=-0.1;
r1B2=[Tfix(fix2)*Tfiy(fiy2)*[0, 0, l(2), 1]'];
B2=A2+r1B2(1:3, :)';
A3=[(G7+G8+G9)/3];
A3(3)=A3(3)-vertical_shift;
fix3=0.1;
fiy3=-0.1;
r1B3=[Tfix(fix3)*Tfiy(fiy3)*[0, 0, l(3), 1]'];
B3=A3+r1B3(1:3, :)';
%stage 2
A4=[(B1+B2+B3)/3];
A4(3)=A4(3)-vertical_shift;
fix4=0.3;
fiy4=0.3;
r1B4=[Tfix(fix4)*Tfiy(fiy4)*[0, 0, l(4), 1]'];
B4=A4+r1B4(1:3, :)';


%% figure - base bars
bars=[A1 B1
      A2 B2
      A3 B3
      A4 B4];
for(i=1:size(bars, 1))
    plot3([bars(i, 1), bars(i, 4)], [bars(i, 2), bars(i, 5)], [bars(i, 3), bars(i, 6)], 'b-', 'LineWidth', 3);
    text((bars(i, 1)+bars(i, 4))/2, (bars(i, 2)+bars(i, 5))/2, (bars(i, 3)+bars(i, 6))/2, ['b', num2str(i)]);
end;
%% cables
%connection table
cables=[A1 G1
        A1 G2
        A1 G3
        B1 G1
        B1 G2
        B1 G3
        A2 G4
        A2 G5
        A2 G6
        B2 G4
        B2 G5
        B2 G6
        A3 G7
        A3 G8
        A3 G9
        B3 G7
        B3 G8
        B3 G9
        A4 B1
        A4 B2
        A4 B3
        B4 B1
        B4 B2
        B4 B3];

%% figure - plot cables
for(i=1:size(cables, 1))
    plot3([cables(i, 1), cables(i, 4)], [cables(i, 2), cables(i, 5)], [cables(i, 3), cables(i, 6)], 'r-.', 'LineWidth', 1);
    text((cables(i, 1)+cables(i, 4))/2, (cables(i, 2)+cables(i, 5))/2, (cables(i, 3)+cables(i, 6))/2, ['c',num2str(i)])
end;

%% figure - plot POINTS A, B, G
move_z=-0.01;
text(A1(1), A1(2), A1(3)+move_z, 'A_1');
text(A2(1), A2(2), A2(3)+move_z, 'A_2');
text(A3(1), A3(2), A3(3)+move_z, 'A_3');
text(A4(1), A4(2), A4(3)+move_z, 'A_4');
move_z=+0.01;
text(B1(1), B1(2), B1(3)+move_z, 'B_1');
text(B2(1), B2(2), B2(3)+move_z, 'B_2');
text(B3(1), B3(2), B3(3)+move_z, 'B_3');
text(B4(1), B4(2), B4(3)+move_z, 'B_4');
move_z=+0.01;
text(G1(1), G1(2), G1(3)+move_z, 'G_1');
text(G2(1), G2(2), G2(3)+move_z, 'G_2');
text(G3(1), G3(2), G3(3)+move_z, 'G_3');
text(G4(1), G4(2), G4(3)+move_z, 'G_4');
text(G5(1), G5(2), G5(3)+move_z, 'G_5');
text(G6(1), G6(2), G6(3)+move_z, 'G_6');
text(G7(1), G7(2), G7(3)+move_z, 'G_7');
text(G8(1), G8(2), G8(3)+move_z, 'G_8');
text(G9(1), G9(2), G9(3)+move_z, 'G_9');


%% cables lengths in initial position
lengths_0=[];
for(i=1:size(cables, 1))
    l_i=sqrt((cables(i, 1) - cables(i, 4))^2 + (cables(i, 2) - cables(i, 5))^2 + (cables(i, 3) - cables(i, 6))^2);
    lengths_0=[lengths_0; l_i];
end;



