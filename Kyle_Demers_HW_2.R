### Question 1
#Vector of student names
student_names = c('Sydney', 'Jacob', 'Isabelle')
student_names
#Matrix of grades
grades = matrix(c(85,85,95,100,94,82),2,3)
grades
hw_1 = c(85,85,95)
hw_2 = c(100,94,82)
#list of majors
Majors = list(c('Analytics', 'Databases', 'Computer Science'))
Majors
#combine into list
list_student_data = list(student_names,grades,Majors)
#a) display the contents like fig 1
print(list_student_data)
#b) display the grades
list_student_data[2] #index list at idx2

### Question 2 
#a)
dfclip = read.table(file='clipboard', header=TRUE, sep = '\t',stringsAsFactors=TRUE)
View(dfclip)

### Question 3

#set up features
orderdate = c('9/1/21', '9/18/21', '10/5/21', '10/22/21', '3/7/22', '4/27/22')
Region = c('Central', 'East', 'Central', 'East', 'West', 'East')
Rep = c('Smith','Jones','Morgan','Jones','Sorvino','Howard')
Item = c('Desk','Pen Set', 'Binder','Pen','Binder','Pen')
Units = c(2,16,28,64,7,96)
unit_cost = c(125.00,15.99,8.99,8.99,19.99,4.99)
Total = c(250.00,255.84,251.72,575.36,139.92,479.04)
df1 = data.frame(orderdate, Region, Rep, Item, Units, unit_cost, Total)
View(df1)
#b
df1[5,3]
df1[5,7]
#c
df1$Region
df1$Total      
#d
str(df1)
#e
max(df1$Total)
#f
min(df1$Total)

## Q4
#a & b
months = c("December", 'September', 'April', 'May',
           'July', 'January', 'August', 'November',
           'September', 'December', 'February', 'August', 
           'January', 'May', 'August', 'July') #create list
#c
months = factor(months, ordered = T)
months
#d
str(months)

#e
#create a vector of all months
check_for = c('January','February','March','April','May','June','July','August','September','October','November','December')
not_included = c() # create an empty vector
for(i in check_for){
  if(i %in% months){ #check to see if its in months
    next #next iteration
  }else{ #if it isn't then...
    not_included = append(not_included,i)} # append to list
}
print(not_included)

#Easy way
setdiff(check_for,months)
## Q5

name = readline(prompt="What is your name? ")
major = readline(prompt = 'What is your major?')
cat('Hello ', name, "!", '\n' , 'I heard', major, # use cat for a line break
    'Is a great major. Congradulations!')
