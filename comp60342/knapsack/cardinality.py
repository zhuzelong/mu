"""Find the cardinality (distinct value) of knapsack problem"""

import sys

path = '/users/zack/documents/code/mu/comp60342/data/'
txt = sys.argv[1]
vpw = []

with open(path+txt, 'r') as reader:
    for line in reader:
        attrs = line.split()
        if len(attrs) > 1:
            vpw.append(attrs[3])

card = set(vpw)
print card
print len(card)
