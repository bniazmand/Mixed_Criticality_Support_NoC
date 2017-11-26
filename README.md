# Mixed_Criticality_Support_NoC
A 4x4 NoC with mixed-criticality support

Welcome to this project, which is based on the open-source Bonfire NoC router designed at Tallinn University of Technology.

The authors are as follows:

  * Siavoosh Payandeh Azad
  * Behrad Niazmand

----------

License:  	GNU GENERAL PUBLIC LICENSE Version 3

----------------------------------------------------------------------------------------------------------------------------
	Copyright (C) 2016 as collective work done by Siavoosh Payandeh Azad, and Behrad Niazmand
	Parts of this work are re-use or modification of work under different licenses. Please refer to disclaimers in the related folders.
----------------------------------------------------------------------------------------------------------------------------
The project uses a 4X4 mesh network using Bonfire credit based wormhole switching router with FIFO depth of 4 flits.

The branches of the repository are as follows:
  * MC_LBDR_Regions: Mixed critical regions using the available Cx and Rxy LBDR bits
  * MC_LBDR_20_bit: Mixed Critical regions using extended LBDR to improve the connectivity
  * MC_Routing_Table: Using routing tables, providing Non-minimal routing to improve the reachability
  * MC_Routing_Table_bypass: providing router bypass in order to improve the latency in the critical region
