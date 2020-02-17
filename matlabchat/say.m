function say( varargin )
	global username
	global myChatFile
    global chatMat
    
    chatMat{end+1,1} = sprintf('%s \r', sprintf('%s ',varargin{:}));
	chatMat{end,2} = now;
    chatMat{end,3} = username;
    save(myChatFile,'chatMat')
end