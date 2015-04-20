"""Week 3 Lab Task 2

Given a probability table and the remaining point, figure out the optimal
strategy to win the game (end at 0 point), find the maximal probability.
"""


import sys
import readdarts as reader


PROBS = []


def shotprob(probs, points, score):
    """Given a score and a probability table, find the max probability
       to get the score at one shot.
    """

    if not isinstance(score, int) or score < 0:
        print 'Invalid input, please enter a positive integer'
        return (None, None)

    if score == 0:
        return ('Missing', 1)

    if score > 60:
        return ('None', 0)

    # feasible aims
    aims = [key.lower() for key, val in points.items() if score in val]

    if len(aims) == 0:
        return ('None', 0)
    elif len(aims) == 1:
        return (aims[0], probs[aims[0]][0])
    # the following aims have multiple choice
    elif 'bullseye' in aims:
        aim, prob = shotprob_aux(probs, 'single', 0, 'bullseye', 1)
    elif 'double20' in aims:
        aim, prob = shotprob_aux(probs, 'single', 0, 'double20', 1)
    elif 'single' in aims:
        if score % 6 == 0:
            aim, prob = shotprob_aux(probs, 'single', 0,
                                     'double', 0, 'double', 1,
                                     'treble', 0, 'treble', 1)
        elif score % 2 == 0:
            aim, prob = shotprob_aux(probs, 'single', 0,
                                     'double', 0, 'double', 1)
        elif score % 3 == 0:
            aim, prob = shotprob_aux(probs, 'single', 0,
                                     'treble', 0, 'treble', 1)
        else:
            aim, prob = shotprob_aux(probs, 'single', 0,
                                     'double', 1, 'treble', 1)
    else:
        aim, prob = shotprob_aux(probs, 'double', 0, 'treble', 0)

    return (aim, prob)


def shotprob_aux(probs, *args):
    """Auxiliary function of shotprob()
       Find the max probability and the corresponding aim.
    """

    if len(args) % 2 != 0 or len(args) == 0:
        print 'Invalid arguments, check the code.'
        return (None, None)

    keys = []
    indices = []
    maxprob = None

    for arg in args:
        if isinstance(arg, str):
            keys.append(arg)
        elif isinstance(arg, int):
            indices.append(arg)
        else:
            print 'Invalid arguments, check the code.'
            return (None, None)

    for key, i in zip(keys, indices):
        if probs[key][i] > maxprob:
            maxprob = probs[key][i]
            aim = key

    return (aim, maxprob)


def shoot(probs, points, score):
    """Calculate the maximal probability to win at start of score."""

    # Initialize the first row
    PROBS.append([(None, 0) for i in xrange(score + 1)])
    PROBS[0][-1] = (None, 1)

    i = 0

    while PROBS[i][0][1] == 0:      # Not at 0 point
        i += 1
        PROBS.append([])
        for j in xrange(score + 1):
            shots = []
            for k in xrange(j, score + 1):
                aim, prob = shotprob(probs, points, k-j)
                shots.append((aim, PROBS[i-1][k][1] * prob, k-j))
            bestshot = max(shots, key=lambda x: x[1])
            PROBS[i].append(bestshot)

            if PROBS[i][0][1] != 0:
                break


def backtrack():
    """Backtrack all the aims including points."""

    actions = []
    j = 0   # index of column, also the score of previous turn

    for i in xrange(len(PROBS)-1, 0, -1):
        gain = PROBS[i][j][2]
        aim = PROBS[i][j][0]

        if 'single' in aim:
            point = str(gain)
        elif 'double' in aim:
            point = str(gain / 2)
        elif 'treble' in aim:
            point = str(gain / 3)
        else:
            point = ''

        actions.append(aim + point)
        j += gain

    actions.reverse()
    return actions


if __name__ == '__main__':
    START = int(raw_input('Please enter the starting point: '))
    TAB, POINTS = reader.read(sys.argv[1])
    shoot(TAB, POINTS, START)
    ACTIONS = backtrack()
    print 'The maximal probablity to win...', PROBS[-1][0][1]
    print 'Actions...\n', ACTIONS
