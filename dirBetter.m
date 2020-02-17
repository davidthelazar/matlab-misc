function[newDir] = dirBetter(path,varargin)

[excludeFiles,varargin] = popPV('excludeFiles',varargin,false);
[excludeDirs,varargin] = popPV('excludeDirs',varargin,false);

[withString,varargin] = popPV('withString',varargin,'');
[withoutString,varargin] = popPV('withoutString',varargin,'');

newDir = dir(path);
newDir(strcmpi({newDir.name},'.')|strcmpi({newDir.name},'..')|strcmpi({newDir.name},'.DS_Store')) = [];

if excludeDirs
    newDir([newDir.isdir]) = [];
end
if excludeFiles
    newDir(~[newDir.isdir]) = [];
end

if ~isempty(withString)
   newDir = newDir(cellfun(@any,strfind({newDir.name},withString)));
end

if ~isempty(withoutString)
    newDir(cellfun(@any,strfind({newDir.name},withoutString))) = [];    
end