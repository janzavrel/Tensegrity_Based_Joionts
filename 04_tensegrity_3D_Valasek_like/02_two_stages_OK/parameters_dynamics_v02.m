%bars or cables, bar=1, cable=0?
%bar_or_cable=0; %CABLES
bar_or_cable=1; %BARS

%force coefficient - direction of the internal force 
%force_coefficient=1; %
force_coefficient=-1; %

% dimensions of bars and mass properties
a=0.015; % square cut - dimension [m]
rho=2700; % density [kg/m3]

% springs & thier dumping
kk=1e5; % stiffness [N/m/m]
bb=100; % dumping coeff. [N/m/s]

k_all=kk*ones(size(l0_all, 1), 1);
b_all=bb*ones(size(l0_all, 1), 1);