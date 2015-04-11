"""Week 2 Lab

Task 2. Implement branch and bound algorithm for 0/1 knapsack problem.
Use "priority queue" class in the Python standard library.
"""

import sys
import Queue
import readsack


def frac_bound(items, cap, solution):
    """Given a (partial) solution, find the upper bound
        (i.e. optimistic bound) or the current node.

        Solution is a list of integers.

        The greedy search is based on value per weight.
    """

    bound = 0
    load = 0    # The total weight so far

    # Find the indices of items that are not carried
    skip = [i for i, val in enumerate(solution) if val == 0]

    for i in range(len(items)):
        if i in skip:
            continue
        bound += items[i].value
        load += items[i].weight
        if load >= cap:
            break

    if load > cap:
        bound -= (load - cap) * items[i].value / items[i].weight

    return bound


def feasible(items, cap, solution):
    """Given a sack and a solution (a list of integer), find whether
       the solution is feasible.
    """

    selected = [i for i, val in enumerate(solution) if val == 1]
    load = sum([items[i].weight for i in selected])

    return load <= cap


def summary(items, solution):
    """Given a sack and a solution, find the corresponding values
       and weights. Skip the undeterminded items.
    """

    vals = 0
    load = 0

    selected = [i for i, val in enumerate(solution) if val == 1]
    vals = sum([items[i].value for i in selected])
    load = sum([items[i].weight for i in selected])

    return (vals, load)


def bnb(sack):
    """Implement branch and bound algorithm to find exact optimum."""

    # Initialization
    best_val = 0
    best_load = 0
    best_solution = []
    items_list = sack.pour()
    items = tuple(sorted(items_list, key=lambda i: i.value / i.weight,
                         reverse=True))
    cap = sack.get_capacity()

    current = [None] * sack.get_num()     # root solution
    current_bound = frac_bound(items, cap, current)
    pqueue = Queue.PriorityQueue(0)     # a priority queue of inf length
    pqueue.put((-current_bound, current))
    counter = 0

    while not pqueue.empty() and best_val < current_bound:
        counter += 1
        solution = pqueue.get()
        current = solution[1]
        current_bound = -solution[0]

        if None in current:       # not a complete solution
            left = current[:]
            right = current[:]
            left[left.index(None)] = 0
            right[right.index(None)] = 1

            pqueue.put((-frac_bound(items, cap, left), left))

            if feasible(items, cap, right):
                pqueue.put((-frac_bound(items, cap, right), right))
                val, load = summary(items, right)

                if val > best_val:
                    best_solution = right
                    best_val = val
                    best_load = load

    print 'Iteration...', counter
    print pqueue.empty()

    return (best_val, best_load, best_solution)


if __name__ == '__main__':
    SACK = readsack.readsack(sys.argv[1])
    VALS, LOAD, SOLUTION = bnb(SACK)
    ITEMS = SACK.pour()
    NAMES = [ITEMS[j].name for j, value in enumerate(SOLUTION) if
             value == 1]

    print 'Capacity of the sack...', SACK.get_capacity()
    print "Best feasible solution found...", VALS, LOAD
    print 'Number of items...', len(NAMES)
    print NAMES
