"""Week 5 Lab 4

Implement simulated annealing algorithm to solve MAX-SAT-ONE problem.
"""


import random
import readsat


# The set of clauses
CLAUSES = []
# The number of variables
NVARS = 0


def evaluate(solution):
    """Evaluate the number of satisfiable clauses and the number of
       true variables.

       params:
       solution: a list of variables, 1 = True, -1 = False
    """

    # Evaluate the variables
    valv = sum([i for i in solution if i == 1])

    # Evaluate the clause
    valc = 0
    for clause in CLAUSES:
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

    # Initialize the random function
    if seed is None:
        print 'Please enter a seed for random function.'
        return
    random.seed(seed)

    # Read the number of variables to determine the length of solution
    nvar = NVARS

    # Initialize a solution
    solution_init = [random.randint(0, 1) for r in xrange(nvar)]
    solution = [v if v == 1 else -1 for v in solution_init]

    # Evaluate the intial solution
    # valc: the number of satisfiable clauses
    # valv: the number of true variables
    valc, valv = evaluate(solution)

    for i in xrange(maxiter):
        new_solution = solution[:]
        # Mutate the solution
        new_solution = [-v for v in new_solution
                        if random.random() < 1/nvar]
        new_valc, new_valv = evaluate(new_solution)

        # Compare values of solution and new solution
        cmpres = compare((valc, valv), (new_valc, new_valv))
        
        if cmpres == 'ge':  # greater or equal
            # replace the current solution
            solution = new_solution
            valc, valv = new_valc, new_valv
            # put the values in the repository
            repo_add(valc, valv)
        elif cmpres == 'less':
            # replace the current solution at random
            if exp(
        elif cmpres == 'incmp':

        else:



def compare(values1, values2):
    """Compare two pairs of values based on dominance relation"""
