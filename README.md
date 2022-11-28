### Cron Expression Parser

Cron is a standard Unix utility that is used to schedule commands for automatic execution at specific intervals.This command line application parses a cron string and expands each field to show the times at which the command will run.

### Running the application

Sample Command used to run the application $ruby driver.rb "*/15 0 1,15 * 1-5 /usr/bin/find"

Sample output of the application
```
minute        0 15 30 45
hour          0
day of month  1 15
month         1 2 3 4 5 6 7 8 9 10 11 12
day of week   1 2 3 4 5
command       /usr/bin/find
```

### Running test cases(optional)

$bundle exec rspec
