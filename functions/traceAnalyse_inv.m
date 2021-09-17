function [traceClass,num]=traceAnalyse_inv(path)
DataSet=getBiggestPile(path);
%smpNum=0;
%smpList=0;
%for i=1:length(DataSet)
    %tempMatData=load(DataSet{i});
    %for j=1:length(tempMatData.Size)
        %smpList(smpNum+j)=trace(tempMatData.Sigma(:,:,j));
    %end
    %smpNum=smpNum+length(tempMatData.Size);
%end
%smpMat=abs(smpList'-smpList);
%smpMat(eye(smpNum)==1)=inf;
smpNum=0;
for i=1:length(DataSet)
    tempMatData=load(DataSet{i});
    for j=1:length(tempMatData.Size)
        smpList(smpNum+j,1)={[i,j]};
        smpList(smpNum+j,2)={trace(tempMatData.Sigma(:,:,j))};
        smpList(smpNum+j,3)={tempMatData.Sigma(:,:,j)};
        smpList(smpNum+j,4)={det(tempMatData.Sigma(:,:,j))};
        smpList(smpNum+j,5)={tempMatData.Mu(j,1)};
        smpList(smpNum+j,6)={tempMatData.Mu(j,2)};
        smpList(smpNum+j,7)={tempMatData.Size(j)};
        smpList(smpNum+j,8)=DataSet(i);
    end
    smpNum=smpNum+length(tempMatData.Size);
end

cMat(smpNum,8)=0;
for i=1:smpNum
    cMat(i,:)=setC(smpList(i,:));  
end
smpMat(smpNum,smpNum)=0;
for i=1:smpNum
    smpMat(:,i)=sqrt(sum(((cMat-cMat(i,:)).*(cMat-cMat(i,:))),2));
    
end
smpMat(eye(smpNum)==1)=inf;

classSet=(1:smpNum)';
classSet(smpNum,smpNum)=0;
for i=1:smpNum
    if classSet(i,2)==0
        minPos=find(smpMat(i,:)==min(smpMat(i,:)));
        minPos=minPos(1);
        [oriRow,~]=find(classSet==i);
        [newRow,~]=find(classSet==minPos);
        zeroPos=find(classSet(newRow,:)==0);
        zeroPos=zeroPos(1);
        classSet(newRow,zeroPos)=i;
        classSet(oriRow,1)=0;
    end
end
classSet(all(classSet==0,2),:)=[];
classSet(:,all(classSet==0,1))=[];

for i=1:size(classSet,1)
    jMax=find(classSet(i,:)~=0,1,'last');
    traceClass.(['class',num2str(i)]).len=jMax;
    for j=1:jMax
        jj=classSet(i,j);
        traceClass.(['class',num2str(i)]).data(j,1)=smpList(jj,1);
        traceClass.(['class',num2str(i)]).data(j,2)=smpList(jj,2);
        traceClass.(['class',num2str(i)]).data(j,3)=smpList(jj,3);
        traceClass.(['class',num2str(i)]).data(j,4)=smpList(jj,4);
        traceClass.(['class',num2str(i)]).data(j,5)=smpList(jj,5);
        traceClass.(['class',num2str(i)]).data(j,6)=smpList(jj,6);
        traceClass.(['class',num2str(i)]).data(j,7)=smpList(jj,7);
        traceClass.(['class',num2str(i)]).data(j,8)=smpList(jj,8);
    end
end

%--------------------------------------------------------------------------
if 0
for i=1:size(classSet,1)
    if traceClass.(['class',num2str(i)]).len~=0
        disp(['第',num2str(i),'类'])
        disp(traceClass.(['class',num2str(i)]).data(:,:))
    end
end
end
%--------------------------------------------------------------------------
for i=1:size(classSet,1)
    if traceClass.(['class',num2str(i)]).len~=0
        CMat=[];
        for j=1:traceClass.(['class',num2str(i)]).len
            CMat(j,:)=setC(traceClass.(['class',num2str(i)]).data(j,:));
        end
        CIP=sqrt(sum((CMat.*CMat),2)');
        midCIP=median(CIP);
        meanCIP=mean(CIP);
        tempdiff=abs(midCIP-CIP);
        midSet=tempdiff==min(tempdiff);
        midVal=CIP(midSet);
        diffVal=abs(midVal-meanCIP);
        [~,stdValPos]=sort(diffVal);
        stdValPos=stdValPos(1);
        stdCIPPos=find(midSet==1);
        stdCIPPos=stdCIPPos(stdValPos);
        stdCList=CMat(stdCIPPos,:);

        CIPij=sqrt(sum(((CMat-stdCList).*(CMat-stdCList)),2)'./sum(stdCList.*stdCList,2));
        for j=traceClass.(['class',num2str(i)]).len:-1:1
            if CIPij(j)>0.2
                traceClass.(['class',num2str(i)]).data(j,:)=[];
            end
        end
        traceClass.(['class',num2str(i)]).len=size(traceClass.(['class',num2str(i)]).data,1);
    end
end
%--------------------------------------------------------------------------
if 1
for i=1:size(classSet,1)
    if traceClass.(['class',num2str(i)]).len~=0
        disp(['第',num2str(i),'类'])
        disp(traceClass.(['class',num2str(i)]).data(:,end))
    end
end
end
%--------------------------------------------------------------------------
num=size(classSet,1);

%==========================================================================
    function C=setC(dataInf)
        sigama=dataInf{3};
        [v,e]=eig(inv(sigama));
        [d,ind]=sort(diag(e));
        v=v(:,ind);
        mu(1)=dataInf{5};mu(2)=dataInf{6};
        %mu=mu./norm(mu);
        %d=d./norm(d);
        if v(1)<0
            v(1)=-v(1);v(2)=-v(2);
        end
        if v(3)<0
            v(3)=-v(3);v(4)=-v(4);
        end
        C=[mu,d(1),d(2),v(1),v(2),v(3),v(4)];
    end
%==========================================================================



k=1;


for i=1:size(classSet,1)
        tempMat=zeros(2,2);
        tempMu=zeros(1,2);
        tempPi=0;
        for j=1:traceClass.(['class',num2str(i)]).len
            tempMat=tempMat+traceClass.(['class',num2str(i)]).data{j,3}.*traceClass.(['class',num2str(i)]).data{j,7};
            tempMu=tempMu+[traceClass.(['class',num2str(i)]).data{j,5:6}].*traceClass.(['class',num2str(i)]).data{j,7};
            tempPi=tempPi+traceClass.(['class',num2str(i)]).data{j,7};
           
        end
        Pi(k)=tempPi;
        Sigma(:,:,k)=tempMat./tempPi;
        Mu(k,:)=tempMu./tempPi;
        k=k+1;       
end
Pi=Pi./sum(Pi);
%若想全部保留
save 'traceAnalyse.mat' Mu Sigma Pi

dp=find(Pi<0.1);

Pi(dp)=[];
Sigma(:,:,dp)=[];
Mu(dp,:)=[];
%若想保留权重大于10%的
save 'traceAnalyse10.mat' Mu Sigma Pi

end