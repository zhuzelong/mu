"""Week 1 Lab

Task 1a. read in a knapsack problem from a formatted text file.
"""


class Sack(object):
    """A sack containing items, has certain capacity"""

    def __init__(self, num=0, capacity=0, items=None):
        self.__num = int(num)
        self.__capacity = int(capacity)
        if items is None:
            self.__items = []
        else:
            self.__items = items

    def get_capacity(self):
        return self.__capacity

    def set_capacity(self, capacity):
        self.__capacity = int(capacity)

    def get_num(self):
        return self.__num

    def set_num(self, num):
        self.__num = int(num)

    def pour(self):
        return self.__items

    def push(self, item):
        self.__items.append(item)


class Item(object):
    """An item in a pack, characterized by name, weight and value."""

    def __init__(self, *args):
        self.name = args[0]
        self.value = int(args[1])
        self.weight = int(args[2])


def readsack(problem):
    """Read a knapsack problem from a text file."""

    sack = Sack()

    with open(problem, 'r') as reader:
        sack.set_num(reader.readline().rstrip())
        for line in reader:
            try:
                attributes = line.split()
                sack.push(Item(*attributes))
            except:
                sack.set_capacity(attributes[0])

    return sack
