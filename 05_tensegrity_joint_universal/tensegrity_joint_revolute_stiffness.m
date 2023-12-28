%% Stiffness of the revolute joint
clear all, close all, clc;

%%Parameters of the tensegrity
parameters_tensegrity_joint;

t_end=1;
t_measure=0.5;

%% loop over all positions
fi_limit=pi/3;
fi_deleni=19;
F_predpeti=100; % [N]
F_load=10; % [N]
joint_stiffness=[];
[FIX, FIZ] = meshgrid([-fi_limit:fi_limit/(fi_deleni-1)*2:fi_limit], [-fi_limit:fi_limit/(fi_deleni-1)*2:fi_limit]);

% selected position
fiz=0;
for(fix=-fi_limit:fi_limit/(fi_deleni-1)*2:fi_limit)
        disp(['fix=', num2str(fix), ' fiz=', num2str(fiz)]);
        l0_all=cables_l0(fix, fiz, w, h, b);

        %ze sily v lane zajistim predpeti v % zkraceni volne delky
        ll=l0_all(1)-F_predpeti/k_all(1);
        predpeti=ll/l0_all(1);

        ll=l0_all-F_predpeti./k_all;
        predpeti_all=ll./l0_all;
        out=sim("tensegrity_joint_universal.slx");
        joint_stiffness=[joint_stiffness; [fix, fiz, out.pos_x.Data(1), out.pos_x.Data(2), out.pos_x.Data(3), out.pos_x.Data(end), out.pos_y.Data(end), out.pos_z.Data(end), F_predpeti, F_load]];
end;
eval(['save joint_stiffness_revolute_', 'Fl', num2str(F_load), 'Fs', num2str(F_predpeti), ' joint_stiffness']);
eval(['save FIX_revolute_', 'Fl', num2str(F_load), 'Fs', num2str(F_predpeti), ' FIX']);
eval(['save FIZ_revolute_', 'Fl', num2str(F_load), 'Fs', num2str(F_predpeti), ' FIZ']);

%% plot
figure(10);
hold on;
grid on;
plot(joint_stiffness(:, 1), joint_stiffness(:, 6)-joint_stiffness(:, 3));
xlabel('$\varphi_x$', 'Interpreter', 'latex');
ylabel('$x_{distance}$', 'Interpreter','latex')
