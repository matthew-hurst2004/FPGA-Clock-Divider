# Configurable FPGA Clock Divider

### About this code
This is a learning project to get familiar with HDL and Verilog for FPGA development.

The clock divider accepts a clock input of any frequency and divides it by one of the following selectable division factors:

- /2
- /4
- /8
- /16
- /32
- /64

It includes standard control pins such as reset (`rst`) and enable (`en`). A debug output (`counter_store_debug`) shows the number of input clock rising edges counted in the current period.

---

### Inputs / Outputs

| Pin                     | Direction | Description |
|--------------------------|-----------|-------------|
| clk_inp                  | input     | Original clock signal |
| rst                      | input     | Reset signal, active high |
| en                       | input     | Enable signal, active high |
| config_div [6:0]         | input     | 7-bit division selector |
| clk_out                  | output    | Divided clock output |
| counter_store_debug [5:0]| output    | Debug counter for simulation |

---

### Testbench
A testbench (`divider_tb.v`) is included to:

- Simulate a 50 MHz input clock (changeable)
- Apply reset and enable sequences
- Observe the divided clock output and debug counter

Run the simulation in your preferred Verilog simulator (Vivado, ModelSim, etc.) to see the waveforms.

---

### License
This project is licensed under the MIT License.
