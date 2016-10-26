# Hello World program in Python
    
myList = [1,2,3]
myList.append(4)
print (myList)

myTuple = (1,2,3)
print (myTuple)

"""
myTuple2 = (1,2,3)
myTuple2.append(4)
print (myTuple2)       # cannot add values to tuple !!
"""
# change the tuple into a list to add value
myTuple = (1,2,3)
myList = list(myTuple)
myList.append(4)
print (myList)