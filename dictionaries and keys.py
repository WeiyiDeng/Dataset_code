# Hello World program in Python

# to get the value in the dictionary, use dictionary["keyname"]    
myExample = {'someItem': 2, 'otherItem': 20}
print(myExample['otherItem'])
print myExample

# add new key to the dictionary with value 400
myExample = {'someItem': 2, 'otherItem': 20}
myExample['newItem'] = 400
print myExample
for a in myExample:
    print a

myExample = {'someItem': 2, 'otherItem': 20,'newItem':400}
for a in myExample:
    print (a, myExample[a])
for a in myExample:
    print (myExample[a])