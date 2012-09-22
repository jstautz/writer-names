writer-names.el -- A random name generator
==========================================

Generate random names from the 1990 US Census lists. Useful for fiction writers, playwrights, screenwriters, etc.

Written by Bob Newell and
[released to the public domain in April 2012](http://lists.gnu.org/archive/html/gnu-emacs-sources/2012-04/msg00003.html).

Name list files provided by the US Census Bureau and [obtained here](http://www.census.gov/genealogy/names/names_files.html).

Usage
=====

1. Modify the ```writer-male-names```, ```writer-female-names```, and ```writer-last-names``` vars to point to the locations of the census
lists on your system.
2. Evaluate writer.el.
3. ```M-x writer-random-name``` will generate one completely random male name and one completely random female name,
then will write both to minibuffer and append to end of buffer **\*Random Names\***.


Disclaimer & Notes
==================

This ain't my code. I take no responibility for it, I make no claims as to its quality, and if it decides to eat your
children I will stand idly by and watch it do so.

Pretty sure it won't eat your kids, though.

Here are Bob Newell's notes on writer-names.el:  
*Many creative writing programs have a random name generator, and many of
these can be found online. This made me jealous; I'm current developing
writer-mode, a suite of elisp tools for writers, and I wanted something
similar. So I made one and here is the first attempt; it's obviously
just a start, but it works.*
