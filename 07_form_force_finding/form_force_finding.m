%%% Form finding and force finding, static force and deformation analysis

clear all, close all, clc;

%% parameters
l1=0.5;
l2=0.5;
a1=0.1;
b1=0.05;
phiz1=pi/3;
phiz2=2*pi-pi/4;
d=0.4;
k1=200; %[N/m]
k2=300; %[N/m]
k3=500; %[N/m]

% Bodies
BODY=[0, 0, 0, 0, 0, phiz1   %BODY 1
      d, 0, 0, 0, 0, phiz2]; %BODY 2
% Nodes
NODE=[1, 0, 0, 0        % NODE 1
      2, 0, 0, 0        % NODE 2
      1, l1, 0, 0       % NODE 3
      1, (l1-a1), b1, 0 % NODE 4
      2, -l2, 0, 0];    % NODE 5
% Springs
SPRING=[1, 5, k1
        2, 3, k2
        4, 5, k3];
% Boundary conditions
BC=[1 1 1 1 1 1 0
    2 1 1 1 1 1 0];

%% Plot the system
figure(10);
hold on;
grid on;
axis equal;
title('The tensegrity system');
xlabel('x [m]');
ylabel('y [m]');
zlabel('z [m]');
view(0, 90);
view(31, 57);
%Body plot
for(body=1:size(BODY, 1))
  % Body transform
  TT=Tx(BODY(body, 1))*Ty(BODY(body, 2))*Tz(BODY(body, 3))*...
     Tfix(BODY(body, 4))*Tfiy(BODY(body, 5))*Tfiz(BODY(body, 6));
  %nodes selection
  NN=NODE(find(NODE(:, 1)==body), :);
  XX=[];
  YY=[];
  ZZ=[];
  for(row=1:size(NN, 1))
     rNN=TT*[NN(row, 2), NN(row, 3), NN(row, 4), 1]';
     XX=[XX, rNN(1)];
     YY=[YY, rNN(2)];
     ZZ=[ZZ, rNN(3)];
  end;
  plot3([XX, XX(1)], [YY, YY(1)], [ZZ, ZZ(1)], 'LineWidth', 3);

end;
%Node plot
for(node=1:size(NODE, 1))
    body=NODE(node, 1); 
    TT=Tx(BODY(body, 1))*Ty(BODY(body, 2))*Tz(BODY(body, 3))*...
       Tfix(BODY(body, 4))*Tfiy(BODY(body, 5))*Tfiz(BODY(body, 6));
    rN=TT*[NODE(node, 2), NODE(node, 3), NODE(node, 4), 1]';
    text(rN(1), rN(2), rN(3), ['N', num2str(node)]);
end;
%Spring plot
for(spring=1:size(SPRING, 1))
   N_from=SPRING(spring, 1)
   N_to=SPRING(spring, 2)
   body_from=NODE(N_from, 1) 
   body_to=NODE(N_to, 1) 

   TTf=Tx(BODY(body_from, 1))*Ty(BODY(body_from, 2))*Tz(BODY(body_from, 3))*...
       Tfix(BODY(body_from, 4))*Tfiy(BODY(body_from, 5))*Tfiz(BODY(body_from, 6));
   rNf=TTf*[NODE(N_from, 2), NODE(N_from, 3), NODE(N_from, 4), 1]';
   TTt=Tx(BODY(body_to, 1))*Ty(BODY(body_to, 2))*Tz(BODY(body_to, 3))*...
       Tfix(BODY(body_to, 4))*Tfiy(BODY(body_to, 5))*Tfiz(BODY(body_to, 6));
   rNt=TTt*[NODE(N_to, 2), NODE(N_to, 3), NODE(N_to, 4), 1]';
   plot3([rNf(1), rNt(1)], [rNf(2), rNt(2)], [rNf(3), rNt(3)], 'k-.', 'LineWidth', 1);    
end;
