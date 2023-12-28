%%% PLOT GRAPHS for revolute joint only (phi_z is fixed, fiz=0)
clear all, close all, clc;

%1    2    3                  4                  5
%fix, fiz, out.pos_x.Data(2), out.pos_y.Data(2), out.pos_z.Data(2),...
%          6                    7                    8
%          out.pos_x.Data(end), out.pos_y.Data(end), out.pos_z.Data(end),...
%          9                  10
%          out.rot_Y.Data(2), out.rot_Y.Data(end),...
%          11          12       13       14       15       16       17
%          F_predpeti, Fx_load, Fy_load, Fz_load, Mx_load, My_load, Mz_load;

%OK - rotation about X-axis only
% load joint_stiffness_revolute_Fp200_0_0_10_0_0_0_div21.mat
% load FIX_revolute_Fp200_0_0_10_0_0_0_div21.mat

%OK - rotation about Z-axis only
load joint_stiffness_revolute_Fp200_10_0_0_0_0_0_div21.mat
load FIZ_revolute_Fp200_10_0_0_0_0_0_div21.mat

F_preload=joint_stiffness(1, 11);
Fx_load=joint_stiffness(1, 12); 
Fy_load=joint_stiffness(1, 13); 
Fz_load=joint_stiffness(1, 14); 
Mx_load=joint_stiffness(1, 15); 
My_load=joint_stiffness(1, 16); 
Mz_load=joint_stiffness(1, 17); 

%data generating
MAP_x=(abs(joint_stiffness(:, 6)-joint_stiffness(:, 3)));
MAP_y=(abs(joint_stiffness(:, 7)-joint_stiffness(:, 4)));
MAP_z=(abs(joint_stiffness(:, 8)-joint_stiffness(:, 5)));
MAP_rotY=(abs(joint_stiffness(:, 10)-joint_stiffness(:, 9)));

figure(20);
hold on;
grid on;
MAP_dist_xyz=sqrt(MAP_x.^2 + MAP_y.^2 + MAP_z.^2); 
MAP_dist_xy=sqrt(MAP_x.^2 + MAP_y.^2); 
MAP_dist_xz=sqrt(MAP_x.^2 + MAP_z.^2); 
F_load=sqrt((Fx_load^2+Fy_load^2+Fz_load^2));
M_load=sqrt((Mx_load^2+My_load^2+Mz_load^2));
plot(FIZ, Fx_load./MAP_x, '-', 'LineWidth', 3)
title('Stiffness in X-axis', 'Interpreter','LaTex', 'FontSize', 16);
xlabel('$\varphi_z$ [rad]', 'Interpreter','LaTex', 'FontSize', 16);
ylabel('Stiffness [$Nm^{-1}$]', 'Interpreter','LaTex', 'FontSize', 16);
print('revolute_joint_stiffnes_X', '-dpng', '-r600');

