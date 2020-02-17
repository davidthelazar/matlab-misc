%__________________________________________________________________________
%
% Syntax:   [bigcell] = subsubfields(structin,strcell_def,bigcell)
%   
% Purpose:  This function will create a cell array of cell arrays of strings
%           where each element of the large array contains all the
%           subfield names that terminate in a value (ie, the last subfield
%           in each list will not be a struct itself). Each element of the
%           large cell array can then be fed into getfield or setfield 
%           (with {:}) to access that element. It's so confusing. Also, the
%           code calls itself recursively, so...good luck!
%
% Inputs:
%           structin = This is the root structure that you want to dig down
%           into. Never tested with multielement structures; probably won't
%           work.
%           strcell = This is used only in the recursion; call it with {}
%           bigcell = This is the current state of the largecell array.
%               Most likely, this will also only be used in the recursion, 
%               so call it also with {}
%               
% Outputs:
%           bigcell = A big cell array with a number of elements equal to
%               the number of non-struct fields in structin with each of
%               these elements a cell array of strings containing the set of
%               field names leading to and including the non-struct field.
%
% To Do:    Ugh. Never look at this code again.
%
% Authors:  David Lazar
%__________________________________________________________________________
function[bigcell] = subsubfields(structin,strcell_def,bigcell)
subfields = fieldnames(structin);

for idx = 1:numel(subfields)
    strcell = strcell_def;
    if isstruct(structin.(subfields{idx}))
        strcell = cat(2,strcell,{subfields{idx}});
        bigcell = subsubfields(structin.(subfields{idx}),strcell,bigcell);
    else
        strcell = cat(2,strcell,subfields(idx));
        bigcell = cat(1,bigcell,{strcell});
    end
end