# Task 1a: check the result

setwd('~/Documents/code/mu/comp60342/result/')
library('data.table')

alloc = fread(input='./rs_alloc.txt', sep='\t', header=T)
viol = fread('./rs_viol.txt', sep='\t', header=T)
proj = fread('../ea/Project-Participants.txt', sep=' ', header=T)
select = fread('../ea/Project-Choices.txt', sep=' ', header=T)

# Set keys of data tables
setkey(alloc, STUDENT)
setkey(viol, PRJ_ID)
setkey(proj, ID)
setkey(select, STUDENT_ID, PROJECT_ID)

# Check the number of violation
# Assert: 37
viol[, sum(N_ALLOC-MAX)]

# Check the number of rank choices
alloc[, .N, by=CHOICE]

# Check the original choices against allocation
cross.alloc = select[alloc]
res = subset(cross.alloc, PROJECT_ID==PRJ_ID)
# Print all rows
print(res, nrow=157)