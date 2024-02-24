import numpy as np

def non_overlapping_frames(signal, fs, frame_duration):
    frame_len = round(frame_duration * fs)
    total_frames = len(signal) // frame_len

    frames = signal[:total_frames * frame_len]
    frames = frames.reshape(frame_len, total_frames, order='F')

    return frames

def overlapping_frames(signal, fs, frame_duration, overlap):
    frame_len = round(frame_duration * fs)
    hop_len = round(frame_len * (1 - overlap))
    total_frames = 1 + (len(signal) - frame_len) // hop_len

    frames = np.zeros((frame_len, total_frames))
    for i in range(total_frames):
        start = i * hop_len
        end = start + frame_len
        frames[:, i] = signal[start:end]

    return frames
    



