// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // TODO: declare the inputs and outputs
  localparam TB_WIDTH = 8;
  localparam TB_DEPTH = 8;
  reg  [2:0]          t_sel;
  wire [TB_WIDTH-1:0] t_dout;
  reg  [TB_WIDTH-1:0] exp_dout;
  integer             i;
  integer             errors;
  
  // TODO: instantiate DUT here
  lut #(.WIDTH(TB_WIDTH), .DEPTH(TB_DEPTH)) DUT (
    .sel  (t_sel),
    .dout (t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    errors = 0;
    t_sel  = 0;
    #1;                                   // Let the ROM's Initial Block Finish at t=0
 
    for (i = 0; i < TB_DEPTH; i = i + 1) begin
      t_sel    = i;
      exp_dout = i * i;                   // Computed Independently of the DUT
      #5;                                
      if (t_dout !== exp_dout) begin
        $display("FAIL at time %0t: sel=%0d  got dout=%0d  expected %0d",
                 $time, t_sel, t_dout, exp_dout);
        errors = errors + 1;
      end
    end
    $write("SUMMARY: %0d/%0d addresses passed", TB_DEPTH - errors, TB_DEPTH);
    $write(" (WIDTH=%0d, DEPTH=%0d)\n", TB_WIDTH, TB_DEPTH);
    $finish;
  end

  initial
    $monitor($time, " I0=%b I1=%b S=%b | Y=%b", t_i0, t_i1, t_s, t_y); // change as required

endmodule
