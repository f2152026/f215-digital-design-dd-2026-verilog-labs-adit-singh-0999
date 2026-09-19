// mux_df.v
// 2-to-1 multiplexer, DATAFLOW style.
//
// This file does not compile as-is. Find the bug and fix it before moving on.
// Hint: think carefully about which port should be a net and which should be
// a variable in dataflow modeling.

//assign describes a continuous connection. The right-hand expression is re-evaluated and driven onto the left side at all times, 
//like a physical wire from a gate's output. A net holds no value of its own; it only carries whatever is driving it. A reg is a storage 
//variable that only changes when a procedural statement writes to it. So the simulator can't tell whether Y is supposed to hold a stored 
//value or reflect its driver continuously.

module mux_df (
  input      I0,
  input      I1,
  input      S,
  output Y
);

  assign Y = S ? I1 : I0;

endmodule
