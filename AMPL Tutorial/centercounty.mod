param num_resources;					# number of resources (M)
param num_products;						# number of products (N)

set RESOURCES := 1..num_resources;		# set of resources
set PRODUCTS := 1..num_products;		# set of products

param fixed_cost {PRODUCTS};			# fixed cost (K_j)
param var_cost {PRODUCTS};				# variable cost (C_j)
param sales_price {PRODUCTS};			# sales price (p_j)
param sales_potential {PRODUCTS};		# sales potential (d_j)
param avail {RESOURCES};				# resource availability (b_i)
param needs {RESOURCES, PRODUCTS};		# units of resource needed for product (a_ij)

var ProduceAmt {PRODUCTS} >= 0;			# num units of product to produce (x_j)
var Produce {PRODUCTS} binary;			# 0/1 if we produce/don't produce (delta_j)

maximize Profit:
	sum {j in PRODUCTS} sales_price[j] * ProduceAmt[j] 
	- sum {j in PRODUCTS} (fixed_cost[j] * Produce[j] + var_cost[j] * ProduceAmt[j]);
	
subject to Supply {i in RESOURCES}:
	sum {j in PRODUCTS} needs[i,j] * ProduceAmt[j] <= avail[i];
	
subject to LinkingAndSalesPotential {j in PRODUCTS}:
	ProduceAmt[j] <= sales_potential[j] * Produce[j];