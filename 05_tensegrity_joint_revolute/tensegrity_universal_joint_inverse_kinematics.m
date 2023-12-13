%% Universal joint inverse kinematics

clear all, close all, clc;

syms y fix fiz h1 l3

%% umiversal joint description
T13=Ty(h1)*Tfiz(fiz)*Tfix(fix)*Ty(l3);
r1M=T13*[0 0 0 1]';

% x1M=-l3*cos(fix)*sin(fiz)
% y1M=h1 + l3*cos(fix)*cos(fiz)
% z1M=l3*sin(fix)

%% Operational space of the universal joint
parameters_tensegrity_joint;
fi_step=0.05;
fi_max=pi/3;
pos_M=[];
for(fiz=-fi_max:fi_step:fi_max)
    for(fix=-fi_max:fi_step:fi_max)
        pos_M=[pos_M; [fix, fiz, -l3*cos(fix)*sin(fiz), h1 + l3*cos(fix)*cos(fiz), l3*sin(fix)]];
    end;
end;
save pos_M pos_M;

% figure(10);
% hold on;
% grid on;
% xlabel('x [m]');
% ylabel('y [m]');
% zlabel('z [m]');
% plot3(pos_M(:, 3), pos_M(:, 4), pos_M(:, 5), '*');

figure(20);
[fix,fiz] = meshgrid(-fi_max:fi_step:fi_max);
XM=[];
YM=[];
ZM=[];
for(row=1:size(fix, 1))
    for(col=1:size(fix, 2))
        % x1M=-l3*cos(fix)*sin(fiz)
        % y1M=h1 + l3*cos(fix)*cos(fiz)
        % z1M=l3*sin(fix)
        XM(row, col)=-l3*cos(fix(row, col))*sin(fiz(row, col));
        YM(row, col)=h1 + l3*cos(fix(row, col))*cos(fiz(row, col));
        ZM(row, col)=l3*sin(fix(row, col));
    end;
end;
sc = mesh(XM,ZM,YM);
view(-53, 31)
title('Workspace of the point M', 'Interpreter','LaTex');
xlabel('$x_M$ [m]', 'Interpreter','LaTex');
ylabel('$y_M$ [m]', 'Interpreter','LaTex');
zlabel('$z_M$ [m]', 'Interpreter','LaTex');

figure(30);
[fix,fiz] = meshgrid(-fi_max:fi_step:fi_max);
XM=[];
YM=[];
ZM=[];
for(row=1:size(fix, 1))
    for(col=1:size(fix, 2))
        % x1M=-l3*cos(fix)*sin(fiz)
        % y1M=h1 + l3*cos(fix)*cos(fiz)
        % z1M=l3*sin(fix)
        XM(row, col)=-l3*cos(fix(row, col))*sin(fiz(row, col));
        YM(row, col)=h1 + l3*cos(fix(row, col))*cos(fiz(row, col));
        ZM(row, col)=l3*sin(fix(row, col));
    end;
end;
sc = mesh(fix,fiz,YM);
view(-38, 37)
title('Workspace of the point M', 'Interpreter','LaTex');
xlabel('$\varphi_x$ [rad]', 'Interpreter','LaTex');
ylabel('$\varphi_y$ [rad]', 'Interpreter','LaTex');
zlabel('$z_M$ [m]', 'Interpreter','LaTex');
