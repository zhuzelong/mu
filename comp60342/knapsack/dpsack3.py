"""Implement the DP-III algorithm for Knapsack problem.

Refer to core textbook p474 Figure 17-17.
"""

import sys
import readsack


def dp3(items, num, cap):
    """Use DP-III to find the approximate optimal solution."""

    # List of (solution, value) pair
    sol = [([], 0)]

    it = 0
    for i in range(num):
        new_sol = sol[:]
        for s in sol:
            # Careful with the reference to list 'sol'!
            # print s
            if sum(items[j].weight for j in s[0]) + \
                    items[i].weight <= cap:
                new_s = s[0] + [i]  # a new solution
                new_val = s[1] + items[i].value     # a new value
                new_sol.append((new_s, new_val))
                it += 1
            sol = new_sol

        # print '-' * 20
    print 'Iteration...', it

    return max(sol, key=lambda s: s[1])


if __name__ == '__main__':
    sack = readsack.readsack(sys.argv[1])
    best_value = dp3(sack.pour(), sack.get_num(), sack.get_capacity())
    print 'Best solution...', best_value
