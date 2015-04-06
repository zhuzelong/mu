"""Prepare for the COMP6342 course unit.

Read a set of attributes from a text file
and create an arrary of objects.
"""

import sys


class Item(object):
    """An item with four attribute"""

    def __init__(self, *args):
        self.size = int(args[0])
        self.weight = float(args[1])
        self.color = args[2]
        self.material = args[3]


items = list()
with open(sys.argv[1], 'r') as fh:
    for line in fh:
        values = line.rstrip()
        print values, type(values)
        val_list = values.split(' ')
        print val_list
        items.append(Item(*val_list))


# Prompt the user to specify a sort key.
# Sort the list of objects based on the sort key.
sort_key = raw_input('Please enter the sort key: size or weight\n')
print sort_key
if sort_key.lower() == 'size':
    items.sort(key=lambda item: item.size)
if sort_key.lower() == 'weight':
    items.sort(key=lambda item: item.weight)
else:
    print 'Invalid sort key, please verify it.'


# Test the content of sorted list.
for element in items:
    print type(element)
    print element.size, element.weight, element.color, element.material
