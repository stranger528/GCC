function ellipseHdl=get_guass_ellipse(Mu,Sigma,para)
%Mu中心
%Sigma协方差矩阵
%para几倍标准差
std_dev=eig(Sigma);
diag_mat=[std_dev(1),0;0,std_dev(2)];
l1=para*sqrt(std_dev(1));%l2=para*sqrt(std_dev(2));
std_inv_cov=inv(diag_mat);
L=l1^2*std_inv_cov(1,1);%L=l2^2*std_inv_cov(2,2);
inv_cov=inv(Sigma);
string=['@(x,y)(',num2str(inv_cov(1,1)),'*((x)-',num2str(Mu(1)),').^2+2*(',...
                 num2str(inv_cov(2,1)),'*((x)-',num2str(Mu(1)),').*((y)-',num2str(Mu(2)),'))+',...
                 num2str(inv_cov(2,2)),'*((y)-',num2str(Mu(2)),').^2)-',num2str(L)];
ellipseHdl=str2func(string);             
end