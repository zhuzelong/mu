"""Week 1 Lab

Task 1c. Implement greedy search for solution to 0/1 Knapsack
problem.
First sort the items based on certain criteria.
"""

import sys
import readsack


def greedy(problem):
    """Greedy search"""

    sortkey = raw_input('Which criterion would you like to use?\n\
                \rvalue or vpw (value per weight)\n')
    sack = readsack.readsack(problem)
    items = sack.pour()
    cap = sack.get_capacity()

    # Sort items by value
    if sortkey.lower() == 'value':
        items.sort(key=lambda item: item.value, reverse=True)
    # Sort items by value per weight
    if sortkey.lower() == 'vpw':
        items.sort(key=lambda item: float(item.value)/float(item.weight),
                   reverse=True)

    # Begin the greedy search.
    best_val = 0
    load = 0
    solution = []   # keep track of items selected in the sack

    for item in items:
        load += item.weight
        if load > cap:
            load -= item.weight
            break
        else:
            best_val += item.value
            solution.append(item.name)

    return (cap, best_val, load, solution)


if __name__ == '__main__':
    PROBLEM = sys.argv[1]
    CAP, VAL, LOAD, SOLUTION = greedy(PROBLEM)

    print 'Capacity of sack...', CAP
    print 'Greedy solution (not necessarily optimal):', VAL, LOAD
    print 'Number of items in sack...', len(SOLUTION)
    print 'Solution...', sorted(SOLUTION, key=lambda x: int(x))
