function Frames = non_overlaping_frames(x, fs, frame_duration)
    frame_length = round(fs * frame_duration);
    total_frames = floor(length(x) / frame_length);
    disp(total_frames)

    x = x(1:total_frames * frame_length);

    Frames = reshape(x, [], total_frames);
end
