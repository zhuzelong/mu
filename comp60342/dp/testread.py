import sys
import readhospital

infile = sys.argv[1]

budget, items = readhospital.read(infile)

print 'Budget...', budget

for item in items:
    print 'Name...', item.name
    print 'Cost...', item.cost, type(item.cost)
    print 'Effect...', item.effect
