def non_overlapping_frames(signal, fs, frame_duration):
    frame_len = round(frame_duration * fs)
    total_frames = len(signal) // frame_len

    signal = signal[:total_frames * frame_len]
    signal = signal.reshape(frame_len, total_frames, order='F')

    return signal

def overlapping_frames(signal, fs, frame_duration, overlap):
    frame_len = round(frame_duration * fs)
    overlap_len = round(overlap * frame_len)
    frame_offset = frame_len - overlap_len
    total_frames = len(signal) // frame_offset
    
    signal = signal[:total_frames * frame_offset]
    signal = signal.reshape(frame_offset, total_frames, order='F')

    return signal
