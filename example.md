# Exit.

Exits the shell.

### Usage:
exit status, where status is an integer used to exit the shell.

### Notes:
- handle arguments for the built-in exit


### Expected return:
- Void.

### Expected output:
- None (The shell exits).


### Example:

```
thomas@ubuntuhpEnvy:~/shell$ ./shell_0.4.1
$ exit 98
thomas@ubuntuhpEnvy:~/shell$ echo $?
98
thomas@ubuntuhpEnvy:~/shell$ 
```

### In this case, simple shell should be:
- Without arguments should be succes.
- With arguments should be succes.

### In this case, bin/sh should be:
- Without arguments should be succes.
- With arguments should fails.


