root='F:\AJ Data\Data\yalefaces_Original\';
dest='F:\AJ Data\Data\yalefaces_preproessed\';



Files=dir(root);
for k=1:length(Files)
    file=fullfile(Files(k).folder,   Files(k).name);
   if(isfile(file)==0) 
        continue;
   end
   [filepath,name,ext] = fileparts(file);
   
   subject = name(end-1:end);
   destfolder = fullfile(dest,   subject);
   destfile = fullfile(destfolder , strcat(  Files(k).name,'.jpg'));
   
   if (7~=exist(destfolder,'dir'))
       mkdir(destfolder)
   end
   copyfile(file,destfile);
end