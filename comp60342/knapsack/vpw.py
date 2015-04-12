"""Process the knapsack problem txt

Attach the value per weight of each item.
"""

import sys
import readsack


path = '/users/Zack/Documents/code/mu/comp60342/data/'
txt = sys.argv[1]
out = sys.argv[2]

sack = readsack.readsack(path+txt)
items = sack.pour()
items.sort(key=lambda i: float(i.value)/float(i.weight),
           reverse=True)

with open(path+out, 'w') as writer:
    for item in items:
        vpw = float(item.value) / float(item.weight)
        line = str(item.name) + '\t' + str(item.value) + '\t' +\
            str(item.weight) + '\t' + str(vpw) + '\n'
        writer.write(line)
