This tool removes all files and directories made before or at a specified date.

Format: ./delete\_by [file/directory] [date]

Option:

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
