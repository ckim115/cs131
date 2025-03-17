# removeby - File Deletion Tool

This tool removes all files and directories made before or at a specified date.

This command is useful for deleting a large amount of files that are outdated/no longer in use.

## Usage
```bash
./removeby.sh [arguments] [file/directory] [date]
```
By default, removeby uses the last modified date to remove files  
Date should be in the format **YYYY-MM-DD**  
Arguments should be together: **-[ARG1][ARG2][ARG3]** or **[ARG1][ARG2][ARG3]**

### Arguments
`-f` only delete regular files  
`-s` only delete files modified on the date specified  
`-w` do not print out warning messages  
`-c` use the date created of the file to delete  
`-a` use the date last accessed of the file to delete  

## Examples
Input:
```bash
$ ls -l
$ ls -l test
$ ./removeby.sh test 2025-03-07
$ ls -l
```
Output:
```bash
total 12
-rw-rw-r-- 1 christina_hayoung christina_hayoung 266 Mar 7 02:09 README.md
-rwxr-xr-x 1 christina_hayoung christina_hayoung 801 Mar 7 02:06 removeby.sh
drwxrwxr-x 2 christina_hayoung christina_hayoung 4096 Mar 7 02:09 test

total 0
-rw-rw-r-- 1 christina_hayoung christina_hayoung 0 Mar 7 02:09 sample.txt

total 8
-rw-rw-r-- 1 christina_hayoung christina_hayoung 618 Mar 7 02:11 README.md
-rwxr-xr-x 1 christina_hayoung christina_hayoung 801 Mar 7 02:06 removeby.sh
```

Input:
```bash
$ ls
$ ./removeby.sh -f test 2025-03-07
$ ls
$ ls test
```

Output:

```bash
README.md removeby.sh test

README.md removeby.sh test


```

Input:
```bash
$ ./removeby.sh test 2024-03-07
$ ./remove_by.sh -w test 2024-03-07
```

Output:

```bash
File test/sample.txt was modified after 2024-03-07
File test was modified after 2024-03-07


```
