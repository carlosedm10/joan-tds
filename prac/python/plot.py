import matplotlib.pyplot as plt
import numpy as np

def plot_continuous(y, fs, title=None):
    t = np.arange(len(y)) / fs

    plt.plot(t, y)
    plt.xlabel('Time (s)')
    plt.ylabel('Amplitude')
    if title:
        plt.title(title)

    plt.show()


# plot both continuous and discrete signal in the same figure
def plot_continuous_discrete(y, fs, title=None):
    Ly = len(y)
    t = np.arange(Ly) / fs
    n = np.arange(Ly)

    fig, ax = plt.subplots(2, layout='constrained')

    ax[0].plot(t, y)
    ax[0].set_xlabel('Time (s)')
    ax[0].set_ylabel('Amplitude')
    ax[0].set_title('Continuous')

    ax[1].plot(n, y)
    ax[1].set_xlabel('n')
    ax[1].set_ylabel('Amplitude')
    ax[1].set_title('Discrete')

    if title:
        fig.suptitle(title)

    plt.show()


