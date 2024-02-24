import matplotlib.pyplot as plt
import numpy as np
import os
import scipy.io.wavfile as wav
import sys
# import simpleaudio as sa

from plot import plot_continuous, plot_continuous_discrete
from frames import non_overlapping_frames, overlapping_frames
from fundamental_frecuency import calculate_fundamental_frequency


AUDIO_DIR = '../audio'

# Plot all the .wav files in the audio directory
for file in os.listdir(AUDIO_DIR):
    if file.endswith('.wav'):
        file_path = os.path.join(AUDIO_DIR, file)
        fs, y = wav.read(file_path)
        y = y / 2 ** 15 # normalize the signal
        plot_continuous_discrete(y, fs, file)

        # play the sound
        # wave_obj = sa.WaveObject.from_wave_file(file_path)
        # play_obj = wave_obj.play()
        # play_obj.wait_done()

# get the signal and the sampling frequency of the first 3 .wav files
fs1, y1 = wav.read(os.path.join(AUDIO_DIR, 'sound1.wav'))
fs2, y2 = wav.read(os.path.join(AUDIO_DIR, 'sound2.wav'))
fs3, y3 = wav.read(os.path.join(AUDIO_DIR, 'sound3.wav'))
fs4, y4 = wav.read(os.path.join(AUDIO_DIR, 'sound4.wav'))
fs5, y5 = wav.read(os.path.join(AUDIO_DIR, 'sound5.wav')) 

# normalize the signals to match with matlab behavior
# samples are 16-bit signed integers in the range -32768 to 32767
y1 = y1 / 2 ** 15
y2 = y2 / 2 ** 15
y3 = y3 / 2 ** 15
y4 = y4 / 2 ** 15
y5 = y5 / 2 ** 15

# extract and visualize a 100ms frame from each signal
yframe1_len = round(0.1 * fs1)
yframe2_len = round(0.1 * fs2)
yframe3_len = round(0.1 * fs3)
yframe4_len = round(0.1 * fs4)
yframe5_len = round(0.1 * fs5)

yframe1 = y1[15000:15000 + yframe1_len]
yframe2 = y2[14000:14000 + yframe2_len]
yframe3 = y3[1000:1000 + yframe3_len]
yframe4 = y4[18000:18000 + yframe4_len]
yframe5 = y5[12300:12300 + yframe5_len]

plot_continuous(yframe1, fs1, 'sound1.wav frame')
plot_continuous(yframe2, fs2, 'sound2.wav frame')
plot_continuous(yframe3, fs3, 'sound3.wav frame')
plot_continuous(yframe4, fs4, 'sound4.wav frame')
plot_continuous(yframe5, fs5, 'sound5.wav frame')

# only the first and the third signals are periodic
print(f'Fundamental frecuecny of signal sound1.waw: {calculate_fundamental_frequency(yframe1, fs1)} hz')
print(f'Fundamental frecuecny of signal sound3.waw: {calculate_fundamental_frequency(yframe3, fs3)} hz')
print(f'Fundamental frecuecny of signal sound4.waw: {calculate_fundamental_frequency(yframe4, fs4)} hz')

# power of the signals
print(f'Power of sound1.wav: {(y1 ** 2).mean()} W')
print(f'Power of sound2.wav: {(y2 ** 2).mean()} W')
print(f'Power of sound3.wav: {(y3 ** 2).mean()} W')
print(f'Power of sound4.wav: {(y4 ** 2).mean()} W')
print(f'Power of sound5.wav: {(y5 ** 2).mean()} W')

# energy of the signals
print(f'Energy of sound1.wav: {(y1 ** 2).sum()} J')
print(f'Energy of sound2.wav: {(y2 ** 2).sum()} J')
print(f'Energy of sound3.wav: {(y3 ** 2).sum()} J')
print(f'Energy of sound4.wav: {(y4 ** 2).sum()} J')
print(f'Energy of sound5.wav: {(y5 ** 2).sum()} J')

# get the energy of the signals in non overlapping frames of 100ms
E1_frames = (non_overlapping_frames(y1, fs1, 0.1) ** 2).sum(axis=0)
E2_frames = (non_overlapping_frames(y2, fs2, 0.1) ** 2).sum(axis=0)
E3_frames = (non_overlapping_frames(y3, fs3, 0.1) ** 2).sum(axis=0)
E4_frames = (non_overlapping_frames(y4, fs4, 0.1) ** 2).sum(axis=0)
E5_frames = (non_overlapping_frames(y5, fs5, 0.1) ** 2).sum(axis=0)

print('Energy of sound1.wav (non overlapping frames):', E1_frames)
print('Energy of sound2.wav (non overlapping frames):', E2_frames)
print('Energy of sound3.wav (non overlapping frames):', E3_frames)
print('Energy of sound4.wav (non overlapping frames):', E4_frames)
print('Energy of sound5.wav (non overlapping frames):', E5_frames)

# plot the energy of the signals in discrete time
t1 = np.arange(len(E1_frames)) * fs1
t2 = np.arange(len(E2_frames)) * fs2
t3 = np.arange(len(E3_frames)) * fs3
t4 = np.arange(len(E4_frames)) * fs4
t5 = np.arange(len(E5_frames)) * fs5

plt.plot(t1, E1_frames, label='sound1.wav')
plt.plot(t2, E2_frames, label='sound2.wav')
plt.plot(t3, E3_frames, label='sound3.wav')
plt.plot(t4, E4_frames, label='sound4.wav')
plt.plot(t5, E5_frames, label='sound5.wav')
plt.xlabel('n')
plt.ylabel('Energy (J)')
plt.title('Energy of the signals (non-overlapping frames)')
plt.legend()
plt.show()

# plot the energy of the signals in continuous time
# the sampling frequency is 10Hz because the frames are 100ms long
plot_continuous(E3_frames, 10, 'sound1.wav energy', 'Energy (J)')
plot_continuous(E2_frames, 10, 'sound2.wav energy', ylabel='Energy (J)')
plot_continuous(E1_frames, 10, 'sound3.wav energy', ylabel='Energy (J)')
plot_continuous(E4_frames, 10, 'sound4.wav energy', ylabel='Energy (J)')
plot_continuous(E5_frames, 10, 'sound5.wav energy', ylabel='Energy (J)')

# get the energy of the signals in overlapping frames of 100ms with 50% overlap
E1_frames = (overlapping_frames(y1, fs1, 0.1, 0.5) ** 2).sum(axis=0)
E2_frames = (overlapping_frames(y2, fs2, 0.1, 0.5) ** 2).sum(axis=0)
E3_frames = (overlapping_frames(y3, fs3, 0.1, 0.5) ** 2).sum(axis=0)
E4_frames = (overlapping_frames(y4, fs4, 0.1, 0.5) ** 2).sum(axis=0)
E5_frames = (overlapping_frames(y5, fs5, 0.1, 0.5) ** 2).sum(axis=0)

print('Energy of sound1.wav (overlapping frames 50%):', E1_frames)
print('Energy of sound2.wav (overlapping frames 50%):', E2_frames)
print('Energy of sound3.wav (overlapping frames 50%):', E3_frames)
print('Energy of sound4.wav (overlapping frames 50%):', E4_frames)
print('Energy of sound5.wav (overlapping frames 50%):', E5_frames)

# plot the energy of the signals in discrete time
t1 = np.arange(len(E1_frames)) * fs1
t2 = np.arange(len(E2_frames)) * fs2
t3 = np.arange(len(E3_frames)) * fs3
t4 = np.arange(len(E4_frames)) * fs4
t5 = np.arange(len(E5_frames)) * fs5

plt.plot(t1, E1_frames, label='sound1.wav')
plt.plot(t2, E2_frames, label='sound2.wav')
plt.plot(t3, E3_frames, label='sound3.wav')
plt.plot(t4, E4_frames, label='sound4.wav')
plt.plot(t5, E5_frames, label='sound5.wav')
plt.xlabel('n')
plt.ylabel('Energy (J)')
plt.title('Energy of the signals (overlapping frames 50%)')
plt.legend()
plt.show()

# plot the energy of the signals in continuous time
# the sampling frequency is 10Hz because the frames are 100ms long
plot_continuous(E1_frames, 10, 'sound1.wav energy', ylabel='Energy (J)')
plot_continuous(E2_frames, 10, 'sound2.wav energy', ylabel='Energy (J)')
plot_continuous(E3_frames, 10, 'sound3.wav energy', ylabel='Energy (J)')
plot_continuous(E4_frames, 10, 'sound4.wav energy', ylabel='Energy (J)')
plot_continuous(E5_frames, 10, 'sound5.wav energy', ylabel='Energy (J)')
