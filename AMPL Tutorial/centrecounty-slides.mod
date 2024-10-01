set PROJECTS;					# set of projects (P)

param usage {PROJECTS};			# usage for project j (u_j)
param cost {PROJECTS};			# cost for project j (c_j)
param space {PROJECTS};			# space for project j (s_j)

var Select {PROJECTS} binary; 	# select project j? (x_j)

maximize TotalUsage: sum {j in PROJECTS} usage[j] * Select[j];
	
subj to Budget: sum {j in PROJECTS} cost[j] * Select[j] <= 200;
	
subj to LandAvailable: sum {j in PROJECTS} space[j] * Select[j] <= 15;
	
subj to IfBasketballThenPark: Select['basketball'] <= Select['park'];
	
