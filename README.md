# Getting_and_Cleaning_Data
# 
# The include "R" file is a single script that combines the various data elements, largely relying on the use of the
# dplyr package. The flow of the script is as follows: 1) read the associated files into memory, 2)assemble the various data
# elements into a single tidy data file, 3)the function labelSub is utilized to relabel the "Activities" variable into a 
# more readable format, 4)and lastly, the variables are grouped using the "group_by" dplyr function on the basis of "Subjects"
# and "Activities".
