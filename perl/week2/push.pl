#!/usr/bin/perl

push @a, 1;
print "@a\n";
push @a, 2;
print "@a\n";
$x = pop @a;
print "x is $x and the array is now @a\n";

unshift @a, 1;
print "@a\n";
unshift @a, 2;
print "@a\n";
$x = shift @a;
print "x is $x and the array is now @a\n";

@a = (1..10);
@b = ("four", "five");
splice @a, 3, 2, @b;
print "@a\n";

@b = sort @a;
print "@b\n";
