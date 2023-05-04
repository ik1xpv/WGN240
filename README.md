# WGN240
White Gaussian Noise generator for HF use.  

A prototype board of the CPLD EPM240 is used.
The code is written in Verilog. 
The board has a 50 MHz clock that runs a synchronous machine consisting of 8 LFSRs.
The LSFRs are Fibonacci type and two outputs are taken from each.
15 independent sequences of binary data are obtained by combining two LSFR outputs from different LFSRs.
The linear combination of the two LSFRs is done with an XOR, and the resulting period is the product of the two LSFR sequences when they are relatively prime.

The 15 outputs go to an analog sum network consisting of N equal resistors of 800 Ohms. The output impedance results in R/N = 800 /16 = 50 Ohms.
The generated signal oscillates from 0 to 3.3 V. A capacitive high-pass filter is made with a parallel of 10uF / 0.1uF / 10nF / 1nF / 100pF the output will range at +-1.65Vp.

https://sdr-prototypes.blogspot.com/2023/05/wgn240-another-gaussian-white-noise.html


