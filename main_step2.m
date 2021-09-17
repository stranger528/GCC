clc;clear
addpath(genpath('.\functions'))

folder_path=uigetdir();
[traceClass,num]=CG(folder_path);
if ~exist([folder_path,'\result'],'dir')==1
   mkdir([folder_path,'\result']);
end

fid=fopen([folder_path,'\result\','CG result.txt'],'w');
fprintf(fid,'%s\r\n','cluster comparision');
fprintf(fid,'%s\r\n','=======================================================');
fprintf(fid,'%s\r\n','');

k=1;
for i=1:num
    if traceClass.(['class',num2str(i)]).len>1
        fprintf(fid,'%s\r\n',['Class',num2str(k),'£º----------------------']);
        fprintf(fid,'%s\r\n','covariance matrix£º');
        for j=1:traceClass.(['class',num2str(i)]).len
            fprintf(fid,'%12.6f %12.6f \r\n', traceClass.(['class',num2str(i)]).data{j,3});
            fprintf(fid,'%s\r\n','');
        end
        fprintf(fid,'%s\r\n','center points£º');
        for j=1:traceClass.(['class',num2str(i)]).len
            fprintf(fid,'%12.6f %12.6f \r\n', [traceClass.(['class',num2str(i)]).data{j,5},traceClass.(['class',num2str(i)]).data{j,6}]);
        end
        fprintf(fid,'%s\r\n','');
        
        fprintf(fid,'%s\r\n','data amount of each clusters ');
        for j=1:traceClass.(['class',num2str(i)]).len
            fprintf(fid,'%s\r\n', ['   ',num2str(traceClass.(['class',num2str(i)]).data{j,7})]);
        end
        fprintf(fid,'%s\r\n','');
        fprintf(fid,'%s\r\n','path£º');
        for j=1:traceClass.(['class',num2str(i)]).len
            fprintf(fid,'%s\r\n', num2str(traceClass.(['class',num2str(i)]).data{j,8}));
        end
        fprintf(fid,'%s\r\n','');
        fprintf(fid,'%s\r\n','original weight£º');
        for j=1:traceClass.(['class',num2str(i)]).len
            fprintf(fid,'%s\r\n', num2str(traceClass.(['class',num2str(i)]).data{j,9}));
        end
        fprintf(fid,'%s\r\n','');
        fprintf(fid,'%s\r\n','');
        k=k+1; 
    end
end


fclose(fid);