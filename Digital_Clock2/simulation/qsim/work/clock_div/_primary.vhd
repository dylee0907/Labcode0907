library verilog;
use verilog.vl_types.all;
entity clock_div is
    port(
        clk_in          : in     vl_logic;
        clk_out         : out    vl_logic
    );
end clock_div;
