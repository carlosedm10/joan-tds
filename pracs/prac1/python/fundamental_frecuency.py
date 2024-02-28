import numpy as np
from scipy.signal import find_peaks


def calculate_fundamental_frequency(signal, fs):
    # Autocorrelation
    autocorr = np.correlate(signal, signal, mode="full")

    # Consider only positive lags (lags > 0)
    autocorr = autocorr[len(autocorr) // 2 :]

    # Find peaks in the autocorrelation
    peaks, _ = find_peaks(autocorr)

    # Calculate fundamental frequency
    if len(peaks) > 1:
        # Calculate the period between peaks
        periods = np.diff(peaks)

        # Calculate the fundamental frequency in Hz
        fundamental_frequency = fs / np.mean(periods)
        return fundamental_frequency
    else:
        return None
