"""Week 5 Lab 4

Read an instance of 3-SAT problem.
"""


import sys
import math


CLAUSES = []


class SAT(object):
    """An instance of 3-SAT problem."""

    def __init__(self, nvar=0, nclause=0, clauses=None):
        """nvar: the number of variables
           nclause: the number of clauses
           var: variables, represented by integers
           clauses: 3-literal clauses
        """

        self.nvar = nvar
        self.nclause = nclause

        if self.nvar <= 0:
            print 'Invalid length of variables.'
            return
        else:
            # The element i represent the variable i
            # The first element (var[0]) is not used
            self.var = [0] * (nvar + 1)

        if clauses is None:
            self.clauses = []
        else:
            self.clauses = clauses

    def add_clause(self, clause=None):
        """Append a clause to the clause list."""

        if clause is None:
            print 'No clause provided, please check the input.'
            return
        elif len(clause) != 3:
            print 'There should be exactly 3 literals in the clause.'
            return
        else:
            cl = [int(lit) for lit in clause]
            self.clauses.append(tuple(cl))


def read(path):
    """Read an instance of 3-SAT problem."""

    with open(path, 'r') as reader:
        for line in reader:
            content = line.split()
            if content[0] == 'c':
                continue
            elif content[0] == 'p':
                sat = SAT(int(content[2]), int(content[3]))
            else:
                sat.add_clause(content[:-1])    # skip the last 0

    return sat


def evaluate(solution):
    """Evaluate the number of satisfiable clauses and the number of
       true variables.

       params:
       solution: a list of variables, 1 = True, -1 = False
    """

    # Evaluate the variables
    valv = sum([i for i in solution if i == 1])

    valc = 0

    # Evaluate the clause
    for clause in CLAUSES:
        for lit in clause:
            if lit < 0:
                literal = -solution[abs(lit)-1]
            else:
                literal = solution[abs(lit)-1]

            if literal == 1:
                valc += 1
                break
        print clause, valc

    return (valc, valv)


if __name__ == '__main__':
    SATT = read(sys.argv[1])
    print 'nvar...{0}, nclause...{1}'.format(SATT.nvar, SATT.nclause)
    CLAUSES = SATT.clauses
    print 'length of clauses...', len(CLAUSES)
    # for CLAUSE in CLAUSES:
        # print CLAUSE

    with open(sys.argv[2], 'r') as fh:
        LINE = fh.read()
        SOL = LINE.split()
        SOLUTION = [int(j) for j in SOL]
        VC, VV = evaluate(SOLUTION)
        print VC, VV
