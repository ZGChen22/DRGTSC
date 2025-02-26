% return the running time
%
% out = recordRunningTimeEx(timerNum, command)
%
% timerNum - the timer number, from 1 to 1000
% command  - 'start' or 'stop'
%
% return the timerNum if command = 'start', timerNum can be []
% return the running time (double number in seconds) if command = 'stop'
% example: timerNum1 = recordRunningTimeEx([], 'start')
%          ...... (code)
%          timeInSeconds = recordRunningTimeEx(timerNum1, 'stop')
%
% NOTE : once you start a timer (tic the starting time), you can only stop
%        it once 一次tic 一次stop(toc)
%
function out = recordRunningTimeEx(timerNum, command)
% Hypergraph Analysis Toolbox (HAT)
% Copyright 2011, Li Pu (li.pu@epfl.ch), Artificial Intelligence Laboratory, EPFL

% Modifications:
% 20-jun-2011, created [Li PU]
% 24-aug-2011, modified for stop only once

persistent timer;

if isempty(timer)
    timer = zeros(1,1000,'uint64');
end


if (strcmp(command,'start'))
    timerNum = find(timer==0,1);
    if (isempty(timerNum))
        error('HAT:timerNumError','HAT:cannot find an available timer number...');
    end
    timerNum = timerNum(1);
    out = timerNum;
    timer(timerNum) = tic;
elseif (strcmp(command,'stop'))
    if (timerNum<1 || timerNum>1000)
        error('HAT:timerNumOutRange','HAT:timerNum out of range (1-1000)...');
    end
    if (timer(timerNum) == 0)
        error('HAT:timerNotStart','HAT:start the timer before stop it...');
    end
    out = toc(timer(timerNum));
    % reset the timer
    timer(timerNum) = 0;
else
    error('HAT:commandError','HAT:wrong command...');
end

end