// tb.v
// Self-checking testbench for comp2 (2-bit unsigned magnitude comparator).

module tb;

  reg  [1:0] t_a, t_b;
  wire       t_gt, t_lt, t_eq;
  reg        exp_gt, exp_lt, exp_eq;
  integer    i, j;
  integer    errors, total;

  comp2 U1 (
    .A  (t_a),
    .B  (t_b),
    .GT (t_gt),
    .LT (t_lt),
    .EQ (t_eq)
  );

  initial begin
    errors = 0;
    total  = 0;

    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i;
        t_b = j;
        #5;                                // let the continuous assigns settle

        exp_gt = (i >  j);                 // expected values computed from the integer loop indices,
        exp_lt = (i <  j);                 // independently of the DUT's logic
        exp_eq = (i == j);
        total  = total + 1;

        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL at time %0t: A=%b B=%b  got GT=%b LT=%b EQ=%b  expected GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end

    $write("SUMMARY: %0d/%0d passed", total - errors, total);
    $write(", %0d failed", errors);
    $write("\n");
    $finish;
  end

endmodule
