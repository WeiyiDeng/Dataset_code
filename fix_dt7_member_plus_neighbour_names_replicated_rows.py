import csv

d = open('/Python34/dt7_member_plus_neighbour_names.csv','r',encoding="utf-8")
f = open('/Python34/dt7_member_plus_neighbour_names_fix_replicates.csv', "w")
mydoc = csv.writer(f, lineterminator='\n')
try:
    r = csv.reader(d)
    line_new = next(r)              # read first line
    # print(line_new)
    # line_old = line_new
    while line_new != '':           # w: the while is of no use here, using except to help solve last line problem !
        line_old = line_new
        line_new = next(r)
        if line_old[0]==line_new[0] and line_old[1]==line_new[1] and line_old[2]==line_new[2]:
            pass    
        else:
            mydoc.writerow(line_old)
    # for row in r:
        # print(row)
except:
    mydoc.writerow(line_old)
finally:
    f.close()
    d.close()
