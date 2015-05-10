"""Automated run sasat.py"""

import sasat as sa

instance1 = '../data/dubois20.cnf'
instance2 = '../data/aim-100-1.cnf'
instance3 = '../data/aim-200-3.cnf'

with open('seeds.txt', 'r') as reader:
    seeds = []
    for line in reader:
        seeds.append(int(line))


with open('../result/runsat3.dat', 'w') as fh:
    tstart = float(raw_input('Tstart for instance: '))
    tend = float(raw_input('Tend for instance: '))
    stop = int(raw_input('Stop cooling for instance: '))
    for seed in seeds:
        front = sa.runsa(instance3, seed, tstart, tend, stop)
        for point in front:
            fh.write('-{0} -{1}\n'.format(point[0], point[1]))
        fh.write('\n\n')
