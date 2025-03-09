This tool removes all files and directories made before or at a specified date.  
This command is useful for deleting a large amount of files that are outdated/no longer in use.
  
Format: ./delete\_by [file/directory] [date] [arguments]  
By default, delete\_by uses the last modified date to remove files  
Date should be in the format YYYY-MM-DD  
Arguments should be together: -[ARG1][ARG2][ARG3] or [ARG1][ARG2][ARG3]  
  
Arguments:  
-f&emsp;only delete regular files  
-s&emsp;only delete files modified on the date specified  
-w&emsp;do not print out warnings  
-c&emsp;use the date created of the file to delete  
-a&emsp;use the date last accessed of the file to delete  
  
Example:  
$ ls -l  
total 12  
-rw-rw-r-- 1 christina\_hayoung christina\_hayoung  266 Mar  7 02:09 README.md  
-rwxr-xr-x 1 christina\_hayoung christina\_hayoung  801 Mar  7 02:06 remove\_by.sh  
drwxrwxr-x 2 christina\_hayoung christina\_hayoung 4096 Mar  7 02:09 test  
  
$ls -l test  
total 0  
-rw-rw-r-- 1 christina\_hayoung christina\_hayoung 0 Mar  7 02:09 sample.txt  
  
$ ./remove\_by.sh test 2025-03-07  
  
$ ls -l  
total 8  
-rw-rw-r-- 1 christina\_hayoung christina\_hayoung 618 Mar  7 02:11 README.md  
-rwxr-xr-x 1 christina\_hayoung christina\_hayoung 801 Mar  7 02:06 remove\_by.sh  
  
With -f  
$ ls  
README.md  remove\_by.sh  test  
$ ./remove\_by.sh test 2025-03-07 -f  
$ ls  
README.md  remove\_by.sh  test  
$ ls test  
  
  
With -w  
$ ./remove\_by.sh test 2024-03-07  
File test/sample.txt was modified after 2024-03-07  
File test was modified after 2024-03-07  
  
$ ./remove\_by.sh test 2024-03-07 -w  

