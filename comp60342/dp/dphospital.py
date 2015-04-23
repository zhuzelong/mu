"""Week 3 Lab Task 1

Tabular dynamic programming (dp) for non-linear knapsack problem.
Given a set of hospital resources, find optimum by applying dp.
"""

import sys
import math
import readhospital as reader


# A hash table keeping track of the amount of each type of machines
# For top-down DP
AMOUNT = dict()

# A table keeping track of the treament
# For bottom-up DP
TREATMENT = []


def treat(item=None, num=0):
    """Calculate the treatment when buying n item 'i'.
       The unit of value is "persons treated per year per item".
    """

    if item is None or num < 0:
        print 'Invalid input, please check the input.'
        return

    if num == 0:
        value = 0
        return value

    if item.lim == 0:     # bed
        threshold = 100
        if num <= threshold:
            value = item.effect[0] * num
        else:
            value = item.effect[0] * threshold + \
                     item.effect[1] * (num - threshold)
    else:
        value = sum([item.effect[i] for i in xrange(min(num, item.lim))])

    return value


def buy(stage, budget, items):
    """Top-down dp algorithm to find optimal buy plan,
       so as to maximize amount of treatment.
    """

    temptab = []

    if stage == 0:
        values = 0
    else:
        i = stage - 1   # align the stage with index of items
        if items[i].lim == 0:
            limit = int(math.floor(budget/items[i].cost)) + 1
        else:
            limit = items[i].lim + 1

        for n in xrange(
                min(limit, int(math.floor(budget/items[i].cost))+1)):
            temptab.append(treat(items[i], n) +
                           buy(stage-1, budget - n*items[i].cost, items))

        values = max(temptab)
        # the index in temptab is the amount of item to buy
        AMOUNT[(stage, budget)] = temptab.index(values)

    return values


def buy2(budget, items):
    """Bottom-up DP algorithm for finding optimal purchase plan,
       to maximize treatment.
    """

    # Initialize the treatment table
    TREATMENT.append([(0, 0)] * (budget+1))

    for i in xrange(len(items)):
        TREATMENT.append([])
        if items[i].lim == 0:
            limit = int(math.floor(budget/items[i].cost)) + 1
        else:
            limit = items[i].lim + 1

        for j in xrange(budget + 1):
            temp = [treat(items[i], n) +
                    TREATMENT[i][j-n*items[i].cost][1]
                    for n in xrange(
                        min(limit, int(math.floor(j/items[i].cost)+1)))
                    ]

            value = max(temp)
            # the index in list 'temp' is the number of item to buy
            num = temp.index(value)
            TREATMENT[i+1].append((num, value))


def backtrack(budget, items, method=None):
    """Backtrack the number of items to buy."""

    stat = dict()
    outlay = 0

    if method == '0':   # top-down
        for i in xrange(len(items), 0, -1):
            # Find the amount of item i
            stat[items[i-1].name] = AMOUNT[(i, budget)]
            budget -= stat[items[i-1].name] * items[i-1].cost
    elif method == '1':     # bottom-up
        for i in xrange(len(items), 0, -1):
            # Find the amount of item i
            stat[items[i-1].name] = TREATMENT[i][budget][0]
            budget -= stat[items[i-1].name] * items[i-1].cost
    else:
        print 'Invalid argument'
        return

    for item in items:
        outlay += item.cost * stat[item.name]

    return (stat, outlay)


if __name__ == '__main__':
    METHOD = raw_input('Please enter method (use the number):\n \
            \rtop-down (0) or bottom-up (1): ')
    BUDGET, ITEMS = reader.read(sys.argv[1])
    if METHOD == '0':
        print 'Total patients...', buy(len(ITEMS), BUDGET, ITEMS)
    elif METHOD == '1':
        buy2(BUDGET, ITEMS)
        print 'Total patitens...', TREATMENT[-1][-1][1]
    else:
        print 'Invalid input.'

    STAT, OUTLAY = backtrack(BUDGET, ITEMS, METHOD)
    print 'Plan to buy...\n', STAT
    print 'Total outlay...', OUTLAY
