function [Mu,Sigma,Pi,Size,R]=GMM(Data,K)
[N,D]=size(Data);
Psi=zeros(N,K);
Gamma=zeros(N,K);
Pi(1:K)=(1:K).^(-1);
Sigma(:,:,1:K)=repmat(cov(Data),[1,1,K]);
Size=ones(1,K);
Mu=get_Mu(Data,K);
    function Mu=get_Mu(Data,K)
        n=size(Data,2);
        coe=zeros(2,n);
        for i=1:n
            coe(:,i)=[Data(:,1),ones(size(Data,1),1)]\Data(:,i);
        end
        tt=linspace(min(Data(:,1)),max(Data(:,1)),K)';
        Mu=tt*coe(1,:)+ones(K,1)*coe(2,:);
    end
  
LMu=Mu;
LPi=Pi;
LSigma=Sigma;
t=0;
while 1
    for k = 1:K
        Y = Data- repmat(Mu(k,:),N,1);
        Psi(:,k) =((2*pi)^(-D/2))*(det(Sigma(:,:,k))^(-1/2))*exp(sum(-1/2*Y/(Sigma(:,:,k)).*(Y),2));
    end
    for j = 1:N
        for k=1:K
            Gamma(j,k) = Pi(1,k)*Psi(j,k)/sum(Psi(j,:)*Pi');  
        end
    end
    for k = 1:K
        Mu(k,:)= sum(Gamma(:,k).*Data(:,:),1)/sum(Gamma(:,k));
        Sigma_SUM= zeros(D,D);
        for j = 1:N
            Sigma_SUM = Sigma_SUM+ Gamma(j,k)*(Data(j,:)-Mu(k,:))'*(Data(j,:)-Mu(k,:));
        end
        Sigma(:,:,k)= Sigma_SUM/sum(Gamma(:,k));
        Pi(1,k)=sum(Gamma(:,k))/N;
        Size(1,k)=sum(Gamma(:,k));
    end
    R_Mu=sum(sum(abs(LMu- Mu)));
    R_Sigma=sum(sum(abs(LSigma- Sigma)));
    R_Pi=sum(sum(abs(LPi- Pi)));
    R=R_Mu+R_Sigma+R_Pi;
    t=t+1;
    disp('------------')
    disp(t)
    disp(R)
    if all( R<1e-3)||any(isnan(R))||(t>1000)
        break;
    end
    LMu=Mu;
    LSigma=Sigma;
    LPi=Pi;
end
end