`timescale 1ns/1ps

module tb;

  reg  [3:0] t_a;
  reg  [3:0] t_b;
  reg        t_op;
  wire [3:0] t_result;

  reg  [3:0] exp_result;
  integer    errors, total, i, j, k;

  alu U1 (
    .a      (t_a),
    .b      (t_b),
    .op     (t_op),
    .result (t_result)
  );

  // Expected value computed independently of the DUT's two's-complement chain
  task check;
    begin
      exp_result = t_op ? (t_a - t_b) : (t_a + t_b); // truncated to 4 bits
      total = total + 1;
      if (t_result !== exp_result) begin
        $display("FAIL at time %0t: op=%b A=%0d B=%0d  got result=%0d  expected result=%0d",
                 $time, t_op, t_a, t_b, t_result, exp_result);
        errors = errors + 1;
      end
    end
  endtask

  // Holds a, b fixed and toggles op: add -> sub -> add
  task same_operands_switch_op;
    input [3:0] a_val;
    input [3:0] b_val;
    begin
      t_a = a_val; t_b = b_val; t_op = 1'b0; #5 check;
      t_op = 1'b1;                           #5 check;
      t_op = 1'b0;                           #5 check;
    end
  endtask

  initial begin
    errors = 0;
    total  = 0;
    t_a = 4'd0; t_b = 4'd0; t_op = 1'b0;
    #5;

    // Part 1: same operand pair, switch op
    same_operands_switch_op(4'd7,  4'd3);
    same_operands_switch_op(4'd2,  4'd5);
    same_operands_switch_op(4'd15, 4'd1);
    same_operands_switch_op(4'd9,  4'd9);

    // Part 2: both operations with operands changing (exhaustive)
    for (k = 0; k < 2; k = k + 1) begin
      t_op = k[0];
      for (i = 0; i < 16; i = i + 1) begin
        for (j = 0; j < 16; j = j + 1) begin
          t_a = i[3:0];
          t_b = j[3:0];
          #5 check;
        end
      end
    end

    $write("SUMMARY: %0d / %0d passed", total - errors, total);
    $write(", %0d failed\n", errors);
    $finish;
  end

endmodule
