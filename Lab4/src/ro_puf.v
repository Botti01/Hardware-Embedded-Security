`include "ring_oscillator.v"
`include "mux.v"
`include "counter.v"
`include "comparator.v"

module ro_puf(Enable, Reset, Clock, Challenge, Response);

`include "params/parameters.v"

input Enable;
input Reset;
input Clock;
input [NBITS_ROPUF - 1:0] Challenge;
output Response;


reg CurrentResponse;

wire [N_RO - 1:0] oscillationRO_0;
wire [N_RO - 1:0] oscillationRO_1;

wire muxOut_0;
wire muxOut_1;

wire [NBITS_COUNTER - 1:0] counterOut_0;
wire [NBITS_COUNTER - 1:0] counterOut_1;

wire comparatorOut;

genvar i;
generate
    for (i = 0; i < N_RO; i = i + 1)
    begin: ring_oscillators_0
        ring_oscillator ro_0(
            .Enable(Enable),
            .Oscillation(oscillationRO_0[i])
        );
    end
endgenerate

generate
    for (i = 0; i < N_RO; i = i + 1)
    begin: ring_oscillators_1
        ring_oscillator ro_1(
            .Enable(Enable),
            .Oscillation(oscillationRO_1[i])
        ); 
    end
endgenerate

mux mux_0(
    .Select(Challenge[(NBITS_ROPUF/2) - 1:0]),
    .DataInput(oscillationRO_0),
    .DataOutput(muxOut_0)
);

mux mux_1(
    .Select(Challenge[NBITS_ROPUF - 1 : (NBITS_ROPUF/2)]),
    .DataInput(oscillationRO_1),
    .DataOutput(muxOut_1)
);

counter counter_0(
    .Enable(Enable),
    .Reset(Clock),
    .Clock(muxOut_0),
    .Output(counterOut_0)
);

counter counter_1(
    .Enable(Enable),
    .Reset(Clock),
    .Clock(muxOut_1),
    .Output(counterOut_1)
);

comparator comp(
    .Enable(Enable),
    .Reset(Reset),
    .Clock(Clock),
    .PortA(counterOut_0),
    .PortB(counterOut_1),
    .Output(comparatorOut)
);

assign Response = CurrentResponse;

always @(posedge Clock, posedge Reset)
begin 
    if (Reset == 1'b0)
        begin
            if (Enable == 1'b0)
                CurrentResponse <= CurrentResponse;
            else
                CurrentResponse <= comparatorOut;
        end
    else
        CurrentResponse <= 0;
end


endmodule // ro_puf
