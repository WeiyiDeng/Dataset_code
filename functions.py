"""
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
"""    

# if syntax
a = 20
if a >= 22:
    print("if")
elif a >= 21:
    print("elif")
else:
    print("else")
    
def greater_less_equal_5(ans):
    if ans > 5:
        return 1
    elif ans < 5:          
        return -1
    else:
        return 0
        
print greater_less_equal_5(4)
print greater_less_equal_5(5)
print greater_less_equal_5(6)    

def someFunction():
    print("boo")
someFunction()    
    
def someFunction(a, b):
    c = a-b
    return(c)
print someFunction(12,451)    
    
def someFunction(a, b):
    print(a+b)
someFunction(12,451)

a = 10 
def someFunction():
     print (a)
someFunction()
    
    
    
    