function cya = Cya(Ma,alpha)
% 插值升力因数
a = [1,2:2:10];
ma = 1.5:0.5:4;
[X,Y] = meshgrid(a,ma);
V = [0.0302,0.0304,0.0306,0.0309,0.0311,0.0313;
     0.0279,0.0280,0.0284,0.0286,0.0288,0.0290;
     0.0261,0.0264,0.0267,0.0269,0.0272,0.0274;
     0.0247,0.0248,0.0251,0.0254,0.0257,0.0259;
     0.0226,0.0227,0.0231,0.0233,0.0236,0.0238;
     0.0209,0.0210,0.0213,0.0216,0.0219,0.0221];
cya = interp2(X,Y,V,alpha,Ma,'spline');
cya = rad2deg(cya);
end

