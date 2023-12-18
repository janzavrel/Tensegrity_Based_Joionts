%fix, fiz, out.pos_x.Data(1), out.pos_x.Data(2), out.pos_x.Data(3), out.pos_x.Data(end), out.pos_y.Data(end), out.pos_z.Data(end), F_predpeti
load FIX_universal_Fl100Fs200.mat;
load FIZ_universal_Fl100Fs200.mat;
load joint_stiffness_universal_Fl100Fs200.mat

%data generating
MAP_x=[];
MAP_y=[];
MAP_z=[];
err=0.001; %searching inaccuracy
for(i=1:size(joint_stiffness, 1))
    row=find((FIX(1, :)<joint_stiffness(i, 1)+err) & (FIX(1, :)>joint_stiffness(i, 1)-err));
    col=find((FIZ(:, 1)<joint_stiffness(i, 2)+err) & (FIZ(:, 1)>joint_stiffness(i, 2)-err));
    MAP_x(row, col)=(abs(joint_stiffness(i, 6)-joint_stiffness(i, 3)));
    MAP_y(row, col)=(abs(joint_stiffness(i, 7)-joint_stiffness(i, 4)));
    MAP_z(row, col)=(abs(joint_stiffness(i, 8)-joint_stiffness(i, 5)));
    disp([num2str(joint_stiffness(i, 1)), ' nalezeno row: ', num2str(row), ' col:', num2str(col), ' VALUE:', num2str(joint_stiffness(i, 6)-joint_stiffness(i, 3))]);
end;
MAP_dist=sqrt(MAP_x.^2 + MAP_y.^2 + MAP_z.^2); 
sc = mesh(FIX,FIZ,MAP_y);
view(-130, 27)
title('Total deformation', 'Interpreter','LaTex');
xlabel('$\varphi_x$ [rad]', 'Interpreter','LaTex');
ylabel('$\varphi_z$ [rad]', 'Interpreter','LaTex');
zlabel('$\Delta$ [m]', 'Interpreter','LaTex');


