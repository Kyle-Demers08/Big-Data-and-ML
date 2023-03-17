### Q1

seq(50,100) # sequence 50 to 100
mean(seq(100,150)) # sequence 100 to 150
mean(seq(1,10)) # mean of sequence 1 to 10
My_vec = c(10,20,12,30,40,50,33,29,9,100) #vector of 10 numbers
min(My_vec) # minimum of variable "my_vec"
max(My_vec) # minimum of variable "my_vec"

### Q2

salaries = c(150000, 76000, 353000, 54000, 86000) 
sort(salaries, decreasing = T) #sort vector decreasing parameter as T

### Q3

#create hotels names and price in a list
hotels = list(Name = c("DoubleTree Hotel by Williamsburg", 
                       'Club Wyndham Kingsgate', 
                       'Woodlands Hotel & Suites - A Colonial williamsburg hotel'),
              Price = c(135,
                        110,
                        164))

hotels

### Q4

months = c("December", 'September', 'April', 'May',
           'July', 'January', 'August', 'November',
           'September', 'December', 'February', 'August', 
           'January', 'May', 'August', 'July') #create list
factor(months, ordered = T) #factor and order

### Q5

mylist = list(StudentsCodes = 1:10, Course1 = "Machine Learning",
     Course2 = 'Prescriptive', Course3 = 'Database') #create list

length(mylist$StudentsCodes) + length(mylist$Course1) #length of first 2 vectors
length(mylist$StudentsCodes) #length of the 1st vector
length(mylist$Course2) # length of the 3rd vector