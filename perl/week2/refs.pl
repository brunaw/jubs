#!/usr/bin/perl

$x = "Hello";
$y = \$x;
print "x is $x\n";
print "y is $y\n";

${$y} = 3; # ${$y} is the thing that $y references, which is $x
print "x is $x\n";
print "y is $y\n";

@a = (1, 2, 3);
$y = \@a;
print "a is @a\n";
@{$y} = (1..10);
print "a is @a\n";
${$y}[3] = "hello";
print "a is @a\n";

$y->[3] = "Goodbye";
print "a is @a\n";

splice @{$y}, 3, 2, qw(a b c);
print "a is @a\n";


