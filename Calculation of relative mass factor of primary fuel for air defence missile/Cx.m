function cx = Cx(Ma,alpha)
% 插值阻力因数
a = 2:2:10;
ma = [1.5:0.6:3.3,4];
[X,Y] = meshgrid(a,ma);
V = [0.0430,0.0511,0.0651,0.0847,0.1120;
     0.0360,0.0436,0.0558,0.0736,0.0973;
     0.0308,0.0372,0.0481,0.0641,0.0849;
     0.0265,0.0323,0.0419,0.0560,0.0746;
     0.0222,0.0272,0.0356,0.0478,0.0644];
cx = interp2(X,Y,V,alpha,Ma,'spline');

end
