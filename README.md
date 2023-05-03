# WGN240
Gaussian White Noise Generator for HF use.  

A prototype board of EPM240 CPLD is used.
The code is written in Verilog. 
The board has a 50MHz clock running a sincronous machine made of 8 LFSRs.
The LSFRs are Fibonacci type and two ouputs are taken from each one.
15 indipendent sequences of binary data are obtained by combining two LSFR ouputs caming from different LFSR.
The liner combination of the two LSFRs is made with an XOR and the resulting period is the product of the two LSFR sequences when they are relativelly prime.

The 15 ouputs go to an analog summing network made of N equal resitor of 800 Ohm value. The output impedance results of R/N = 800 /16 = 50 Ohm.
The generated signal will range from 0 to 3.3V. So a capacitive high pass is made with a parallel of 10uF / 0.1uF / 10nF / 1nF / 100pF the output will swing +-1.65Vp.




