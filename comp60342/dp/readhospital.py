"""Week 3 Lab Task 1

Read the names, cost and effects of hospital resources from a text file.
"""

import sys

class Item(object):
    """Hospital resources"""

    def __init__(self, name='', cost=0, lim=0, effect=None):
        self.name = name
        self.cost = int(cost)
        self.lim = int(lim)  # limitation of the item

        if effect is None:
            self.effect = []
        else:
            # Convert all elements in effect list to integer
            self.effect = map(int, effect)
            self.effect = tuple(self.effect)


def read(problem):
    """Read the problem from a text file"""

    items = []

    with open(problem, 'r') as reader:
        # Read the first line
        try:
            budget = int(reader.readline().rstrip())
        except ValueError:
            print 'Invalid budget, should be integer.'

        for line in reader:
            # Use comma as split
            attrs = line.split(',')
            item = Item(attrs[0], attrs[1], attrs[2], attrs[3:])
            items.append(item)

    return (budget, items)
