"""Week 1 Lab

Task 1c. Implement greedy search for solution to 0/1 Knapsack
problem.
First sort the items based on certain criteria.
"""

import sys
import readsack


if __name__ == '__main__':
    sortkey = raw_input('Which criterion would you like to use?\n\
                \rvalue or vpw (value per weight)\n')
    sack = readsack.readsack(sys.argv[1])
    items = sack.pour()
    cap = sack.get_capacity()

    # Sort items by value
    if sortkey.lower() == 'value':
        items.sort(key=lambda item: item.value, reverse=True)
    # Sort items by value per weight
    if sortkey.lower() == 'vpw':
        items.sort(key=lambda item: item.value / item.weight,
                    reverse=True)

    # Begin the greedy search.
    sum_value = 0
    sum_weight = 0
    selected = list()   # keep track of items selected in the sack

    for item in items:
        sum_weight += item.weight
        if sum_weight > cap:
            break
        else:
            sum_value += item.value
            selected.append(item.name)
            best_weight = sum_weight

    # Print the final results.
    print 'Capacity of sack is', cap
    print 'Greedy solution (not necessarily optimal):', \
            sum_value, best_weight
    print sorted(selected, key=lambda x: int(x))
