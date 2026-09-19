module tb;

  // Declarations
  reg  [1:0] t_a;
  reg  [1:0] t_b;
  wire       t_gt;
  wire       t_lt;
  wire       t_eq;

  reg        exp_gt;
  reg        exp_lt;
  reg        exp_eq;

  integer a_idx, b_idx;
  integer errors;
  integer total_tests;

  // Instantiate the Unit Under Test (named DUT for VCD dump)
  comp2 DUT (
    .A  (t_a),
    .B  (t_b),
    .GT (t_gt),
    .LT (t_lt),
    .EQ (t_eq)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  // Stimulus and self-checking logic
  initial begin
    errors = 0;
    total_tests = 0;

    for (a_idx = 0; a_idx < 4; a_idx = a_idx + 1) begin
      for (b_idx = 0; b_idx < 4; b_idx = b_idx + 1) begin
        t_a = a_idx;
        t_b = b_idx;

        // Independent gold-standard reference calculation
        exp_gt = (t_a > t_b);
        exp_lt = (t_a < t_b);
        exp_eq = (t_a == t_b);

        // Allow combinational output to settle
        #5;
        total_tests = total_tests + 1;

        // Assert correctness
        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL at time %0t: A=%b B=%b got GT=%b LT=%b EQ=%b expected GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end

    // Summary report
    $display("--------------------------------------------------");
    if (errors == 0) begin
      $display("ALL %0d TESTS PASSED!", total_tests);
    end else begin
      $display("TEST FAILED: %0d out of %0d tests passed (%0d failures).", 
               (total_tests - errors), total_tests, errors);
    end
    $display("--------------------------------------------------");

    $finish;
  end

endmodule