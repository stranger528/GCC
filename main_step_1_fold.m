clc;clear
addpath '.\functions'
folder_path=uigetdir();
DS=dir(fullfile(folder_path,'*.csv'));
for h=1:length(DS)
    Data=xlsread([folder_path,'\',DS(h).name]);
    %Data=Data(:,7:8);
    edulcorData=FourierTrans_edulcoration_asinh(Data);
    [N,~]=size(edulcorData);
    if N<10
        continue
    end
    disp('gaining CDF');
%[pieceNum,piecewiseFcn,dataMat,sep,XLim,YLim,error1]=getPwFcn(edulcorData);
XLim=[2 13];
YLim=[2 13];
sepxy3=(13-XLim(1))/300;
XList3=XLim(1)+sepxy3/2:sepxy3:XLim(2)-sepxy3/2;
YList3=YLim(1)+sepxy3/2:sepxy3:YLim(2)-sepxy3/2;
t=400;


if 1
while 1
    [f1,ffv1]=CDF(edulcorData,t);
    [f2,ffv2]=CDF(edulcorData,t+10);
     temp=abs(ffv1-ffv2);
    if ((max(temp,[],'all'))<1e-2)||(t>500)
        f=f2;
        ffv=ffv1;
        break
    end
    t=t+20;                           
    disp(t);
end
end

save(['.\result\Ghent result\',DS(h).name(1:end-4),'_continuously differentiable function.mat'],'f');

 for i=1:300
        for j=1:300
    ffv(i,j)=f(XList3(i),YList3(j));
        end
    end
 ValueSetF=ffv;


error2Set(1)=inf;
minError2Num=2;
disp('gaining GMM')
for K=2:floor(log(N))
    [Mu,Sigma,Pi,Size,R]=GMM(edulcorData,K);
    if any(isnan(R))
            break
    end
    guassHdl=k_meanS_guassHdl2_factory(Mu,Sigma,Pi);
    for i=1:300
        for j=1:300
    ValueSetG(i,j)=guassHdl(XList3(i),YList3(j));
        end
    end
    
    tempPntSet=abs(ValueSetF-ValueSetG);
    %maxPos=find(tempPntSet==max(tempPntSet));maxPos=maxPos(1);
    %error2Set(K)=max(tempPntSet)./min(ValueSetP(maxPos),ValueSetG(maxPos));
    error2Set(K)=sum(sum(tempPntSet)).*(sepxy3^2)./121;
    if K>2
        if(error2Set(K)==min(error2Set))&&((abs(error2Set(K)-error2Set(minError2Num))/error2Set(minError2Num))>0.005)
            %(error2Set(K)==min(error2Set))&&((abs(error2Set(K)-error2Set(minError2Num))/error2Set(minError2Num))>0.0001)
            delete(['.\result\Ghent result\',DS(h).name(1:end-4),'_',num2str(minError2Num),'.mat'])
            minError2Num=K;
            save(['.\result\Ghent result\',DS(h).name(1:end-4),'_',num2str(K),'.mat'],'Mu','Sigma','Pi','Size') 
        end
    else
        save(['.\result\Ghent result\',DS(h).name(1:end-4),'_',num2str(K),'.mat'],'Mu','Sigma','Pi','Size') 
    end
end

disp('error2='),disp(min(error2Set))
    
    
end