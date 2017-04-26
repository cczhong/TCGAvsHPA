import sys
import csv

bx_data = list(csv.reader(open(sys.argv[1]), delimiter= '\t' ))
pn_data = list(csv.reader(open(sys.argv[2]), delimiter= '\t' ))
un_data = list(csv.reader(open(sys.argv[3]), delimiter= '\t' ))

bx_GO = set()
pn_GO = set()
un_GO = set()

for i in range(0, len(bx_data)):
    bx_GO.add(bx_data[i][2])
for i in range(0, len(pn_data)):
    pn_GO.add(pn_data[i][2])
for i in range(0, len(un_data)):
    un_GO.add(un_data[i][2])

new_GO = un_GO - (bx_GO | pn_GO)

out = open('prad_newPC.txt', 'w+')

for e in new_GO:
    out.write(e)
    out.write('\n')
out.close()    