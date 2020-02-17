global chattimer
global myChatFile
delete(myChatFile)
if ~isempty(chattimer)
	stop(chattimer);
	delete(chattimer);
	clear global chattimer username myChatFile allChats readProgress chatMat
end


cprintf([0,1,0], 'chat closed.\n' );