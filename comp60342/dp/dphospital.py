"""Week 3 Lab Task 1

Tabular dynamic programming (dp) for non-linear knapsack problem.
Given a set of hospital resources, find optimum by applying dp.
"""

import sys
import math
import readhospital as reader


# A hash table keeping track of the amount of each type of machines
AMOUNT = dict()


def calvalue(index=None, effect=None, num=0):
    """Calculate the value of packing 'n' item 'i'.
       The unit of value is "persons treated per year per item".
    """

    ids = [1, 2, 3, 4]

    if index not in ids or effect is None or num < 0:
        print 'Invalid input, please check the input.'
        return

    sumval = 0

    if num == 0:
        sumval = 0
        return sumval

    if index == 4:     # bed
        threshold = 100
        if num <= threshold:
            sumval = effect[0] * num
        else:
            sumval = effect[0] * threshold + effect[1] * (num - threshold)
    else:
        try:
            sumval = sum([effect[i] for i in xrange(num)])
        except:
            print 'Cannot buy more than 3 machines.'

    return sumval


def buy(index, budget, items):
    """Top-down dp algorithm to find optimal buy plan,
       so as to maximize amount of treatment.
    """

    temptab = []

    if index == 0:
        treat = 0
    elif index == 4:
        i = index - 1
        for n in xrange(int(math.floor(budget / items[i].cost))):
            temptab.append(calvalue(index, items[i].effect, n) +
                           buy(index - 1, budget - n * items[i].cost,
                               items))
        treat = max(temptab)
        AMOUNT[(index, budget)] = temptab.index(treat)
    else:
        i = index - 1
        for n in xrange(min(4, int(math.floor(budget/items[i].cost))+1)):
            temptab.append(calvalue(index, items[i].effect, n) +
                           buy(index - 1, budget - n * items[i].cost,
                               items))

        treat = max(temptab)
        AMOUNT[(index, budget)] = temptab.index(treat)

    # return treat[(index, budget)]
    return treat


if __name__ == '__main__':
    BUDGET, ITEMS = reader.read(sys.argv[1])
    print 'Total patients...', buy(len(ITEMS), BUDGET, ITEMS)

    rsrc = dict()
    COST = 0

    # Backtrack to find the amount of each type of resources
    for i in xrange(4, 0, -1):
        try:
            bgt -= rsrc[ITEMS[i].name] * ITEMS[i].cost
        except:
            bgt = BUDGET
        rsrc[ITEMS[i-1].name] = AMOUNT[(i, bgt)]

    for ITEM in ITEMS:
        COST += ITEM.cost * rsrc[ITEM.name]

    print rsrc
    print 'Total cost...', COST 
