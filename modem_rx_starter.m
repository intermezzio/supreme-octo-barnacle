clc
load mats/short_modem_rx.mat

% The received signal includes a bunch of samples from before the
% transmission started so we need discard the samples from before
% the transmission started. 
Fs = 8192;
f_c = 1000;

start_idx = find_start_of_signal(y_r,x_sync);
% start_idx now contains the location in y_r where x_sync begins
% we need to offset by the length of x_sync to only include the signal
% we are interested in
y_t = y_r(start_idx+length(x_sync):end); % y_t is the signal which starts at the beginning of the transmission

% plot(y_t)
% soundsc(y_t, Fs);
% dtft = @(x, k, Omega) x*exp(-j*k'*Omega);
% k = [1:length(y_t)];
% Omega = [-Fs:Fs]*pi/Fs;
% y_furrier = dtft(y_t', k, Omega);

% y_furrier = fft(y_t);

bandpass = @(w_p, W, t) 1/pi .* cos(w_p .* t) .* sin(W .* t) ./ (pi * t);

main_filter = bandpass(2*pi*f_c/Fs, 2*pi*f_c/Fs/8, [1:length(y_t)])';

y_conv = 200 * y_t .* main_filter .* cos(2*pi*f_c/Fs.*[1:length(y_t)])';


% plot(y_t)
figure
% plot_fft(fft(main_filter))
plot_fft(fft(y_conv))
title("y\_conv")

figure
plot_fft(fft(y_t))
% alt_y_furrier = fftshift(fft(y_t));
title("y\_t original")

% plot(abs(y_furrier))
figure
plot(y_conv)
title("y\_conv time")



% filtered_signal = y_t .* main_filter;
% soundsc(filtered_signal, Fs)

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%  Put your decoder code here
% %%
% %%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% convert to a string assuming that x_d is a vector of 1s and 0s
% representing the decoded bits
% BitsToString(x_d)

