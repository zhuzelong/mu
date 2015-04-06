load datab;
model=svm('-t 1 -d 2 -c 100')
model=model.train(data, labels)
res=model.test(data, labels).err()
