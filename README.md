# No .DS_Store
Small utility for removing all the .DS_Store files from MS-DOS drives :)

## Why this tool?
I'm using DOSBox under macOS, and my mapped drives under DOSBox are full of those files. This utility performs a safe scan on the specified drive and then lists all .DS_Store files found. Run it again with the -f parameter to force removal of those annoying files from your drive.

## Usage
```nods <drive:> [-f]```
Whereas:
```
  drive: - the disk drive you want to scan for .DS_Store
  -f     - force removal of the found files. 
```  
Example:
```
  nods d:      # scan for all .DS_Store on the disk D: but not remove them
  nods d: -f   # same as previous command but actually remove the found .DS_Store files.
```
