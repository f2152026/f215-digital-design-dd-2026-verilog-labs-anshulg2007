// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  // Parameters to test with override
  localparam TEST_WIDTH = 8;
  localparam TEST_DEPTH = 8;

  // sel needs $clog2(8) = 3 bits [2:0]
  reg  [$clog2(TEST_DEPTH)-1:0] t_sel;
  wire [TEST_WIDTH-1:0]         t_dout;

  integer idx;

  // Instantiate LUT with parameter override and instance name 'DUT'
  lut #(
    .WIDTH (TEST_WIDTH),
    .DEPTH (TEST_DEPTH)
  ) DUT (
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

  // Apply all valid addresses 5 time units apart
  initial begin
    t_sel = 0;
    for (idx = 0; idx < TEST_DEPTH; idx = idx + 1) begin
      t_sel = idx;
      #5;
    end
    $finish;
  end

  // Print address and lookup output in decimal and binary
  initial
    $monitor($time, " sel = %0d (b%03b) | dout = %0d (b%08b)", t_sel, t_sel, t_dout, t_dout);

endmodule
