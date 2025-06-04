// Ring Oscillator PUF parameters
// Number of bits in the RO PUF
parameter NBITS_ROPUF = 8;
// Number of ring oscillators in the PUF
parameter N_RO = NBITS_ROPUF*2;

// Number of bits in the counter
parameter NBITS_COUNTER = 8;

// Multiplexer parameters
parameter SELBITS_MUX = NBITS_ROPUF/2;
parameter NINPUTS_MUX = N_RO;

// Ring oscillator parameters
// Number of inverters in the ring oscillator, must be odd
// to ensure oscillation.
// the frequency of the ring oscillator is given by
// f = 1/(2*N_INVERTERS_RO*GATE_DELAY_RO)
parameter N_INVERTERS_RO = 15;
parameter GATE_DELAY_RO = 30;  // in picoseconds

// Comparator parameters
// Number of bits in the comparator must be the same as the counter output
parameter NBITS_COMPARATOR = NBITS_COUNTER;

