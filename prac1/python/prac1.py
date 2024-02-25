import matplotlib.pyplot as plt
import numpy as np
import os
import scipy.io.wavfile as wav
import sys
import sounddevice as sd

from plot import plot_continuous, plot_continuous_discrete
from frames import non_overlapping_frames, overlapping_frames
from fundamental_frecuency import calculate_fundamental_frequency
from collections import namedtuple

AUDIO_DIR = "../audio"

# set numpy print options to print only 10 elements of an array
np.set_printoptions(threshold=10)

# get the signal and the sampling frequency of .wav files
fs1, y1 = wav.read(os.path.join(AUDIO_DIR, "sound1.wav"))
fs2, y2 = wav.read(os.path.join(AUDIO_DIR, "sound2.wav"))
fs3, y3 = wav.read(os.path.join(AUDIO_DIR, "sound3.wav"))
fs4, y4 = wav.read(os.path.join(AUDIO_DIR, "sound4.wav"))
fs5, y5 = wav.read(os.path.join(AUDIO_DIR, "sound5.wav"))

# normalize the signals to match matlab behavior
# samples are 16-bit signed integers
y1 = y1 / 2**15
y2 = y2 / 2**15
y3 = y3 / 2**15
y4 = y4 / 2**15
y5 = y5 / 2**15

# Create a named tuple to store the signals
Signal = namedtuple("Signal", ["y", "fs", "file"])
signals = [
    Signal(y1, fs1, "sound1.wav"),
    Signal(y2, fs2, "sound2.wav"),
    Signal(y3, fs3, "sound3.wav"),
    Signal(y4, fs4, "sound4.wav"),
    Signal(y5, fs5, "sound5.wav"),
]

# Plot and play the signals
for signal in signals:
    plot_continuous_discrete(signal.y, signal.fs, title=signal.file)

    # Play the audio
    # sd.play(y, fs)
    # sd.wait()

# values chosen by hand to get the relevant part of the signals
frames_start = [15000, 14000, 1000, 18000, 12300]

for signal, frame_start in zip(signals, frames_start):
    # calculate the length of the frames
    frame_duration = 0.1
    yframe_len = round(frame_duration * signal.fs)

    # extract the frames from the original signals.
    yframe = signal.y[frame_start : frame_start + yframe_len]

    # plot the frames
    plot_continuous(yframe, signal.fs, title=f"{signal.file} frame")

    # calculate the fundamental frequency of the signals
    fundamental_frequency = calculate_fundamental_frequency(yframe, signal.fs)
    print(f"Fundamental frecuecny of signal {signal.file}: {fundamental_frequency} hz")

    # calculate the power and energy of the signals
    print(f"Power of signal {signal.file}: {(signal.y ** 2).mean()} W")
    print(f"Energy of signal {signal.file}: {(signal.y ** 2).sum()} J")

E_frames = []
for signal in signals:
    # get the energy of the signals in overlapping frames of 100ms
    frame_duration = 0.1
    E_frame = (non_overlapping_frames(signal.y, signal.fs, frame_duration) ** 2).sum(
        axis=0
    )
    E_frames.append(E_frame)

    # plot the energy of the signals in continuous time
    fs = 1 / frame_duration
    plot_continuous(E_frame, fs, title=f"{signal.file} energy", ylabel="Energy (J)")
    print(f"Energy of signal {signal.file} (non overlapping frames): {E_frame} J")

for E_frame in E_frames:
    # add the energy of the signal to the final plot with the energy of all the signals
    t = np.arange(len(E_frame)) * signal.fs
    plt.plot(t, E_frame)

# plot the energy of all the signals in discrete time
plt.xlabel("n")
plt.ylabel("Energy (J)")
plt.title("Energy of the signals (non overlapping frames)")
plt.legend([signal.file for signal in signals])
plt.show()

E_frames = []
for signal in signals:
    # get the energy of the signals in overlapping frames of 100ms
    overlap = 0.5
    frame_duration = 0.02
    E_frame = (
        overlapping_frames(signal.y, signal.fs, frame_duration, overlap) ** 2
    ).sum(axis=0)
    E_frames.append(E_frame)

    # plot the energy of the signals in continuous time
    fs = 1 / (frame_duration * overlap)
    plot_continuous(E_frame, fs, title=f"{signal.file} energy", ylabel="Energy (J)")
    print(f"Energy of signal {signal.file} (non overlapping frames): {E_frame} J")

for E_frame in E_frames:
    # add the energy of the signal to the final plot with the energy of all the signals
    t = np.arange(len(E_frame)) * signal.fs
    plt.plot(t, E_frame)

# plot the energy of all the signals in discrete time
plt.xlabel("n")
plt.ylabel("Energy (J)")
plt.title("Energy of the signals (non overlapping frames)")
plt.legend([signal.file for signal in signals])
plt.show()
