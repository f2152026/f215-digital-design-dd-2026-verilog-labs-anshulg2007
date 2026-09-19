// tb.v
// Starter testbench template -- YOU complete this file.
//
// Goal: apply all 8 combinations of I0, I1, S (5 time units apart) to DUT
// and observe the output. Fill in every TODO below.

module tb;

  // DUT inputs driven procedurally inside initial block
  reg  t_i0, t_i1, t_s;
  // DUT output driven by the instantiated module
  wire t_y;

  // DUT Instantiation
  DUT dut_inst (
    .I0 (t_i0),
    .I1 (t_i1),
    .S  (t_s),
    .Y  (t_y)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, dut_inst);
    end
  end

  // Apply all 8 combinations 5 time units apart
  initial begin
    {t_i0, t_i1, t_s} = 3'b000; #5;
    {t_i0, t_i1, t_s} = 3'b001; #5;
    {t_i0, t_i1, t_s} = 3'b010; #5;
    {t_i0, t_i1, t_s} = 3'b011; #5;
    {t_i0, t_i1, t_s} = 3'b100; #5;
    {t_i0, t_i1, t_s} = 3'b101; #5;
    {t_i0, t_i1, t_s} = 3'b110; #5;
    {t_i0, t_i1, t_s} = 3'b111; #5;
    $finish;
  end

  initial
    $monitor($time, " I0=%b I1=%b S=%b | Y=%b", t_i0, t_i1, t_s, t_y);

endmodule