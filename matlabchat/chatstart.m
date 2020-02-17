function chatstart(varargin)
	
	global chattimer
	if ~isempty(chattimer)
		error( 'Please stop running chattimer with ''chatclose'' before running chatstart!' );
	end
	global username
	global chatpath
    global myChatFile
    global allChats
    global readProgress
    global chatMat
    username		= sprintf('%s', sprintf('%s',varargin{:}));
    folder			= fileparts( which(mfilename) );
	chatpath		= [ folder, filesep, date];
    myChatFile		= [ chatpath, filesep, username, '.mat' ];
    if ~isdir(chatpath)
        mkdir(chatpath);
    end
	
	fprintf(' --- %s, Welcome to MATLAB Chat v0.2 ---\n', username );
    chatMat{1,2} = now;
    timeStr = datestr(chatMat{1,2},'HH:MM AM');
    if any(strfind(timeStr,' ')==1)
       timeStr(1) = []; 
    end
    chatMat{1,1} = sprintf(['Joined chat at ',timeStr, '\r']);
	chatMat{1,3} = username;
    save(myChatFile,'chatMat')
	allChats = {};
    readProgress = struct;
    
    chattimer = timer( 'TimerFcn', @(~,~) reload_chat(), 'Period', 10, 'ExecutionMode', 'FixedSpacing' );
    
	start(chattimer);
    

	function reload_chat()
% 		try
%             load(chatpath,'chatMat');
%         catch
%             chatMat = struct('user',username,'msg','Started chat\r');
%             chatMeta = struct(username,struct('lastRead',lastMessage));
%             save(chatpath,'chatMat','chatMeta');
%         end
        getChats
        if ~isfield(readProgress,'total')
            readProgress.total = 0;
        end
        if size(allChats,1)>readProgress.total
            for idx = readProgress.total+1:size(allChats,1)
                cprintf([102/255,0/255,204/255], [allChats{idx,3},': ']);
                cprintf([204/255,0/255,102/255], allChats{idx,1});
                readProgress.total = size(allChats,1);
            end
        end
	end
	
end
function getChats
    global chatpath
    global readProgress
    global allChats

    allChatFiles = what(chatpath);
    newChats = {};
    for idx = 1:numel(allChatFiles.mat)
        temp = load([chatpath,filesep,allChatFiles.mat{idx}],'chatMat');
        if ~isfield(readProgress,temp.chatMat{1,3})
            readProgress.(temp.chatMat{1,3}) = 0;
        end
        addChats = temp.chatMat(readProgress.(temp.chatMat{1,3})+1:end,:);
        newChats = [newChats;addChats];
        
        readProgress.(temp.chatMat{1,3}) = readProgress.(temp.chatMat{1,3}) + size(addChats,1);
    end
    [~,sortInd] = sort([newChats{:,2}]);    
    newChats = newChats(sortInd,:);
    allChats = [allChats;newChats];
    
end