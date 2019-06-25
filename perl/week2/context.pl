#!/usr/bin/perl

@array = ( 1 .. 3);
@answer = @array; # List context 
$answer = @array; # Scalar context
print "@answer\n";
print "$answer\n";

@a = (@answer, @array); # Both in list context
print "@a\n";
@b = (scalar(@answer), scalar(@array)); # scalar( ) forces a scalar context
print "@b\n";


foreach $x ( 2, "3", 3.2, "six", "3way", 3.8, -4.2, -4.6 ) {
	$xint = int($x);
	print "x was $x and int($x) was $xint\n";
}

