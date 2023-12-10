%%% 3D tensegrity robot Valasek like %%%

%bars or cables?
%bar_or_cable=0; %CABLES
bar_or_cable=1; %BARS

%force coefficient - direction of the internal force 
%force_coefficient=1; %
force_coefficient=-1; %

% lengths of bars
lf=0.05*ones(9, 1);
l=[0.08 0.08 0.08 0.15]';

% dimensions of bars and mass properties
a=0.015; % square cut - dimension [m]
rho=2000; % density [kg/m3]

% springs & thier dumping
kk=5e4; % stiffness [N/m/m]
bb=100; % dumping coeff. [N/m/s]

dist=0.05; %distance parameter
%frame group 1
pos1=[0, 0, 0];
F1=[pos1(1), pos1(2), pos1(3)];
F2=[pos1(1)+dist, pos1(2), pos1(3)];
F3=[pos1(1)+dist/2, pos1(2)+dist, pos1(3)];
%frame group 3
pos2=[3*dist, 0, 0];
F4=[pos2(1), pos2(2), pos2(3)];
F5=[pos2(1)+dist, pos2(2), pos2(3)];
F6=[pos2(1)+dist/2, pos2(2)+dist, pos2(3)];
%frame group 3
pos3=[1.5*dist, 2*dist, 0];
F7=[pos3(1), pos3(2), pos3(3)];
F8=[pos3(1)+dist, pos3(2), pos3(3)];
F9=[pos3(1)+dist/2, pos3(2)+dist, pos3(3)];

F=[F1; F2; F3; F4; F5; F6; F7; F8; F9];

% top points
G=F;
G(:,3)=G(:, 3)+lf;
G1=G(1, :);
G2=G(2, :);
G3=G(3, :);
G4=G(4, :);
G5=G(5, :);
G6=G(6, :);
G7=G(7, :);
G8=G(8, :);
G9=G(9, :);

