"""Week 3 Lab Task 2.

Given a probability table and the remaining point, figure out the optimal
strategy to win the game (end at 0 point), find the maximal probability.
"""


import sys
import readdarts as reader


def shotprob(probs, points, gain):
    """Calculate probability.

    Given a score and a probability table, find the max probability,
    to get the score at one shot.
    """
    if not isinstance(gain, int) or gain < 0:
        print 'Invalid input, please enter a positive integer'
        return (None, None)

    if gain == 0:
        return ('Missing', 1)

    if gain > 60:
        return ('None', 0)

    # feasible aims
    aims = [key.lower() for key, val in points.items() if gain in val]

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
        if gain % 6 == 0:
            aim, prob = shotprob_aux(probs, 'single', 0,
                                     'double', 0, 'double', 1,
                                     'treble', 0, 'treble', 1)
        elif gain % 2 == 0:
            aim, prob = shotprob_aux(probs, 'single', 0,
                                     'double', 0, 'double', 1)
        elif gain % 3 == 0:
            aim, prob = shotprob_aux(probs, 'single', 0,
                                     'treble', 0, 'treble', 1)
        else:
            aim, prob = shotprob_aux(probs, 'single', 0,
                                     'double', 1, 'treble', 1)
    else:
        aim, prob = shotprob_aux(probs, 'double', 0, 'treble', 0)

    return (aim, prob)


def shotprob_check(probs, points, gain):
    """The same as shotprob(), but only used for double checking."""
    if gain < 0 or gain % 2 != 0:
        print 'Invalid gain, check the code.'
        return (None, None)

    if gain == 0:
        aim = 'Cannot win in one turn'
        return (aim, 0)

    if gain == 50:
        aim = 'bullseye'
    elif gain == 40:
        aim = 'double20'
    else:
        aim = 'double'

    return (aim, probs[aim][0])


def shotprob_aux(probs, *args):
    """Auxiliary function of shotprob().

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


def shoot(probs, points, start):
    """Calculate the maximal probability to win at start of score.

    The last shot has to be double, double20 or bullseye.
    """
    # Initialize the first row. The tuple comprises:
    # 1. aim at the current stage
    # 2. the largest probability to reach S score after the i-th shot
    # 3. the gain in the previous stage
    stat = []
    stat.append([(None, 0, 0)] * (start + 1))
    stat[0][-1] = (None, 1, 0)

    num = 3     # the number of darts available in a turn

    for i in xrange(1, num + 1):
        stat.append([])
        for j in xrange(start + 1):
            shots = []
            for k in xrange(j, start + 1):  # the current starting score
                aim, prob = shotprob(probs, points, k - j)
                shots.append((aim, stat[i - 1][k][1] * prob, k - j))
            bestshot = max(shots, key=lambda x: x[1])
            stat[i].append(bestshot)

        if stat[i][0][1] != 0 and 'double' not in stat[i][0][0] \
                and 'bullseye' not in stat[i][0][0]:
            # Re-compute the probability
            option = [x for x in xrange(0, 41) if x % 2 == 0] + [50]
            reshots = []
            for k in option:
                if k > start:
                    break
                aim, prob = shotprob_check(probs, points, k)
                reshots.append((aim, stat[i - 1][k][1] * prob, k))

            # Update the stat table
            stat[i][0] = max(reshots, key=lambda x: x[1])

        # Re-check after re-computation
        if stat[i][0][1] != 0:
            return stat

    return stat


def backtrack(stat):
    """Backtrack all the aims including points."""
    actions = []
    j = 0   # index of column

    # Find the stage of winning
    for end in xrange(len(stat) - 1, -1, -1):
        if stat[end][0][1] != 0:
            break
    if end == 0:    # Cannot win in a turn
        return ['Cannot win in one turn']

    for i in xrange(end, 0, -1):
        gain = stat[i][j][2]
        aim = stat[i][j][0]

        if 'single' in aim:
            point = str(gain)
        elif 'double' in aim and '20' not in aim:
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
    # START = int(raw_input('Please enter the starting point: '))
    # TAB, POINTS = reader.read(sys.argv[1])
    # STAT = shoot(TAB, POINTS, START)
    # for line in STAT:
        # print line
        # print '-'*40
    # ACTIONS = backtrack(STAT)
    # print 'The maximal probablity to win...', STAT[-1][0][1]
    # print 'Actions...\n', ACTIONS

    TAB, POINTS = reader.read(sys.argv[1])

    for start in xrange(1, 171):
        STAT = shoot(TAB, POINTS, start)
        ACTIONS = backtrack(STAT)
        print start, '&', STAT[-1][0][1], '&', ACTIONS
