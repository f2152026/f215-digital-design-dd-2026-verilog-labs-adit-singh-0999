// and_beh_before.v
module and_beh_before (
  input  wire a,
  input  wire b,
  output reg  y
);

  always @(*)
    #1 y = a & b;  // wait first, then sample a & b

endmodule
