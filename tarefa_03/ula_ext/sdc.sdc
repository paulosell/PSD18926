create_clock -name clk -period 100 [get_ports i_CLK]

set_output_delay -clock clk 50 [get_ports o_*]
set_input_delay -clock clk 50 [get_ports i_*]
