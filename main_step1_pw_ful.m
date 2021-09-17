clc;clear
addpath '.\functions'
folder_path=uigetdir();
DS=dir(fullfile(folder_path,'*.csv'));
for i=1:length(DS)
    Data=xlsread([folder_path,'\',DS(i).name]);
    Data=Data(:,7:8);
    edulcorData=FourierTrans_edulcoration_asinh(Data);
    edulcorData(edulcorData(:,1)<2)=[];
    edulcorData(edulcorData(:,2)<2)=[];
    edulcorData(edulcorData(:,1)>13)=[];
    edulcorData(edulcorData(:,1)>13)=[];
    [N,~]=size(edulcorData);
    if N<10
        continue
    end
    disp('gaining the step function')
    [pieceNum,piecewiseFcn,dataMat,sep,XLim,YLim,error1]=getPwFcn(edulcorData);
    [XSet,YSet]=meshgrid(XLim(1):1e-3:XLim(2)-1e-6,YLim(1):1e-3:YLim(2)-1e-6);
    ValueSetP=piecewiseFcn(XSet,YSet,XLim(1),YLim(1),sep,dataMat);
    ValueSetP=ValueSetP(:);
   
    
    error2Set=inf;
    minError2Num=2;
    disp('gaining GMM')
    
    for K=2:floor(log(N)-1)
       [Mu,Sigma,Pi,Size,R]=GMM(edulcorData,K);
    if any(isnan(R))
            break
    end
    guassHdl=k_meanS_guassHdl2_factory(Mu,Sigma,Pi);
    ValueSetG=guassHdl(XSet,YSet);
    ValueSetG=ValueSetG(:);
    tempPntSet=abs(ValueSetP-ValueSetG);
    maxPos=find(tempPntSet==max(tempPntSet));maxPos=maxPos(1);
    %error2Set(K)=max(tempPntSet)/min(ValueSetP(maxPos),ValueSetG(maxPos));
     error2Set(K)=max(tempPntSet);
        if K>2
            if(error2Set(K)==min(error2Set))&&((abs(error2Set(K)-error2Set(minError2Num))/error2Set(minError2Num))>0.005)
                delete(['.\result\temp\',DS(i).name(1:end-4),'_',num2str(minError2Num),'.mat'])
                minError2Num=K;
                save(['.\result\temp\',DS(i).name(1:end-4),'_',num2str(K),'.mat'],'Mu','Sigma','Pi','Size','N')
            end
        else
            save(['.\result\temp\',DS(i).name(1:end-4),'_',num2str(K),'.mat'],'Mu','Sigma','Pi','Size','N')
        end
    end
    disp('error1='),disp(error1)
    disp('error2='),disp(min(error2Set))
    
    
    
end