import sys

bl = open(sys.argv[1])
br = open(sys.argv[2])
li = open(sys.argv[3])
pr = open(sys.argv[4])

bl_l = []
br_l = []
li_l = []
pr_l = []

for line in bl:
    bl_l.append(line)
for line in br:
    br_l.append(line)
for line in li:
    li_l.append(line)
for line in pr:
    pr_l.append(line)

bl_s = set()
br_s = set()
li_s = set()
pr_s = set()

for i in range(0, len(bl_l)):
    bl_s.add(bl_l[i])
for i in range(0, len(br_l)):
    br_s.add(br_l[i])
for i in range(0, len(li_l)):
    li_s.add(li_l[i])
for i in range(0, len(pr_l)):
    pr_s.add(pr_l[i])

cons_novel_paths = set.intersection(bl_s, br_s, li_s, pr_s)

for e in cons_novel_paths:
    print(e)