function plot_fft(y)

x = [-length(y)/2:length(y)/2-1];


subplot(2,1,1);
plot(x,abs(y), 'DisplayName', 'Magnitude');
ylabel("Magnitude");
% title("Magnitude and Phase");

subplot(2,1,2);
plot(x,angle(y), 'DisplayName', 'Phase');
ylabel("Phase Angle (rad)");
xlabel("Frequency (Hz)");

end
