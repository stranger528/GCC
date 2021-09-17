function DataSet=getBiggestPile(path)
%path='.\空白组高斯分堆结果';
DS=dir(fullfile(path,'*.mat'));
DataSet(length(DS))={''};

for i=1:length(DS)
    tempName=DS(i).name;
    sepPos=regexp(tempName,'_');
    sepPos=sepPos(end);
    DataSet(i)={tempName(1:sepPos-1)}; 
end
DataSet=unique(DataSet);
biggestPile=zeros(length(DataSet),1);

for i=1:length(DS)
    tempName=DS(i).name;
    sepPos=regexp(tempName,'_');
    sepPos=sepPos(end);
    tempNum=str2num(tempName(sepPos+1:regexp(tempName,'.mat')-1)); 
    for j=1:length(DataSet)
        if strcmp(DataSet{j},tempName(1:sepPos-1))&&biggestPile(j)<tempNum
            biggestPile(j)=tempNum;
        end
    end
end
[biggestPile,tempSort]=sort(biggestPile);
DataSet=DataSet(tempSort);

for i=1:length(DataSet)
    DataSet{i}=[path,'\',DataSet{i},'_',num2str(biggestPile(i)),'.mat'];
end
end