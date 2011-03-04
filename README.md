# v

z for vim

### SYNOPSIS

    v [-l] [ options for vim ] <regex>

### DESCRIPTION

**v** uses viminfo's list of recently edited files to open one quickly 
no matter where you are in the filesystem.

By default, it will open the most recently edited file matching the 
provided regular expression.

### OPTIONS

    -l, --list      when multiple matches, show a list
    -h, --help      show a brief help message

### NOTES

*Additional vim options* are determined as options starting with - or +, 
appear before --, and aren't -l, --list, -h or --help.

The regex is passed directly to grep.

Original v script by [ruba](https://github.com/rupa/v). Rewritten purely 
as a matter of preference.
