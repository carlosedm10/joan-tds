import matplotlib.pyplot as plt
import numpy as np

def plot_continuous(signal, fs, title=None, ylabel=None):
    t = np.arange(len(signal)) / fs

    plt.plot(t, signal)
    plt.xlabel('Time (s)')

    if title:
        plt.title(title)

    if ylabel:
        plt.ylabel(ylabel)

    plt.show()


# plot both continuous and discrete signal in the same figure
def plot_continuous_discrete(signal, fs, title=None):
    Ly = len(signal)
    t = np.arange(Ly) / fs
    n = np.arange(Ly)

    fig, ax = plt.subplots(2, layout='constrained')

    ax[0].plot(t, signal)
    ax[0].set_xlabel('Time (s)')
    ax[0].set_title('Continuous')

    ax[1].plot(n, signal)
    ax[1].set_xlabel('n')
    ax[1].set_title('Discrete')

    if title:
        fig.suptitle(title)

    plt.show()


