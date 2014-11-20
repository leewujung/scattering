%
% Copyright (c) 2014, Ross Adelman, Nail A. Gumerov, and Ramani Duraiswami
% All rights reserved.
%
% Redistribution and use in source and binary forms, with or without
% modification, are permitted provided that the following conditions are met:
%
% 1. Redistributions of source code must retain the above copyright notice,
% this list of conditions and the following disclaimer.
%
% 2. Redistributions in binary form must reproduce the above copyright notice,
% this list of conditions and the following disclaimer in the documentation
% and/or other materials provided with the distribution.
%
% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
% POSSIBILITY OF SUCH DAMAGE.
%

%
% Run tasks generated by generate_tasks.m.  This function will run the scripts
% in tasks/ready.  Specifically, it will run task*****.m, where ***** is
% start_at, start_at + skip_every, start_at + 2 * skip_every, and so on until
% there are no more such tasks left.
%
% The argument skip_every is useful if you'd like to split up the work across
% multiple cores or even machines.  For example, suppose you had a machine with
% eight cores.  You can do:
%
% run_tasks(1, 8, true);
% run_tasks(2, 8, true);
% run_tasks(3, 8, true);
% run_tasks(4, 8, true);
% run_tasks(5, 8, true);
% run_tasks(6, 8, true);
% run_tasks(7, 8, true);
% run_tasks(8, 8, true);
%
% where each of these lines would be executed in a separate MATLAB instance.
%
% Actually launching and running such an example could be tedious (especially
% if you want to run more than eight instances), so the perl script,
% run_tasks.pl, can be used instead.
%
% The last argument, exit_after, tells this function whether to exit MATLAB
% once done.
%
function run_tasks(start_at, skip_every, exit_after)
	task_number = start_at;
	% As long as keep_running_tasks.txt still exists, keep running tasks.  This
	% allows you to stop all new tasks from starting without manually killing
	% every MATLAB process.
	while (exist('keep_running_tasks.txt', 'file') == 2)
		if (exist(sprintf('tasks/ready/task%05d.m', task_number), 'file') == 0)
			break;
		end
		movefile(sprintf('tasks/ready/task%05d.m', task_number), sprintf('tasks/pending/task%05d.m', task_number));
		diary(sprintf('tasks/logs/task%05d_log.txt', task_number));
		eval(sprintf('task%05d();', task_number));
		diary('off');
		movefile(sprintf('tasks/pending/task%05d.m', task_number), sprintf('tasks/done/task%05d.m', task_number));
		task_number = task_number + skip_every;
	end
	% If exit_after is set to true, have MATLAB exit after running all of the
	% tasks.  This allows you to make sure that nothing is running after all of
	% the tasks are done.
	if (exit_after)
		exit();
	end
end
