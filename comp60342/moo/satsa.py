"""Week 5 Lab 4

Implement simulated annealing algorithm to solve MAX-SAT-ONE problem.
"""


import sys
import random
import math
import readsat


clauses = []    # The set of clauses
nvars = 0       # The number of variables
nclauses = 0    # The number of clauses
front = []      # Pareto front
FRONTCAP = 100  # The max capacity of front
weight1 = 0     # The weight of objective 1
weight2 = 0     # The weight of objective 2


def evaluate(solution):
    """Evaluate the number of satisfiable clauses and the number of
       true variables.

       params:
       solution: a list of variables, 1 = True, -1 = False
    """

    global clauses
    # Evaluate the variables
    valv = sum([i for i in solution if i == 1])

    # Evaluate the clause
    valc = 0
    for clause in clauses:
        for lit in clause:
            if lit < 0:
                literal = -solution[abs(lit)-1]
            else:
                literal = solution[abs(lit)-1]

            if literal == 1:
                valc += 1
                break

    return (valc, valv)


def simulate_anneal(seed=None, maxiter=0,
                    tstart=None, tend=None, stop=0):
    """Implementation of simulated annealing

       params:
            maxiter: the max number of iterations for SA
            tstart: starting temperature
            tend: ending temperature
            stop: the number of iterations for cooling temperature

       Output:
            100 lines of non-dominated Pareto front
    """

    global nvars, nclauses, weight1, weight2
    # Initialize the random function
    if seed is None:
        print 'Please enter a seed for random function.'
        return

    random.seed(seed)
    tpr = tstart    # Initialize temperature
    alpha = (tstart - tend) / stop  # Decreasing step of temperature

    # Initialize a solution
    solution_init = [random.randint(0, 1) for r in xrange(nvars)]
    solution = [v if v == 1 else -1 for v in solution_init]

    # Evaluate the intial solution
    # valc: the number of satisfiable clauses
    # valv: the number of true variables
    valc, valv = evaluate(solution)

    for i in xrange(maxiter):
        new_solution = solution[:]
        # Mutate the solution
        new_solution = [-v if random.random() < 1.0/nvars else v
                        for v in solution]
        new_valc, new_valv = evaluate(new_solution)

        # Compare values of solution and new solution
        relation = compare_dominance((valc, valv), (new_valc, new_valv))

        if relation == 'dominates':
            # replace by probability
            prob = math.exp(min(weight1 * (new_valc - valc),
                                weight2 * (new_valv - valv)) / tpr)
            if prob > random.random():
                solution = new_solution
        elif relation == 'dominated':
            solution = new_solution     # replace current solution
            valc, valv = new_valc, new_valv
            front_add(new_valc, new_valv)   # put in approx front
        else:
            # replace by probablity based on 'Rule C'
            prob = min(1, math.exp(
                           max(weight1 * (valc - new_valc),
                               weight2 * (valv - new_valv)) / tpr))
            if prob > random.random():
                solution = new_solution
            front_add(new_valc, new_valv)   # put in approx front

        if i < stop:
            tpr -= alpha    # Linear cooling schedule


def compare_dominance(values1, values2):
    """Compare two pairs of values based on dominance relation."""

    diff1 = values1[0] - values2[0]     # The difference of 1st objective
    diff2 = values1[1] - values2[1]     # The difference of 2nd objective

    if diff1 * diff2 < 0:
        result = 'nondominate'  # a and b are incomaparable
    elif (diff1 > 0 and diff2 >= 0) or (diff1 == 0 and diff2 > 0):
        result = 'dominates'    # a dominates b
    else:
        result = 'dominated'    # a is dominated or equal to b

    return result


def front_add(valc, valv):
    """Determine to put a 2D point X in the Pareto front
       step1. add X to front if no points in front dominated X
       step2. remove all points dominated by X
    """

    global front, FRONTCAP, weight1, weight2, nvars, nclauses
    if len(front) == 0:
        front.append((valc, valv))
        return

    for point in front:
        relation = compare_dominance(point, (valc, valv))
        if relation == 'dominates':
            return      # point V dominates X, do not add X
        elif relation == 'dominated':
            front = filter(lambda p: p != point, front)  # delete point
        else:           # nondominated
            continue

    # X pass the test, i.e. non dominated by any points in front, add X
    front.append((valc, valv))

    if len(front) > FRONTCAP:
        values = [weight1*point[0]/nclauses + weight2*point[1]/nvars
                  for point in front]
        # Delete the point with lowest weighted objectives
        front.pop(values.index(min(values)))


if __name__ == '__main__':
    sat = readsat.read(sys.argv[1])
    clauses = sat.clauses
    nvars = sat.nvar
    nclauses = sat.nclause
    weight1 = float(raw_input('Please enter the weight of objective 1: '))
    weight2 = float(raw_input('Please enter the weight of objective 2: '))
    SEED = int(sys.argv[2])
    MAXITER = int(sys.argv[3])
    TSTART = float(sys.argv[4])
    TEND = float(sys.argv[5])
    STOP = int(sys.argv[6])

    simulate_anneal(SEED, MAXITER, TSTART, TEND, STOP)

    for point in front:
        print point
