#!/bin/bash

# echo "Hello World"
# echo Our Shell Name is $BASH
# echo Our shell version name is $BASH_VERSION
# echo Our home directory is $HOME
# echo Our Current Working Directory is $PWD

# name=Ashish
# echo The name is $name

# echo "Enter Name.."
# read name
# echo "Entered Name is $name"

# read -p "Enter User Name: " username  # Read input in same line
# echo "Name is: $username"
# read -sp "Enter Password: " userpassword
# #echo "Password is $userpassword"

# echo "Enter Names : "
# read -a names # to read array
# echo "Names : ${names[0]} , ${names[1]}"

# echo "Enter Names : "
# read
# echo "Name $REPLY"

# echo $0 $1 $2 $3 ' > echo $1 $2 $3'

# args=("$@")  # store arguments as an array
# echo ${args[0]} ${args[1]} ${args[2]} ${args[3]} ${args[4]} # Print arguments as an array from index valus
# echo $@ # Print the Arguments as an array
# echo $# # Print Number Of Arguments passed to the script

# count=10
# if [ $count -eq 10 ]
# then
# echo "Hello World"
# fi

# File test operators
# echo -e "Enter the name of the file : \c" # The \c keeps the cursor on the same line after the end of the echo, but to enable it, you need the -e flag:
# read file_name
# if [ -e $file_name ]  # -e is flag for file exists or not
# then
#   echo "$file_name found"
#   else
#   echo "$file_name not found"
# fi

# echo -e "Enter the name of the file : \c" # The \c keeps the cursor on the same line after the end of the echo, but to enable it, you need the -e flag:
# read file_name
# if [ -f $file_name ]  # -f is flag for file is exists and file is regular or not
# then
#    echo "$file_name found"
#  else
#    echo "$file_name not found"
# fi

# echo -e "Enter the name of the directory : \c" # The \c keeps the cursor on the same line after the end of the echo, but to enable it, you need the -e flag:
# read file_name
# if [ -d $file_name ]  # -d is flag for directory for block files use flag -b and for character files use flag -c use flag
                        # -s if the file is empty.
# then
#    echo "$file_name found"
#  else
#    echo "$file_name not found"
# fi

# echo -e "Enter the name of the file : \c" # The \c keeps the cursor on the same line after the end of the echo, but to enable it, you need the -e flag:
# read file_name
# if [ -s $file_name ]  # -f is flag for file is exists and file is regular or not
# then
#    echo "$file_name not empty"
#  else
#    echo "$file_name empty"
# fi

# echo -e "Enter the name of the file : \c" # The \c keeps the cursor on the same line after the end of the echo, but to enable it, you need the -e flag:
# read file_name
# if [ -r $file_name ]  # -r is flag for file is exists and file has read permission
# then
#    echo "$file_name has read permission"
#  else
#    echo "$file_name do not have read permission"
# fi

# echo -e "Enter the name of the file : \c" # The \c keeps the cursor on the same line after the end of the echo, but to enable it, you need the -e flag:
# read file_name
# if [ -w $file_name ]  # -w is flag for file is exists and file has write permission
# then
#    echo "$file_name has write permission"
#  else
#    echo "$file_name do not have write permission"
# fi

# echo -e "Enter the name of the file : \c" # The \c keeps the cursor on the same line after the end of the echo, but to enable it, you need the -e flag:
# read file_name
# if [ -x $file_name ]  # -x is flag for file is exists and file has execute permission
# then
#    echo "$file_name has execute permission"
#  else
#    echo "$file_name do not have execute permission"
# fi

# echo -e "Enter the name of the file : \c" # The \c keeps the cursor on the same line after the end of the echo, but to enable it, you need the -e flag:
# read file_name
# if [ -f $file_name ]  # -f is flag for file is exists and file is regular or not
#     then
#         if [ -w $file_name ]
#         then
#         echo "Type some text data. Then Press Enter and To quit press ctrl+d"
#         cat >> $file_name
#         else
#         echo "The file do not have write permission" 
#         fi 
#     else
#         echo "$file_name not exists"
# fi

# echo -e "Enter the name of the file : \c"
# read file_name
# if [ ! -e $file_name ]
# then
#    echo "If file not exist then create a file"
#    touch $file_name
#    echo "Type some text data. Then Press Enter and To quit press ctrl+d"
#    cat >> $file_name
#  else
#    echo "$file_name exists"
# fi

