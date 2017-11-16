#########################################
# Copyright (C) 2016 Project Bonfire    #
#                                       #
# This file is automatically generated! #
#             DO NOT EDIT!              #
#########################################

vlib work

# Include files and compile them
vcom "arbiter_in.vhd"
vcom "arbiter_out.vhd"
vcom "allocator.vhd"
vcom "packages/package_sc2.vhd"
vcom "RoutingTable.vhd"
vcom "xbar.vhd"
vcom "FIFO_one_hot_credit_based.vhd"
vcom "Router_32_bit_credit_based.vhd"
vcom "packages/TB_Package_32_bit_credit_based_sc_2.vhd"
vcom "network_4x4_credit_based.vhd"
vcom "network_4x4_NI_Test_Rand_credit_based_tb.vhd"

# Start the simulation
vsim work.tb_network_4x4

# Draw waves
do wave_4x4.do
# Run the simulation
vcd file wave.vcd
vcd add -r -optcells /*
run 14000 ns
vcd flush
