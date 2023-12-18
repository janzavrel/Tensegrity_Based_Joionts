%% Stiffness of the universal joint

%%Parameters of the tensegrity
parameters_tensegrity_joint;

t_end=1;
t_measure=0.5;

%% loop over all positions
fi_limit=pi/4;
fi_deleni=9;
F_predpeti=200; % [N]
F_load=100; % [N]
joint_stiffness=[];
[FIX, FIZ] = meshgrid([-fi_limit:fi_limit/(fi_deleni-1)*2:fi_limit], [-fi_limit:fi_limit/(fi_deleni-1)*2:fi_limit]);

% selected position
for(fix=-fi_limit:fi_limit/(fi_deleni-1)*2:fi_limit)
    for(fiz=-fi_limit:fi_limit/(fi_deleni-1)*2:fi_limit)
        disp(['fix=', num2str(fix), ' fiz=', num2str(fiz)]);
        l0_all=cables_l0(fix, fiz, w, h, b);

        %ze sily v lane zajistim predpeti v % zkraceni volne delky
        ll=l0_all(1)-F_predpeti/k_all(1);
        predpeti=ll/l0_all(1);

        ll=l0_all-F_predpeti./k_all;
        predpeti_all=ll./l0_all;
        out=sim("tensegrity_joint_universal.slx");
        joint_stiffness=[joint_stiffness; [fix, fiz, out.pos_x.Data(2), out.pos_y.Data(2), out.pos_z.Data(2), out.pos_x.Data(end), out.pos_y.Data(end), out.pos_z.Data(end), F_predpeti, F_load]];
        dist_x=(out.pos_x.Data(end)-out.pos_x.Data(2));
        dist_y=(out.pos_y.Data(end)-out.pos_y.Data(2));
        dist_z=(out.pos_z.Data(end)-out.pos_z.Data(2));

    end;
end;
eval(['save joint_stiffness_universal_', 'Fl', num2str(F_load), 'Fs', num2str(F_predpeti), ' joint_stiffness']);
eval(['save FIX_universal_', 'Fl', num2str(F_load), 'Fs', num2str(F_predpeti), ' FIX']);
eval(['save FIZ_universal_', 'Fl', num2str(F_load), 'Fs', num2str(F_predpeti), ' FIZ']);


