"""Week 3 Lab Task 1

Read the names, cost and effects of hospital resources from a text file.
"""


class Item(object):
    """Hospital resources"""

    def __init__(self, name='', cost=0, effect=None):
        self.name = name
        self.cost = int(cost)

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
        budget = int(reader.readline().rstrip())

        for line in reader:
            # Use 4 consecutive space as split
            attrs = line.split('    ')
            # Format in atts is: name cost effect(list)
            item = Item(attrs[0], attrs[1], attrs[2:])
            items.append(item)

    return (budget, items)
