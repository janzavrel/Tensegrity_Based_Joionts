%%% Parameters of the tensegrity joint

%% geometrical parameters
w=0.1; %width
b=0.05; %
h=0.1;
a=0.008; % cross dimension

%data for kinematic model and inverse kinematics
h1=h+b/2;
l3=h+b/2;


%% physical parameters
num_cables=8;
%cable stiffness
kk=1e4;
k_all=kk*ones(num_cables, 1);
%cable damping
bb=10;
b_all=bb*ones(num_cables, 1);