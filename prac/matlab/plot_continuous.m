function plot_continuous (y1, fs) 
    Ly = length(y1);
    t = (0:Ly-1)/fs;
    plot(t, y1);
    xlabel('Time (s)');
    ylabel('Amplitude');
end
