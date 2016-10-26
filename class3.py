class Customer(object):
    """Produces objects that represent customers."""
    def __init__(self, customer_id):
        self.customer_id = customer_id

    def display_cart(self):
        print "I'm a string that stands in for the contents of your shopping cart!"

class ReturningCustomer(Customer):
    """For customers of the repeat variety."""
    def display_order_history(self):
        print "I'm a string that stands in for your order history!"

someone = ReturningCustomer("ID: 12345")
someone.display_cart()
someone.display_order_history()


#--------override-------------------
class Employee(object):
    """Models real-life employees!"""
    def __init__(self, employee_name):
        self.employee_name = employee_name

    def calculate_wage(self, hours):
        self.hours = hours
        return hours * 20.00

# Add your code below!
class PartTimeEmployee(Employee):
    def calculate_wage(self, hours):
        self.hours = hours
        return hours * 12
        
worker1 = PartTimeEmployee("John")
print worker1.calculate_wage(50)

#-----------super call----------------

class Employee(object):
    """Models real-life employees!"""
    def __init__(self, employee_name):
        self.employee_name = employee_name

    def calculate_wage(self, hours):
        self.hours = hours
        return hours * 20.00

# Add your code below!
class PartTimeEmployee(Employee):
    def calculate_wage(self, hours):
        self.hours = hours
        return hours * 12
        
    def full_time_wage(self,hours):
        return super(PartTimeEmployee, self).calculate_wage(hours)
        
milton = PartTimeEmployee("Milhouse")
print milton.full_time_wage(10)

#------------------practice--------------------
class Triangle(object):
    number_of_sides = 3
    def __init__(self, angle1, angle2, angle3):
        self.angle1 = angle1
        self.angle2 = angle2
        self.angle3 = angle3
    
    def check_angles(self):
        if self.angle1 + self.angle2 + self.angle3 ==180:
            return True
        else:
            return False
            
my_triangle = Triangle(30,60,90)
print my_triangle.number_of_sides                  # to print variables no need to include ()
print my_triangle.check_angles()                   # to print function/method results need () in dot notation

class Equilateral(Triangle):
    angle = 60
    def __init__(self):
        self.angle1 = self.angle
        self.angle2 = self.angle
        self.angle3 = self.angle
		
		
#----------------------exercise 2-------------------------
class Car(object):
    condition = "new"
    def __init__(self, model, color, mpg):
        self.model = model
        self.color = color
        self.mpg   = mpg
    def display_car(self):
        print "This is a %s %s with %s MPG." %(self.color, self.model, str(self.mpg))
        #"This is a " + self.color + " " + self.model + " with " + str(self.mpg) + " MPG."
	def drive_car(self):
        self.condition = "used"
my_car = Car("DeLorean", "silver", 88)
print my_car.display_car()
print my_car.condition
my_car.drive_car()
print my_car.condition

#-----------------------exercise final---------------------
class Car(object):
    condition = "new"
    def __init__(self, model, color, mpg):
        self.model = model
        self.color = color
        self.mpg   = mpg

    def drive_car(self):
        self.condition = "used"
        
    def display_car(self):
        print "This is a %s %s with %s MPG." %(self.color, self.model, str(self.mpg))
        #"This is a " + self.color + " " + self.model + " with " + str(self.mpg) + " MPG."
        
class ElectricCar(Car):
    def __init__(self, model, color, mpg, battery_type):
        self.battery_type = battery_type
        self.model = model
        self.color = color
        self.mpg   = mpg
    def drive_car(self):
        self.condition = "like new"
    
my_car = ElectricCar("DeLorean", "silver", 88, "molten salt")
print my_car.condition
my_car.drive_car()
print my_car.condition

#------------------------use repr to transfer data format----------------------------
class Point3D(object):
    def __init__(self, x, y, z):
        self.x = x
        self.y = y
        self.z = z
    def __repr__(self):
        return "(%d, %d, %d)" % (self.x, self.y, self.z)
        
my_point = Point3D(1,2,3)
print my_point