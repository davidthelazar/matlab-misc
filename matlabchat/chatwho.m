function chatwho

global chatpath
present = '';
allChatFiles = what(chatpath);
if numel(allChatFiles.mat)>0
    for idx = 1:numel(allChatFiles.mat)
        present = [present,'|',allChatFiles.mat{idx}(1:end-4)];
    end
    present = [present,'|'];
else
    present = 'Nobody.';
end
cprintf([30/255,75/255,204/255], ['People possibly in chat: ',present,'\r']);

end