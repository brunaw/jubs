#!/usr/bin/perl

use warnings;
use strict;

my($offset, $jitter);
while (<>) {
	if (/offset=([-+]?\d+.\d+)/) {
		$offset = $1;
	}
	if (/sys_jitter=([-+]?\d+.\d+)/) {
		$jitter = $1;
	}
}
print "Offset is $offset\n";
print "Jitter is $jitter\n";
