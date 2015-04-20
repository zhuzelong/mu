"""Week 3 Lab Task 2

Read the probability table of darts game from a csv file.
"""


import csv
import sys


def read(path):
    """Read csv file, store the probabilities in a table."""

    probs = dict()      # record probabilities
    points = dict()     # record all possible points of one shot

    with open(path, 'r') as handler:
        reader = csv.DictReader(handler)
        for row in reader:
            probs[row['aim']] = (float(row['hit']),
                                 float(row['bias']),
                                 float(row['miss']))
            points[row['aim']] = build_point(row['aim'])

    return (probs, points)


def build_point(aim):
    """Calculate all possible points of a certain aim."""

    low = 1
    high = 20
    bullseye = 50
    outer_bullseye = 25

    if 'single' in aim.lower():
        points = [i for i in xrange(low, high + 1)]
        points.append(outer_bullseye)
    elif 'double20' in aim.lower():
        points = [high, high * 2]
    elif 'bullseye' in aim.lower():
        points = [outer_bullseye, bullseye]
    elif 'double' in aim.lower():
        points = [i for i in xrange(low, high)]
        points.extend([i*2 for i in points])
        points = sorted(set(points))
    elif 'treble' in aim.lower():
        points = [i for i in xrange(low, high + 1)]
        points.extend([i*3 for i in points])
        points = sorted(set(points))
    else:
        print 'Invalid aims, please check your CSV file.'

    return points


if __name__ == '__main__':
    # Test
    prob, point = read(sys.argv[1])
    print prob
    print point
