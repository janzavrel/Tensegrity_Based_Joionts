%% Stiffness of the universal joint

%%Parameters of the tensegrity
parameters_tensegrity_joint;

t_end=1;
t_measure=0.25;

%% loop over all positions
fi_limit=pi/4;
fi_deleni=10;
F_predpeti=200; % [N]
Fx_load=10; % [N]
Fy_load=10; % [N]
Fz_load=10; % [N]
Mx_load=0; % [Nm]
My_load=0; % [Nm]
Mz_load=0; % [Nm]
suffix=['Fp', num2str(F_predpeti), '_',...
        num2str(Fx_load), '_',...
        num2str(Fy_load), '_',...
        num2str(Fz_load), '_',...
        num2str(Mx_load), '_',...
        num2str(My_load), '_',...
        num2str(Mz_load), '_div',...
        num2str(fi_deleni)];
joint_stiffness=[];
[FIX, FIZ] = meshgrid([-fi_limit:fi_limit/(fi_deleni-1)*2:fi_limit], [-fi_limit:fi_limit/(fi_deleni-1)*2:fi_limit]);

% selected position
for(fix=-fi_limit:fi_limit/(fi_deleni-1)*2:fi_limit)
    for(fiz=-fi_limit:fi_limit/(fi_deleni-1)*2:fi_limit)
        [l0_all, xE3, yE3, zE3]=cables_l0(fix, fiz, w, h, b);

        %ze sily v lane zajistim predpeti v % zkraceni volne delky
        ll=l0_all(1)-F_predpeti/k_all(1);
        predpeti=ll/l0_all(1);

        ll=l0_all-F_predpeti./k_all;
        predpeti_all=ll./l0_all;
        out=sim("tensegrity_joint_universal.slx");
%1    2    3                  4                  5
%fix, fiz, out.pos_x.Data(2), out.pos_y.Data(2), out.pos_z.Data(2),...
%          6                    7                    8
%          out.pos_x.Data(end), out.pos_y.Data(end), out.pos_z.Data(end),...
%          9                  10
%          out.rot_Y.Data(2), out.rot_Y.Data(end),...
%          11          12       13       14       15       16       17
%          F_predpeti, Fx_load, Fy_load, Fz_load, Mx_load, My_load, Mz_load;
joint_stiffness=[joint_stiffness; [fix, fiz,...
            out.pos_x.Data(2), out.pos_y.Data(2), out.pos_z.Data(2), out.pos_x.Data(end), out.pos_y.Data(end), out.pos_z.Data(end),...
            out.rot_Y.Data(2), out.rot_Y.Data(end),...
            F_predpeti, Fx_load, Fy_load, Fz_load, Mx_load, My_load, Mz_load]];
        dist_x=(out.pos_x.Data(end)-out.pos_x.Data(2));
        dist_y=(out.pos_y.Data(end)-out.pos_y.Data(2));
        dist_z=(out.pos_z.Data(end)-out.pos_z.Data(2));
        disp(['fix=', num2str(fix), ' fiz=', num2str(fiz), ' ROT_2=', num2str(out.rot_Y.Data(2)), ' ROT_End=', num2str(out.rot_Y.Data(end))]);
    end;
end;
eval(['save joint_stiffness_universal_', suffix, ' joint_stiffness']);
eval(['save FIX_universal_', suffix, ' FIX']);
eval(['save FIZ_universal_', suffix, ' FIZ']);
disp(suffix)

