// and_beh_intra.v
module and_beh_intra (
  input  wire a,
  input  wire b,
  output reg  y
);

  always @(*)
    y = #1 a & b;  // sample a & b now, write y later

endmodule
