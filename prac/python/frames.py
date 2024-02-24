def non_overlapping_frames(signal, fs, frame_duration):
    frame_len = round(frame_duration * fs)
    total_frames = len(signal) // frame_len
    signal = signal[:total_frames * frame_len]
    signal = signal.reshape(total_frames, frame_len).T

    return signal

def overlapping_frames(signal, fs, frame_duration, overlap):
    frame_len = round(frame_duration * fs)
    overlap_len = round(overlap * frame_len)
    total_frames = len(signal) // (frame_len - overlap_len)
    signal = signal[:total_frames * (frame_len - overlap_len)]
    signal = signal.reshape(total_frames, frame_len - overlap_len).T

    return signal
