This script simply goes through one directory (source) and sequentially copies files to another place. This is designed to be for copying to a FAT filesystem device like SD cards. 

I made it because just copying in GUI or rsync would sometimes copy them in different orders, and very simple devices such as cheap DAPs as I have, or some car audio systems, seem to take the write order in preference over filenames or tasks!

There are better (as in more powerful and flexible) versions of this concept using the [fatsort](https://fatsort.sourceforge.io/) and similar tool.