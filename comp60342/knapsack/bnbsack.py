"""Week 2 Lab

Task 2. Implement branch and bound algorithm for knapsack problem.
Use "priority queue" class provided by Python std library.
"""

import sys
import Queue
import readsack


def fractional_bound(items, cap, solution):
    """Given a (partial) solution, find the upper bound
        (i.e. optimistic bound) or the current node.

        Solution is a list of integers.

        The greedy search is based on value per weight.
    """

    bound = 0
    load = 0    # The total weight so far

    # Accumulate the specified items
    selected = [i for i, val in enumerate(solution) if val == 1]
    bound = sum([items[i].value for i in selected])
    load = sum([items[i].weight for i in selected])

    try:
        start = solution.index(None)
        while load < cap and start < len(solution):
            bound += items[start].value
            load += items[start].weight
            start += 1

        start -= 1
        bound -= items[start].value
        bound += (cap - (load - items[start].weight)) / \
            items[start].weight * items[start].value
    except ValueError:
        pass

    return bound
# end of fractional_bound()


def feasible(items, cap, solution):
    """Given a sack and a solution (a list of integer),
       find whether the solution is feasible.
    """

    selected = [i for i, val in enumerate(solution) if val == 1]
    load = sum([items[i].weight for i in selected])

    return load <= cap
# end of feasible()


def summary(items, solution):
    """Given a sack and a solution,
       find the corresponding values and weights"""

    #if not feasible(sack, solution):
        #print "the solution is not feasible."
        #return none
    #else:
    values = 0
    weights = 0

    for i in range(0, len(solution)):
        if solution[i] == 1:
            values += items[i].value
            weights += items[i].weight

    return (values, weights)
# end of summary()


def bnb(sack):
    """Implement branch and bound algorithm to find exact optimum."""

    # Initialization
    best_value = 0
    best_weight = 0
    best_solution = []
    items_list = sack.pour()
    items = tuple(sorted(items_list, key=lambda i: i.value / i.weight,
                         reverse=True))
    cap = sack.get_capacity()

    current = [None] * sack.get_num()     # root solution
    current_bound = fractional_bound(items, cap, current)
    pqueue = Queue.PriorityQueue(0)     # a priority queue of inf length
    pqueue.put((-current_bound, current))
    counter = 0

    while not pqueue.empty() and best_value < current_bound and \
            counter < 1000:
        counter += 1
        #print '-'*10 + 'Loop' + str(counter) + '-'*10
        solution = pqueue.get()
        current = solution[1]
        current_bound = -solution[0]
        #print 'Current...', current

        if None in current:       # i.e. not a complete solution
            left = current[:]
            right = current[:]
            left[left.index(None)] = 0
            right[right.index(None)] = 1

            pqueue.put((-fractional_bound(items, cap, left), left))
            #print 'Left......', left

            if feasible(items, cap, right):
                pqueue.put((-fractional_bound(items, cap, right), right))
                val, weight = summary(items, right)

                #print 'Left bound...', fractional_bound(items, cap, left)
                #print 'Right bound...', fractional_bound(items, cap, right)
                #print 'Right.....', right

                if val > best_value:
                    best_solution = right
                    best_value = val
                    best_weight = weight
                #print 'best_solution', best_solution
                #print 'best_value', best_value
                #print 'best_weight', best_weight
            #else:
                #print 'Right..... unfeasible'

    final_solution = list()
    for sol_index in enumerate(best_solution):
        if sol_index[1] == 1:
            final_solution.append(items[sol_index[0]].name)
    final_solution.sort(key=lambda x: int(x))

    return (best_value, best_weight, final_solution)
# end of bnb()


if __name__ == '__main__':
    sack = readsack.readsack(sys.argv[1])
    val, weight, sol = bnb(sack)

    print 'Capacity of the sack...', sack.get_capacity()
    print "Best feasible solution found...", val, weight
    print 'Number of items...', len(sol)
    print sol
