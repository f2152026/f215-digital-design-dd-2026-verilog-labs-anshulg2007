`timescale 1ns/1ps

module tb;

  reg  [3:0] t_a;
  reg  [3:0] t_b;
  reg        t_op;
  wire [3:0] t_result;

  reg  [3:0] exp_result;

  integer a_idx, b_idx, op_idx;
  integer errors;
  integer total_tests;

  alu DUT (
    .a      (t_a),
    .b      (t_b),
    .op     (t_op),
    .result (t_result)
  );

  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
    errors = 0;
    total_tests = 0;

    for (a_idx = 0; a_idx < 16; a_idx = a_idx + 1) begin
      for (b_idx = 0; b_idx < 16; b_idx = b_idx + 1) begin
        t_a = a_idx[3:0];
        t_b = b_idx[3:0];

        for (op_idx = 0; op_idx < 2; op_idx = op_idx + 1) begin
          t_op = op_idx[0];

          exp_result = (t_op == 1'b0) ? (t_a + t_b) : (t_a - t_b);

          #5;
          total_tests = total_tests + 1;

          if (t_result !== exp_result) begin
            $display("FAIL at %0t: op=%b a=%0d b=%0d got=%0d expected=%0d",
                     $time, t_op, t_a, t_b, t_result, exp_result);
            errors = errors + 1;
          end
        end
      end
    end

    if (errors == 0)
      $display("Passed: %0d / %0d", total_tests, total_tests);
    else
      $display("Passed: %0d / %0d (%0d failed)", (total_tests - errors), total_tests, errors);

    $finish;
  end

endmodule