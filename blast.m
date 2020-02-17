function[] = blast(varargin)
if nargin == 0
	option = 'vanilla';
else
	option = varargin{1};
end
	
switch option
	case 'vars'
		evalin('caller', 'clear variables')
		clc;
    case 'figs'
		close all;
		clc;
    case 'vanilla'
		close all force;
        evalin('caller', 'clear variables')
		clc;
    case 'twice'
        close all force;
        evalin('caller', 'clear variables')
        close all force;
        evalin('caller', 'clear variables')
		clc;
	case 'more'
		close all force;
        evalin('caller', 'clear all')
		clc;
	case 'all'
		close all force;
        evalin('caller', 'clear all')
		clc;
		allopen = matlab.desktop.editor.getAll;
		allopen.close;
	case 'extreme'
		close all force;
        evalin('caller', 'clear all')
		clc;
		allopen = matlab.desktop.editor.getAll;
		allopen.closeNoPrompt;
	case 'abort'
		close all force;
        evalin('caller', 'clear all')
		clc;
		allopen = matlab.desktop.editor.getAll;
		allopen.closeNoPrompt;
		if ismac
			system('say -v Zarvox oh noes!')
		end
		quit force
end

