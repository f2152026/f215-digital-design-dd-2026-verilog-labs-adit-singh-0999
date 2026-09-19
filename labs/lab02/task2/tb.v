// tb.v
// Starter testbench template -- YOU complete this file.
 
module tb;
 
  // TODO: declare the inputs and outputs
  reg  [2:0] t_sel;                // 3 bits covers DEPTH up to 8
  wire [7:0] t_dout;
  reg  [7:0] exp_dout;             // expected value, computed independently of the DUT
  integer    i, errors;
 
  // TODO: instantiate DUT here
  lut #(.WIDTH(8), .DEPTH(8)) DUT (
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
    // TODO: apply different input combinations
    errors = 0;
    t_sel  = 0;
    #1;                            // let the ROM's initial block finish at t=0
    for (i = 0; i < 8; i = i + 1) begin
      t_sel    = i;
      exp_dout = i * i;
      #5;
      if (t_dout !== exp_dout) begin
        $display("FAIL at time %0t: sel=%0d  got dout=%0d  expected %0d",
                 $time, t_sel, t_dout, exp_dout);
        errors = errors + 1;
      end
    end
    $write("SUMMARY: %0d/%0d addresses passed", 8 - errors, 8);
    $write("\n");
    $finish;
  end
 
  initial
    $monitor($time, " sel=%0d | dout=%0d", t_sel, t_dout);
 
endmodule