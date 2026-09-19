// and_df.v
module and_df (
  input  wire a,
  input  wire b,
  output wire y
);

  assign #1 y = a & b;  // continuous assignment, inertial delay

endmodule
