#!/usr/bin/perl

@a = (1..10);
@b = grep { $_ > 7 } @a;
print "@b\n";

@c = map { $_ * $_ } @a;
print "@c\n";


