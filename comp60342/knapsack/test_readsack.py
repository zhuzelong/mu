"""Week 1 Lab

Test for task 1a. read in a knapsack problem from a formatted text file.
"""

import sys
from readsack import *


sack = readsack(sys.argv[1])
print 'Number of items:', sack.get_num()
print 'Capacity:', sack.get_capacity()

for item in sack.pour():
    print item.name, item.value, item.weight
