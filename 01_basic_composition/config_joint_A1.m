%%% Tensegrity joint A1

%% bacis topological parameters and dimensiont
% rigid bodies are used
a=0.05;
b=0.025;
r=0.03;

h1=0.1;
h2=0.15;
d=0.005;

%connecting points (angles in DEG!)
phi=2*pi/10*[1:10]*180/pi;

%% cables
kc=1e5; %cable stiffness N/m/m
bc=0.3; %cable dumping
p=0.8; %prestress length of the natural length

%% other parameters
rho_Al=2700; %density of Aluminium

%% computed dimensions and parameters
l0=sqrt((b^2 + r^2)); %natural length of the axis cable
l0_p=l0*p; %prestressed spring
