clear all, close all, clc;

%1    2    3                  4                  5
%fix, fiz, out.pos_x.Data(2), out.pos_y.Data(2), out.pos_z.Data(2),...
%          6                    7                    8
%          out.pos_x.Data(end), out.pos_y.Data(end), out.pos_z.Data(end),...
%          9                  10
%          out.rot_Y.Data(2), out.rot_Y.Data(end),...
%          11          12       13       14       15       16       17
%          F_predpeti, Fx_load, Fy_load, Fz_load, Mx_load, My_load, Mz_load;

% Fxyz load, dist_xyz
graph_file_name='universal_joint_Fxyz_load';
text_title='XYZ-axis load stiffness';
text_x='$\varphi_x$ [rad]';
text_y='$\varphi_z$ [rad]';
text_z='Total stiffness [$Nm^{-1}$]';
load joint_stiffness_universal_Fp200_10_10_10_0_0_0_div10.mat
load FIX_universal_Fp200_10_10_10_0_0_0_div10.mat
load FIZ_universal_Fp200_10_10_10_0_0_0_div10.mat;

% %OK - stiffness
% %Fy load, dist_xyz
% graph_file_name='universal_joint_Fy_load';
% text_title='Y-axis load stiffness';
% text_x='$\varphi_x$ [rad]';
% text_y='$\varphi_z$ [rad]';
% text_z='Stiffness [$Nm^{-1}$]';
% load joint_stiffness_universal_Fp200_0_10_0_0_0_0_div20.mat
% load FIX_universal_Fp200_0_10_0_0_0_0_div20.mat
% load FIZ_universal_Fp200_0_10_0_0_0_0_div20.mat

% %OK - rotation
% %My torque load, dist_fiy
% graph_file_name='universal_joint_torque_load';
% text_title='Torque load deformation';
% text_x='$\varphi_x$ [rad]';
% text_y='$\varphi_z$ [rad]';
% %text_z='Stiffness [$Nm^{-1}$]';
% text_z='$\Delta_{\varphi}$ [rad]';
% load joint_stiffness_universal_Fp200_0_0_0_0_10_0_div20.mat
% load FIX_universal_Fp200_0_0_0_0_10_0_div20.mat
% load FIZ_universal_Fp200_0_0_0_0_10_0_div20.mat


% load joint_stiffness_universal_Fp200_20_20_20_0_0_0.mat
% load FIX_universal_Fp200_20_20_20_0_0_0.mat
% load FIZ_universal_Fp200_20_20_20_0_0_0.mat;

% load joint_stiffness_universal_Fp200_0_0_0_0_1_0.mat
% load FIX_universal_Fp200_0_0_0_0_1_0.mat
% load FIZ_universal_Fp200_0_0_0_0_1_0.mat;

% load joint_stiffness_universal_Fp200_0_0_0_0_10_0.mat
% load FIX_universal_Fp200_0_0_0_0_10_0.mat
% load FIZ_universal_Fp200_0_0_0_0_10_0.mat;

F_preload=joint_stiffness(1, 11);
Fx_load=joint_stiffness(1, 12); 
Fy_load=joint_stiffness(1, 13); 
Fz_load=joint_stiffness(1, 14); 
Mx_load=joint_stiffness(1, 15); 
My_load=joint_stiffness(1, 16); 
Mz_load=joint_stiffness(1, 17); 

%data generating
MAP_x=[];
MAP_y=[];
MAP_z=[];
MAP_rotY=[];
err=0.001; %searching inaccuracy
for(i=1:size(joint_stiffness, 1))
    row=find((FIX(1, :)<joint_stiffness(i, 1)+err) & (FIX(1, :)>joint_stiffness(i, 1)-err));
    col=find((FIZ(:, 1)<joint_stiffness(i, 2)+err) & (FIZ(:, 1)>joint_stiffness(i, 2)-err));
    MAP_x(row, col)=(abs(joint_stiffness(i, 6)-joint_stiffness(i, 3)));
    MAP_y(row, col)=(abs(joint_stiffness(i, 7)-joint_stiffness(i, 4)));
    MAP_z(row, col)=(abs(joint_stiffness(i, 8)-joint_stiffness(i, 5)));
    MAP_rotY(row, col)=(abs(joint_stiffness(i, 10)-joint_stiffness(i, 9)));
    disp([num2str(joint_stiffness(i, 1)), ' nalezeno row: ', num2str(row), ' col:', num2str(col), ' VALUE:', num2str(joint_stiffness(i, 6)-joint_stiffness(i, 3))]);
end;

figure(20);
hold on;
grid on;
MAP_dist_xyz=sqrt(MAP_x.^2 + MAP_y.^2 + MAP_z.^2); 
MAP_dist_xy=sqrt(MAP_x.^2 + MAP_y.^2); 
MAP_dist_xz=sqrt(MAP_x.^2 + MAP_z.^2); 
F_load=sqrt((Fx_load^2+Fy_load^2+Fz_load^2));
M_load=sqrt((Mx_load^2+My_load^2+Mz_load^2));
sc = mesh(FIX, FIZ, F_load./MAP_dist_xyz, 'LineWidth', 2);
%sc = mesh(FIX, FIZ, M_load./MAP_rotY, 'LineWidth', 2);
%sc = mesh(FIX, FIZ, MAP_rotY, 'LineWidth', 2);
view(-130, 27);
view(46, 40);
title(text_title, 'Interpreter','LaTex', 'FontSize', 16);
xlabel(text_x, 'Interpreter','LaTex', 'FontSize', 16);
ylabel(text_y, 'Interpreter','LaTex', 'FontSize', 16);
zlabel(text_z, 'Interpreter','LaTex', 'FontSize', 16);

print(graph_file_name, '-dpng', '-r600');