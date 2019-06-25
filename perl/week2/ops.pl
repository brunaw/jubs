#!/usr/bin/perl

$x = 2;
$y = 6.1;
$a = $x + $y;
$b = $x - $y;
$c = $x * $y;
$d = $x / $y; # Does it as floating point if answer is not a whole number
$e = $x ** $y; # Power!
print "$x ** $y is $e\n";
$f = $x % $y; # Remainder
print "$x mod $y is $f\n"; # Works as integers!

# Bitwise operators work on integers & | ^ 

$g = $x x $y; # Gives me six copies of the string $x;
$h = $x . $y;
print "$g $h\n";

if ($g >= 6) {
	print "$g is bigger or equal to six\n";
}

# > >= < <= != == <=> all for numbers
# To compare as strings
# gt ge lt le ne eq cmp all for strings (using lexicographic order)

if ("a" lt "b") {
	print "a comes before b\n";
}

$string1 = "a";
$string2 = "b";

if ($string1 lt $string2) {
	print "a comes before b\n";
}

if ("0" lt "z") {
	print "0 comes before z\n";
}

if ("aardvark" lt "apple") {
	print "aardvark comes before apple\n";
}

#
# Assignment operators
print "$x\n";
$x += 4; # Takes $x and add 4 to it.
print "$x\n";

$x++; # Adds 1 to $x
$x--; # Subtracts 1 from $x

$string = "ABC";
print "$string\n";
$string++;
print "$string\n";

$file = "hello.pl";
if (-e $file) {
	print "$file exists\n";
}
if (-f $file) {
	print "$file is a file\n";
}
if (-d $file) {
	print "$file is a directory\n";
}
if (!-z $file) {
	print "$file has size bigger than zero\n";
}
$size = -s $file;
print "The size is $size\n";

@array = (1 .. 100);
print "The big array is @array\n";



