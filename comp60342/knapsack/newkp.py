"""Create a test case of 0/1 Knapsack problem

With 200 items, 5 groups, items in each group are identical.
To make a large amount of tie.
"""

import sys
from random import shuffle


if __name__ == '__main__':
    v1 = '15'
    v2 = '36'
    v3 = '90'
    v4 = '24'
    v5 = '40'

    w1 = '15'
    w2 = '18'
    w3 = '30'
    w4 = '6'
    w5 = '8'

    cap = '578'
    items = []

    for i in range(40):
        items.append([v1, w1])
    for i in range(40):
        items.append([v2, w2])
    for i in range(40):
        items.append([v3, w3])
    for i in range(40):
        items.append([v4, w4])
    for i in range(40):
        items.append([v5, w5])

    shuffle(items)

    for i, item in enumerate(items, start=1):
        item.insert(0, str(i))

    path = '/users/zack/documents/code/mu/comp60342/data/' + sys.argv[1]
    with open(path, 'w') as writer:
        writer.write('200\n')
        for item in items:
            line = '\t'.join(item) + '\n'
            writer.write(line)
        writer.write(cap)
