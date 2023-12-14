%% Stiffness of the universal joint

%%Parameters of the tensegrity
parameters_tensegrity_joint;

t_end=1;
t_measure=0.5;

%% loop over all positions
fi_limit=pi/3;
fi_step=0.1;
F_predpeti=30; % [N]
joint_stiffness=[];
% selected position
for(fix=-fi_limit:fi_step:fi_limit)
    for(fiz=-fi_limit:fi_step:fi_limit)
        disp(['fix=', num2str(fix), ' fiz=', num2str(fiz)]);
        l0_all=cables_l0(fix, fiz, w, h, b);

        %ze sily v lane zajistim predpeti v % zkraceni volne delky
        ll=l0_all(1)-F_predpeti/k_all(1);
        predpeti=ll/l0_all(1);

        ll=l0_all-F_predpeti./k_all;
        predpeti_all=ll./l0_all;
        out=sim("tensegrity_joint_universal.slx");
        joint_stiffness=[joint_stiffness; [fix, fiz, out.pos_x.Data(1), out.pos_x.Data(end), out.pos_y.Data(end), out.pos_z.Data(end), F_predpeti]];
    end;
end;
save joint_stiffness joint_stiffness;

