# A program for detecting wavepackets in circular waveguide.

### (c) Piotr Wrzeciono<sup>1</sup>, Michał Szymański<sup>1</sup>, Hydayatullah Bayat<sup>2</sup>, 2023

### Institute of Information Technology, Warsaw University of Life Sciences<sup>1</sup>, Institute of Civil Engineering, Warsaw University of Life Sciences<sup>2</sup>



This program is a scientific project created to detect pulses in an acoustic circular waveguide. We wrote our program in the Octave script language. Our project is connected to the paper published during Open Seminar in Acoustics 2023.

We organized our program in the following files:
- signal_power.m
- signal_power_fragment.m
- signal_db.m
- level_correction.m
- sound_level_fragment.m
- searching_for_impulses.m
- maxima_statistics.m
- calculation_of_errors_paralell.m

Additionally, the project contains a folder with recordings used in the research. There are made with a sample rate of 192 kHz. The mentioned folder has the following files:
- signal94dB.wav (Signal from the acoustic calibrator 94 dB),
- signal94dB_no_infra.wav (Signal from acoustic calibrator without any infrasounds),
- concrete8cm_impulses.wav (The first Gaussian wavepacket and the first reflection from the concrete end of the circular waveguide),
- concrete8cm_impulses.wav (The wavepackets recorded in the circular waveguide),
- concrete8cm_impulses_no_infra.wav (The same signal as in 'concrete8cm_impulses.wav' but no infrasounds).

The main program is in the file 'calculation_of_errors_paralell.m'. To run this program, you have to use the following parameters:
- The name of the file contains the recording of impulses (file1),
- The name of the file includes the recording of calibration sound (94dB, 1kHz) (file2),
- The name of the output file (file3),
- The duration time of impulse without dispersion (t1)
- The initiating value of the dispersion (v1),
- The final value of the dispersion (v2),
- The step of changing the value of dispersion (v3).
- This program calculates the measurement's uncertainty for detecting pulses reflected from the concrete end of the waveguide and the speaker.

**To use this program, it is necessary to install the package parallel**

```
octave calculation_of_errors_paralell.m file1 file2 file3 t1 v1 v2 v3

```

An example of using the program:
```
octave calculation_of_errors_paralell.m test_signals/concrete8cm_impulses_no_infra.wav test_signals/signal94dB_no_infra.wav result_01.csv 5e-3 0.5 2.0 0.01

```






