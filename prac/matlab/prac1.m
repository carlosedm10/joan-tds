% 1.1 -> Read the audio files and plot the continuous signal
sound_files = dir('audio/*.wav');

for file = 1:length(sound_files)
    file_path = strcat('audio/', sound_files(file).name);
    [y, fs] = audioread(file_path);
    % plot_continuous(y, fs) % coninuous signal
    % plot_continuous(y, 1) % discrete signal
end

% 1.2 -> Calculate the power and energy of the signals and plot the yframe
[y1, fs1] = audioread('audio/sound1.wav');
[y2, fs2] = audioread('audio/sound2.wav');
[y3, fs3] = audioread('audio/sound3.wav');

L_frame1 = round(0.1*fs1);
L_frame2 = round(0.1*fs2);
L_frame3 = round(0.1*fs3);

L_duration1 = 512/fs1;
L_duration2 = 512/fs2;
L_duration3 = 512/fs3;

yframe1 = y1(15000:15000 + L_frame1);
yframe2 = y2(14000:14000 + L_frame2);
yframe3 = y3(1000:1000 + L_frame3);

% plot_continuous(yframe1, fs1)
% plot_continuous(yframe2, fs2)
% plot_continuous(yframe3, fs3)

% Power
P1 = mean(y1 .^ 2);
P2 = mean(y2 .^ 2);
P3 = mean(y3 .^ 2);

% Energy
E1 = sum(y1 .^ 2);
E2 = sum(y2 .^ 2);
E3 = sum(y3 .^ 2);

E1_frames = sum(non_overlaping_frames(y1, fs1, 0.1) .^ 2);
E2_frames = sum(non_overlaping_frames(y2, fs2, 0.1) .^ 2);
E3_frames = sum(non_overlaping_frames(y3, fs3, 0.1) .^ 2);

% plot_continuous(E1_frames, fs1)
% hold on
% plot_continuous(E2_frames, fs2)
% plot_continuous(E3_frames, fs3)
