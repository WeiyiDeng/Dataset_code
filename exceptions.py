# Hello World program in Python

# deal with exception
var1 = '1' 
try:
 var1 = var1 + 1 # since var1 is a string, it cannot be added to the number 1
except:
 print(var1, " is not a number") #so we execute this
print(var1)

# fix the error
var1 = '1'
try:
 var2 = var1 + 1 # since var1 is a string, it cannot be added to the number 1
except:
 var2 = int(var1) + 1
print(var2)