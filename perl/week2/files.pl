#!/usr/bin/perl

open (PROFILE, "<", "hello.pl") || die "Couldn't open file"; # Reading
open (OUTPUT, ">", "copy.pl") || die "Couldn't open file"; # Writing
while ($line = <PROFILE>) {
	print OUTPUT "$line";
}
close(OUTPUT);
close(PROFILE);

