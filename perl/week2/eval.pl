#!/usr/bin/perl

$x = 7;
eval '$x = 4;';
print "$x\n";

$_ = <>;
eval $_;
mysub(3);

