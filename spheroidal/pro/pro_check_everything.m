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

function pro_check_everything(everything, description)
	figure();
	plot(everything.S1.eta, everything.S1.S1_log_abs_difference / log(10.0), 'color', [0.0, 0.0, 0.0], 'linewidth', 2.0);
	hold('on');
	plot(everything.S1.eta, everything.S1.S1p_log_abs_difference / log(10.0), 'color', [1.0, 0.0, 0.0], 'linewidth', 2.0);
	xlim([-1.0, 1.0]);
	set(gca, 'xtick', [-1.0, -0.5, 0.0, 0.5, 1.0]);
	draw_border();
	set(gca, 'fontsize', 20);
	xlabel('\eta');
	ylabel('log_{10}(|S1\_1 - S1\_2|)');
	title(sprintf('Difference Between Methods S1\\_1 and S1\\_2%s', description));
	legendflex_pre2014b({'S_{mn}^{(1)}(c, \eta)', 'S_{mn}^{(1)\prime}(c, \eta)'}, 'ref', gca, 'anchor', [5, 5], 'buffer', [-30, 30]);
	set(gcf, 'position', [100, 100, 800, 600]);
	set(gcf, 'color', [1.0, 1.0, 1.0]);
	
	figure();
	plot(everything.R.xi, everything.R.R1_log_abs_difference / log(10.0), 'color', [0.0, 0.0, 0.0], 'linewidth', 2.0);
	hold('on');
	plot(everything.R.xi, everything.R.R1p_log_abs_difference / log(10.0), 'color', [1.0, 0.0, 0.0], 'linewidth', 2.0);
	xlim([1.0, max(everything.R.xi)]);
	set(gca, 'xtick', [1.0, 0.75 + 0.25 * max(everything.R.xi), (1.0 + max(everything.R.xi)) / 2.0, 0.25 + 0.75 * max(everything.R.xi), max(everything.R.xi)]);
	draw_border();
	set(gca, 'fontsize', 20);
	xlabel('\xi');
	ylabel('log_{10}(|R1\_1 - R1\_2|)');
	title(sprintf('Difference Between Methods R1\\_1 and R1\\_2%s', description));
	legendflex_pre2014b({'R_{mn}^{(1)}(c, \xi)', 'R_{mn}^{(1)\prime}(c, \xi)'}, 'ref', gca, 'anchor', [1, 1], 'buffer', [30, -30]);
	set(gcf, 'position', [100, 100, 800, 600]);
	set(gcf, 'color', [1.0, 1.0, 1.0]);
	
	figure();
	plot(everything.R.xi, everything.R.R2_log_abs_difference / log(10.0), 'color', [0.0, 0.0, 0.0], 'linewidth', 2.0);
	hold('on');
	plot(everything.R.xi, everything.R.R2p_log_abs_difference / log(10.0), 'color', [1.0, 0.0, 0.0], 'linewidth', 2.0);
	xlim([1.0, max(everything.R.xi)]);
	set(gca, 'xtick', [1.0, 0.75 + 0.25 * max(everything.R.xi), (1.0 + max(everything.R.xi)) / 2.0, 0.25 + 0.75 * max(everything.R.xi), max(everything.R.xi)]);
	draw_border();
	set(gca, 'fontsize', 20);
	xlabel('\xi');
	ylabel('log_{10}(|R2\_1 - R2\_2|)');
	title(sprintf('Difference Between Methods R2\\_1 and R2\\_2%s', description));
	legendflex_pre2014b({'R_{mn}^{(2)}(c, \xi)', 'R_{mn}^{(2)\prime}(c, \xi)'}, 'ref', gca, 'anchor', [3, 3], 'buffer', [-30, -30]);
	set(gcf, 'position', [100, 100, 800, 600]);
	set(gcf, 'color', [1.0, 1.0, 1.0]);
	
	log_xi = [everything.R.log_xi, everything.R_small.log_xi];
	log_W = [everything.R.log_W, everything.R_small.log_W];
	W_1_1_log_abs_error = [everything.R.W_1_1_log_abs_error, everything.R_small.W_1_1_log_abs_error];
	W_1_2_log_abs_error = [everything.R.W_1_2_log_abs_error, everything.R_small.W_1_2_log_abs_error];
	W_2_1_log_abs_error = [everything.R.W_2_1_log_abs_error, everything.R_small.W_2_1_log_abs_error];
	W_2_2_log_abs_error = [everything.R.W_2_2_log_abs_error, everything.R_small.W_2_2_log_abs_error];
	[ ...
	log_xi, ix ...
	] = sort(log_xi);
	log_W = log_W(ix);
	W_1_1_log_abs_error = W_1_1_log_abs_error(ix);
	W_1_2_log_abs_error = W_1_2_log_abs_error(ix);
	W_2_1_log_abs_error = W_2_1_log_abs_error(ix);
	W_2_2_log_abs_error = W_2_2_log_abs_error(ix);
	
	figure();
	plot(log_xi / log(10.0), W_1_1_log_abs_error / log(10.0) - log_W / log(10.0), 'color', [0.0, 0.0, 0.0], 'linewidth', 2.0);
	hold('on');
	plot(log_xi / log(10.0), W_1_2_log_abs_error / log(10.0) - log_W / log(10.0), 'color', [1.0, 0.0, 0.0], 'linewidth', 2.0);
	plot(log_xi / log(10.0), W_2_1_log_abs_error / log(10.0) - log_W / log(10.0), 'color', [0.0, 0.7, 0.0], 'linewidth', 2.0);
	plot(log_xi / log(10.0), W_2_2_log_abs_error / log(10.0) - log_W / log(10.0), 'color', [0.0, 0.0, 1.0], 'linewidth', 2.0);
	xlim([min(log_xi / log(10.0)), max(log_xi / log(10.0))]);
	xtick_left = 0.0 : -2.0 : -ceil(-log_xi(2) / log(10.0));
	xtick_right = 2.0 : 2.0 : ceil(log_xi(end) / log(10.0));
	set(gca, 'xtick', [xtick_left(end : -1 : 1), xtick_right]);
	draw_border();
	set(gca, 'fontsize', 20);
	xlabel('log_{10}(\xi - 1)');
	ylabel('log_{10}(|Relative Error|)');
	title(sprintf('Relative Error of Wronskian Using Different Methods%s', description));
	legendflex_pre2014b({'R1\_1, R2\_1', 'R1\_1, R2\_2', 'R1\_2, R2\_1', 'R1\_2, R2\_2'}, 'ref', gca, 'anchor', [1, 1], 'buffer', [30, -30]);
	set(gcf, 'position', [100, 100, 800, 600]);
	set(gcf, 'color', [1.0, 1.0, 1.0]);
	
	figure();
	plot(everything.S1.eta, everything.S1.S1, 'color', [0.0, 0.0, 0.0], 'linewidth', 2.0);
	hold('on');
	xlim([-1.0, 1.0]);
	set(gca, 'xtick', [-1.0, -0.5, 0.0, 0.5, 1.0]);
	nice_ylim = calculate_nice_ylim(everything.S1.S1);
	ylim(nice_ylim + 0.1 * [-1.0, 1.0] * (nice_ylim(2) - nice_ylim(1)));
	draw_border();
	set(gca, 'fontsize', 20);
	xlabel('\eta');
	title(sprintf('Prolate Angle Functions%s', description));
	legendflex_pre2014b({'S_{mn}^{(1)}(c, \eta) / {N_{mn}(c)}^{1/2}'}, 'ref', gca, 'anchor', [3, 3], 'buffer', [-30, -30]);
	set(gcf, 'position', [100, 100, 800, 600]);
	set(gcf, 'color', [1.0, 1.0, 1.0]);
	
	figure();
	plot(everything.S1.eta, everything.S1.S1p, 'color', [0.0, 0.0, 0.0], 'linewidth', 2.0);
	hold('on');
	xlim([-1.0, 1.0]);
	set(gca, 'xtick', [-1.0, -0.5, 0.0, 0.5, 1.0]);
	nice_ylim = calculate_nice_ylim(everything.S1.S1p);
	ylim(nice_ylim + 0.1 * [-1.0, 1.0] * (nice_ylim(2) - nice_ylim(1)));
	draw_border();
	set(gca, 'fontsize', 20);
	xlabel('\eta');
	title(sprintf('Derivative of Prolate Angle Functions%s', description));
	legendflex_pre2014b({'S_{mn}^{(1)\prime}(c, \eta) / {N_{mn}(c)}^{1/2}'}, 'ref', gca, 'anchor', [3, 3], 'buffer', [-30, -30]);
	set(gcf, 'position', [100, 100, 800, 600]);
	set(gcf, 'color', [1.0, 1.0, 1.0]);
	
	figure();
	plot(everything.R.xi, everything.R.R1, 'color', [0.0, 0.0, 0.0], 'linewidth', 2.0);
	hold('on');
	plot(everything.R.xi, everything.R.R2, 'color', [1.0, 0.0, 0.0], 'linewidth', 2.0);
	xlim([1.0, max(everything.R.xi)]);
	set(gca, 'xtick', [1.0, 0.75 + 0.25 * max(everything.R.xi), (1.0 + max(everything.R.xi)) / 2.0, 0.25 + 0.75 * max(everything.R.xi), max(everything.R.xi)]);
	nice_ylim1 = calculate_nice_ylim(everything.R.R1);
	nice_ylim2 = calculate_nice_ylim(everything.R.R2);
	nice_ylim = [min([nice_ylim1(1), nice_ylim2(1)]), max([nice_ylim1(2), nice_ylim2(2)])];
	ylim(nice_ylim + 0.1 * [-1.0, 1.0] * (nice_ylim(2) - nice_ylim(1)));
	draw_border();
	set(gca, 'fontsize', 20);
	xlabel('\xi');
	title(sprintf('Prolate Radial Functions%s', description));
	legendflex_pre2014b({'R_{mn}^{(1)}(c, \xi)', 'R_{mn}^{(2)}(c, \xi)'}, 'ref', gca, 'anchor', [3, 3], 'buffer', [-30, -30]);
	set(gcf, 'position', [100, 100, 800, 600]);
	set(gcf, 'color', [1.0, 1.0, 1.0]);
	
	figure();
	plot(everything.R.xi, everything.R.R1p, 'color', [0.0, 0.0, 0.0], 'linewidth', 2.0);
	hold('on');
	plot(everything.R.xi, everything.R.R2p, 'color', [1.0, 0.0, 0.0], 'linewidth', 2.0);
	xlim([1.0, max(everything.R.xi)]);
	set(gca, 'xtick', [1.0, 0.75 + 0.25 * max(everything.R.xi), (1.0 + max(everything.R.xi)) / 2.0, 0.25 + 0.75 * max(everything.R.xi), max(everything.R.xi)]);
	nice_ylim1 = calculate_nice_ylim(everything.R.R1p);
	nice_ylim2 = calculate_nice_ylim(everything.R.R2p);
	nice_ylim = [min([nice_ylim1(1), nice_ylim2(1)]), max([nice_ylim1(2), nice_ylim2(2)])];
	ylim(nice_ylim + 0.1 * [-1.0, 1.0] * (nice_ylim(2) - nice_ylim(1)));
	draw_border();
	set(gca, 'fontsize', 20);
	xlabel('\xi');
	title(sprintf('Derivative of Prolate Radial Functions%s', description));
	legendflex_pre2014b({'R_{mn}^{(1)\prime}(c, \xi)', 'R_{mn}^{(2)\prime}(c, \xi)'}, 'ref', gca, 'anchor', [3, 3], 'buffer', [-30, -30]);
	set(gcf, 'position', [100, 100, 800, 600]);
	set(gcf, 'color', [1.0, 1.0, 1.0]);
	
	W_log_abs_error = [everything.R.W_log_abs_error, everything.R_small.W_log_abs_error];
	W_log_abs_error = W_log_abs_error(ix);
	
	figure();
	plot(log_xi / log(10.0), W_log_abs_error / log(10.0) - log_W / log(10.0), 'color', [0.0, 0.0, 0.0], 'linewidth', 2.0);
	hold('on');
	xlim([min(log_xi / log(10.0)), max(log_xi / log(10.0))]);
	set(gca, 'xtick', [xtick_left(end : -1 : 1), xtick_right]);
	draw_border();
	set(gca, 'fontsize', 20);
	xlabel('log_{10}(\xi - 1)');
	ylabel('log_{10}(|Relative Error|)');
	title(sprintf('Relative Error of Wronskian Using Best Combination of Methods%s', description));
	set(gcf, 'position', [100, 100, 800, 600]);
	set(gcf, 'color', [1.0, 1.0, 1.0]);
end
