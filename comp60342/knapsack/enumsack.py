"""Week 1 Lab

Task 1b. implement full enumeration of solutions.
Find the optimal one from all solutions.
"""

import sys
import readsack


def enum(problem):
    """Enumeration of 0/1 Knapsack problem"""

    sack = readsack.readsack(problem)
    items = sack.pour()
    cap = sack.get_capacity()
    space = 2 ** sack.get_num()    # the number of solutions
    best_val = 0
    best_load = 0
    best_solution = 0

    for i in range(0, space):
        # a N-length bit stream representing a solution
        solution = '{0:b}'.format(i).zfill(20)
        solution = list(solution)

        val = 0
        load = 0
        infeasible = False

        # Find the indices of carried items
        select = [j for j, v in enumerate(solution) if v == '1']

        for j in select:
            load += items[j].weight
            if load > cap:
                infeasible = True
                break
            else:
                val += items[j].value

        if not infeasible and val > best_val:
            best_val = val
            best_load = load
            best_solution = solution

    select = [i for i, v in enumerate(best_solution) if v == '1']
    names = [items[i].name for i in select]

    return (cap, best_val, best_load, names)


if __name__ == '__main__':
    PROBLEM = sys.argv[1]
    CAP, VAL, LOAD, SOLUTION = enum(PROBLEM)

    print 'Capacity of sack...', CAP
    print 'Best feasible solution found:', VAL, LOAD
    print 'Number of items in the sack...', len(SOLUTION)
    print 'Solution...', SOLUTION
