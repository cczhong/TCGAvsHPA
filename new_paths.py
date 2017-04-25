import sys
import csv


bx_list = []
pn_list = []
un_list = []

bioX = open(sys.argv[1])
pn = open(sys.argv[2])
un = open(sys.argv[3])

for line in bioX:
    bx_list.append(line)
    
for line in pn:
    pn_list.append(line)
    
for line in un:
    un_list.append(line)

bioX.close()
pn.close()
un.close()    

bx_set = set()
pn_set = set()
un_set = set()

for i in range(0, len(bx_list)):
    bx_set.add(bx_list[i])
for i in range(0, len(pn_list)):
    pn_set.add(pn_list[i])
for i in range(0, len(un_list)):
    un_set.add(un_list[i])
    


newPaths = un_set - (bx_set | pn_set)

of = open("blca_new_paths.txt", 'w+')

for m in newPaths:
    of.write(m)
    of.write('\n')
    
of.close()

