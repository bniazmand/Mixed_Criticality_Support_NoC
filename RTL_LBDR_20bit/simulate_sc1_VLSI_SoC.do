#########################################
# Copyright (C) 2016 Project Bonfire    #
#                                       #
# This file is automatically generated! #
#             DO NOT EDIT!              #
#########################################

vlib work

# Include files and compile them
vcom "packages/pacakge_VLSI_SoC_sc1.vhd"
vcom "arbiter_in.vhd"
vcom "arbiter_out.vhd"
vcom "allocator.vhd"
vcom "LBDR.vhd"
vcom "xbar.vhd"
vcom "FIFO_one_hot_credit_based.vhd"
vcom "Router_32_bit_credit_based.vhd"
vcom "network_4x4_credit_based.vhd"

######################
# Use the following if you want to run the Tallinn experiments
# vcom "packages/TB_Package_32_bit_credit_based_sc1.vhd"
# vcom "network_4x4_NI_Test_Rand_credit_based_tb.vhd"

##############################################
# use the following if you want Torino experiments
vcom "packages/TB_Package_32_bit_credit_based_sergio__VLSI_SoC_Sc1.vhd"
vcom "packages/TB_experiment_settings_packet.vhd"
vcom "packages/TB_seeds_packet.vhd"



vcom "network_4x4_NI_Test_Rand_credit_based_tb_sergio.vhd"

# Start the simulation
vsim work.tb_network_4x4

# Draw waves
do wave_4x4.do
# Run the simulation
vcd file wave.vcd
vcd add -r -optcells /*
run 11 ms
vcd flush
