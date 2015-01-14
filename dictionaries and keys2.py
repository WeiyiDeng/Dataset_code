# Hello World program in Python
    
print "Hello World!\n"

# add items in dict phonebook
phonebook = {}
phonebook["John"] = 938477566
phonebook["Jack"] = 938377264
phonebook["Jill"] = 947662781

print phonebook

for a in phonebook:
   print(a)
   
for a in phonebook:
   print phonebook[a]
   
phonebook2 = {
    "John" : 938477566,
    "Jack" : 938377264,
    "Jill" : 947662781
}

for name, number in phonebook.iteritems():
    print "Phone number of %s is %d" % (name, number)
    
del phonebook["John"]
# or phonebook.pop("John")
print phonebook
