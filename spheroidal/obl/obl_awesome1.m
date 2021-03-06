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

function obl_awesome1(path, c, M, N, description, obl_lambda_caxis, obl_N_caxis, obl_k1_caxis, obl_k2_caxis, obl_Q_caxis)
	obl_lambda = [];
	obl_log_abs_lambda = [];
	obl_N = [];
	obl_log_abs_N = [];
	obl_k1 = [];
	obl_log_abs_k1 = [];
	obl_k2 = [];
	obl_log_abs_k2 = [];
	obl_Q = [];
	obl_log_abs_Q = [];
	for m = 0 : M - 1
		m
		
		for n = m : m + N - 1
			everything = obl_open_everything(path, c, m, n);
			obl_lambda(m + 1, n - m + 1) = everything.coefficients.lambda;
			obl_log_abs_lambda(m + 1, n - m + 1) = everything.coefficients.log_abs_lambda;
			obl_N(m + 1, n - m + 1) = everything.coefficients.N;
			obl_log_abs_N(m + 1, n - m + 1) = everything.coefficients.log_abs_N;
			obl_k1(m + 1, n - m + 1) = everything.coefficients.k1;
			obl_log_abs_k1(m + 1, n - m + 1) = everything.coefficients.log_abs_k1;
			obl_k2(m + 1, n - m + 1) = everything.coefficients.k2;
			obl_log_abs_k2(m + 1, n - m + 1) = everything.coefficients.log_abs_k2;
			obl_Q(m + 1, n - m + 1) = everything.coefficients.Q;
			obl_log_abs_Q(m + 1, n - m + 1) = everything.coefficients.log_abs_Q;
		end
	end
	
	figure();
	line([0, M - 1], [0, N - 1]);
	hold('on');
	imagesc([0, M - 1], [0, N - 1], obl_lambda.');
	xlim([0, M - 1]);
	set(gca, 'xtick', round(linspace(0, M - 1, 4)));
	ylim([0, N - 1]);
	set(gca, 'ytick', round(linspace(0, N - 1, 4)));
	draw_border();
	set(gca, 'fontsize', 30);
	xlabel('m');
	ylabel('n - m');
	title(sprintf('\\lambda_{mn}(-ic)%s', description));
	set(gca, 'fontsize', 20);
	colormap(cubehelix(250));
	cb = colorbar();
	if (~isempty(obl_lambda_caxis))
		caxis([min(obl_lambda_caxis), max(obl_lambda_caxis)]);
		set(cb, 'ylim', [min(obl_lambda_caxis), max(obl_lambda_caxis)]);
		set(cb, 'ytick', obl_lambda_caxis);
	end
	set(cb, 'ticklength', [1.0e-9, 1.0e-9]);
	set(cb, 'layer', 'top');
	set(cb, 'fontsize', 20);
	set(gcf, 'position', [100, 100, 800, 600]);
	set(gcf, 'color', [1.0, 1.0, 1.0]);
	
	figure();
	line([0, M - 1], [0, N - 1]);
	hold('on');
	imagesc([0, M - 1], [0, N - 1], obl_log_abs_N.' / log(10.0));
	xlim([0, M - 1]);
	set(gca, 'xtick', round(linspace(0, M - 1, 4)));
	ylim([0, N - 1]);
	set(gca, 'ytick', round(linspace(0, N - 1, 4)));
	draw_border();
	set(gca, 'fontsize', 30);
	xlabel('m');
	ylabel('n - m');
	title(sprintf('log_{10}(|N_{mn}(-ic)|)%s', description));
	set(gca, 'fontsize', 20);
	colormap(cubehelix(250));
	cb = colorbar();
	if (~isempty(obl_N_caxis))
		caxis([min(obl_N_caxis), max(obl_N_caxis)]);
		set(cb, 'ylim', [min(obl_N_caxis), max(obl_N_caxis)]);
		set(cb, 'ytick', obl_N_caxis);
	end
	set(cb, 'ticklength', [1.0e-9, 1.0e-9]);
	set(cb, 'layer', 'top');
	set(cb, 'fontsize', 20);
	set(gcf, 'position', [100, 100, 800, 600]);
	set(gcf, 'color', [1.0, 1.0, 1.0]);
	
	figure();
	line([0, M - 1], [0, N - 1]);
	hold('on');
	imagesc([0, M - 1], [0, N - 1], obl_log_abs_k1.' / log(10.0));
	xlim([0, M - 1]);
	set(gca, 'xtick', round(linspace(0, M - 1, 4)));
	ylim([0, N - 1]);
	set(gca, 'ytick', round(linspace(0, N - 1, 4)));
	draw_border();
	set(gca, 'fontsize', 30);
	xlabel('m');
	ylabel('n - m');
	title(sprintf('log_{10}(|k_{mn}^{(1)}(-ic)|)%s', description));
	set(gca, 'fontsize', 20);
	colormap(cubehelix(250));
	cb = colorbar();
	if (~isempty(obl_k1_caxis))
		caxis([min(obl_k1_caxis), max(obl_k1_caxis)]);
		set(cb, 'ylim', [min(obl_k1_caxis), max(obl_k1_caxis)]);
		set(cb, 'ytick', obl_k1_caxis);
	end
	set(cb, 'ticklength', [1.0e-9, 1.0e-9]);
	set(cb, 'layer', 'top');
	set(cb, 'fontsize', 20);
	set(gcf, 'position', [100, 100, 800, 600]);
	set(gcf, 'color', [1.0, 1.0, 1.0]);
	
	figure();
	line([0, M - 1], [0, N - 1]);
	hold('on');
	imagesc([0, M - 1], [0, N - 1], obl_log_abs_k2.' / log(10.0));
	xlim([0, M - 1]);
	set(gca, 'xtick', round(linspace(0, M - 1, 4)));
	ylim([0, N - 1]);
	set(gca, 'ytick', round(linspace(0, N - 1, 4)));
	draw_border();
	set(gca, 'fontsize', 30);
	xlabel('m');
	ylabel('n - m');
	title(sprintf('log_{10}(|k_{mn}^{(2)}(-ic)|)%s', description));
	set(gca, 'fontsize', 20);
	colormap(cubehelix(250));
	cb = colorbar();
	if (~isempty(obl_k2_caxis))
		caxis([min(obl_k2_caxis), max(obl_k2_caxis)]);
		set(cb, 'ylim', [min(obl_k2_caxis), max(obl_k2_caxis)]);
		set(cb, 'ytick', obl_k2_caxis);
	end
	set(cb, 'ticklength', [1.0e-9, 1.0e-9]);
	set(cb, 'layer', 'top');
	set(cb, 'fontsize', 20);
	set(gcf, 'position', [100, 100, 800, 600]);
	set(gcf, 'color', [1.0, 1.0, 1.0]);
	
	figure();
	line([0, M - 1], [0, N - 1]);
	hold('on');
	imagesc([0, M - 1], [0, N - 1], obl_log_abs_Q.' / log(10.0));
	xlim([0, M - 1]);
	set(gca, 'xtick', round(linspace(0, M - 1, 4)));
	ylim([0, N - 1]);
	set(gca, 'ytick', round(linspace(0, N - 1, 4)));
	draw_border();
	set(gca, 'fontsize', 30);
	xlabel('m');
	ylabel('n - m');
	title(sprintf('log_{10}(|Q_{mn}^\\ast(-ic)|)%s', description));
	set(gca, 'fontsize', 20);
	colormap(cubehelix(250));
	cb = colorbar();
	if (~isempty(obl_Q_caxis))
		caxis([min(obl_Q_caxis), max(obl_Q_caxis)]);
		set(cb, 'ylim', [min(obl_Q_caxis), max(obl_Q_caxis)]);
		set(cb, 'ytick', obl_Q_caxis);
	end
	set(cb, 'ticklength', [1.0e-9, 1.0e-9]);
	set(cb, 'layer', 'top');
	set(cb, 'fontsize', 20);
	set(gcf, 'position', [100, 100, 800, 600]);
	set(gcf, 'color', [1.0, 1.0, 1.0]);
end
