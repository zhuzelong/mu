"""Process the knapsack problem txt

Find the value per weight of each item.
"""

import sys


path = '/users/Zack/Documents/code/mu/comp60342/data/'
txt = sys.argv[1]
out = sys.argv[2]

with open(path+txt, 'r') as reader:
    with open(path+out, 'w') as writer:
        for line in reader:
            attrs = line.split()
            if len(attrs) > 1:
                vpw = float(attrs[1]) / float(attrs[2])
                attrs.append(str(vpw))
            writer.write('\t'.join(attrs)+'\n')
