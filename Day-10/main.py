srp = []


class Student():
    def __init__(self, name, course, year, section):
        self.name = name
        self.course = course
        self.year = year
        self.section = section

while True:
    n = input('Please Enter your Name: ')
    c = input('Program: ')
    y = input('Year: ')
    s = input('Section: ')
    # calling the class
    stu_data = Student(n,c,y,s) 
    # store the stu_data to the list
    srp.append(stu_data)

    ngi = input('\n Create another student? [Y/Any char]').lower()
    if ngi != 'y':
        break
    

print(srp)


# srr= dict
# srr = {'ken': ['ngi', 123, 'pangit'], 'jom': 'pangit'}
# print(srr)

# dir(dict)