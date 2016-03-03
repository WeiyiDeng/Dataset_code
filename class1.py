class Fruit(object):
    """A class that makes various tasty fruits."""
    def __init__(self, name, color, flavor, poisonous):
        self.name = name
        self.color = color
        self.flavor = flavor
        self.poisonous = poisonous

    def description(self):
        print "I'm a %s %s and I taste %s." % (self.color, self.name, self.flavor)

    def is_edible(self):
        if not self.poisonous:
            print "Yep! I'm edible."
        else:
            print "Don't eat me! I am super poisonous."

lemon = Fruit("lemon", "yellow", "sour", False)

lemon.description()
lemon.is_edible()


#-----------------------------------------------------------------
class Animal(object):
    """Makes cute animals."""
    is_alive = True
    def __init__(self, name, age):
        self.name = name
        self.age = age

zebra = Animal("Jeffrey", 2)
giraffe = Animal("Bruce", 1)
panda = Animal("Chad", 7)

print zebra.name, zebra.age, zebra.is_alive
print giraffe.name, giraffe.age, giraffe.is_alive
print panda.name, panda.age, panda.is_alive

#--------------------------------------------
class Animal(object):
    """A class that makes various tasty fruits."""
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def description(self):
        print self.name
        print self.age

hippo = Animal("lemon", 5)

hippo.description()
#lemon.is_edible()

# interactive introduction to programming in Python course videos and materials
# https://www.reddit.com/r/learnpython/comments/2pohbv/about_courseras_introduction_to_interactive/
# http://www.douban.com/note/273894010/