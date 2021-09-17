function guassHdl=k_meanS_guassHdl2_factory(Mu,Sigma,Pi)
K=length(Pi);
string='@(x,y)';
for k=1:K
    means=Mu(k,:);
    covariance=Sigma(:,:,k);
    det_cov=det(covariance);
    inv_cov=inv(covariance);
    string=[string,'+',num2str(Pi(k)),'*(1/(2*pi*sqrt(',num2str(det_cov),'))*exp(-1/2*(',...
        num2str(inv_cov(1,1)),'*(x-',num2str(means(1)),').^2+2*(',num2str(inv_cov(1,2)),...
        '*(x-',num2str(means(1)),').*(y-',num2str(means(2)),'))+',num2str(inv_cov(2,2)),...
        '*(y-',num2str(means(2)),').^2)))'];
end
guassHdl=str2func(string);
%save k_meanS_guassHdl2_factory.mat guassHdl
end