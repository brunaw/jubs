#!/usr/bin/perl

while (<>) {
	print if (/^w.*f[aeiou][st]+.*ly$/);
	if (/^(Mon|Tues|Wednes|Thurs|Fri)day$/) {
		print "I matched $1 with a day after it\n";
	}
}
