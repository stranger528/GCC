clc;clear
addpath '.\functions'
[filename, pathname] = uigetfile({'*.csv';'*.xlsx'});
Data=xlsread(fullfile([ pathname,filename]));
%Data=Data(:,7:8);
edulcorData=FourierTrans_edulcoration_asinh(Data);
[N,~]=size(edulcorData);

disp('gaining CDF');
%[pieceNum,piecewiseFcn,dataMat,sep,XLim,YLim,error1]=getPwFcn(edulcorData);
XLim=[6 13];
YLim=[6 13];
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
        ffv=ffv2;
        break
    end
    t=t+20;                           
    disp(t);
end
end
save(['.\result\liquid\',filename(1:end-4),'_continuously differentiable function.mat'],'f');

 ValueSetF=ffv;

%ValueSetP=piecewiseFcn(XSet,YSet,XLim(1),YLim(1),sep,dataMat);
%ValueSetP=ValueSetP(:);
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
    error2Set(K)=sum(sum(tempPntSet)).*(sepxy3^2);
    if K>2
        if(error2Set(K)==min(error2Set))&&((abs(error2Set(K)-error2Set(minError2Num))/error2Set(minError2Num))>0.005)
            delete(['.\result\temp\',filename(1:end-4),'_',num2str(minError2Num),'.mat'])
            minError2Num=K;
            save(['.\result\temp\',filename(1:end-4),'_',num2str(K),'.mat'],'Mu','Sigma','Pi','Size') 
        end
    else
        save(['.\result\temp\',filename(1:end-4),'_',num2str(K),'.mat'],'Mu','Sigma','Pi','Size') 
    end
end
%disp('error1='),disp(error1)
disp('error2='),disp(min(error2Set))