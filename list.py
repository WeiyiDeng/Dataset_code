
# Hello World program in Python
    
mylist = []
mylist.append(1)
mylist.append(2)
mylist.append(3)
print(mylist[0]) # prints 1
print(mylist[1]) # prints 2
print(mylist[2]) # prints 3

# prints out 1,2,3
for x in mylist:
    print x

sampleList = [1,2,3,4,5,6,7,8]
print (sampleList[1])

Mylist = [1,2,3,4,5]
for a in Mylist:
    print a

Mylist.append(5)               # add 5 to the list
print Mylist                   # one value at a time

Mylist = [1,2,3,4,5]
for a in range(6,10):
    Mylist.append(a)
print Mylist

# other dot commands
"""
.count('x') - counts the number of occurrences of 'x' in the list
.index('x') - returns the index of 'x' in the list
.insert('y','x') - inserts 'x' at location 'y'
.pop() - returns last element then removes it from the list
.remove('x') - finds and removes first 'x' from list
.reverse() - reverses the elements in the list
.sort() - sorts the list alphabetically in ascending order, or numerical in ascending order
"""

