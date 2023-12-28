function [l0_all, xE3, yE3, zE3]=cables_l0(fix, fiz, w, h, b)
%l1=|A2U3|
%l2=|B2V3|
%l3=|V3V2|
%l4=|U3V2|
%l5=|U3U2|
%l6=|U2V3|
%l7=|V2B3|
%l8=|U2A3|

r1A2=[0, 0, w/2, 1]';
r1B2=[0, 0, -w/2, 1]';
r1U2=[-w/2, h+b, 0, 1]';
r1V2=[w/2, h+b, 0, 1]';

h1=h+b/2;
l3=h+b/2;
T13=Ty(h1)*Tfiz(fiz)*Tfix(fix);
r1E3=T13*[0, h+b/2, 0, 1]';
xE3=r1E3(1);
yE3=r1E3(2);
zE3=r1E3(3);
r1A3=T13*[w/2, h+b/2, 0, 1]';
r1B3=T13*[-w/2, h+b/2, 0, 1]';
r1V3=T13*[0, -b/2, w/2, 1]';
r1U3=T13*[0, -b/2, -w/2, 1]';

l01=sqrt(sum((r1A2(1:3)-r1U3(1:3)).^2));
l02=sqrt(sum((r1B2(1:3)-r1V3(1:3)).^2));
l03=sqrt(sum((r1V3(1:3)-r1V2(1:3)).^2));
l04=sqrt(sum((r1U3(1:3)-r1V2(1:3)).^2));
l05=sqrt(sum((r1U3(1:3)-r1U2(1:3)).^2));
l06=sqrt(sum((r1U2(1:3)-r1V3(1:3)).^2));
l07=sqrt(sum((r1V2(1:3)-r1B3(1:3)).^2));
l08=sqrt(sum((r1U2(1:3)-r1A3(1:3)).^2));

l0_all=[l01, l02, l03, l04, l05, l06, l07, l08]';