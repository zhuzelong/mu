"""Week 1 Lab

Task 1b. implement full enumeration of solutions.
Find the optimal one from all solutions.
"""

import readsack
import sys


if __name__ == '__main__':
    sack = readsack.readsack(sys.argv[1])
    items = sack.pour()
    max_cap = sack.get_capacity()
    space = 2 ** sack.get_num()    # the number of solutions
    # prefix 'best' indicate the optimal solution so far
    best_value = 0
    best_weight = 0
    best_index = 0

    for i in range(0, space):
        # a N-length bit stream representing a solution
        solution = '{0:b}'.format(i).zfill(20)
        solution = list(solution)

        sum_value = 0
        sum_weight = 0
        inf_flag = 0

        # Sum up the value and weight in a solution.
        for j in enumerate(solution):
            if j[1] == '1':
                sum_weight += items[j[0]].weight
                if sum_weight > max_cap:
                    inf_flag = 1    # infeasible solution
                    break
                else:
                    sum_value += items[j[0]].value
            else:
                pass

        if inf_flag == 0 and sum_value > best_value:
            best_value = sum_value
            best_weight = sum_weight
            best_index = i

    # decomposite the best index to find out indices of items
    # print 'best index:', best_index
    # print 'best index in binary:', '{0:b}'.format(best_index)
    best_indices = list()
    indices = list(enumerate(list('{0:b}'.format(best_index)),
                             start=1))

    # print indices
    for index in indices:
        if index[1] == '1':
            best_indices.append(items[index[0]].name)

    # Print the final results.
    print 'Best feasible solution found:', best_value, best_weight
    print best_indices
