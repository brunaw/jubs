#!/usr/bin/perl

open (MYFILE, "<", "text") || die "Couldn't open text";
while ($line = <MYFILE>) {
	$count++;
	@words = split(" ", $line);
	$words += scalar(@words);
	foreach $w (@words) {
		$uses{$w}++;
	}
}
close (MYFILE);
print "The file had $count lines\n";
print "The file had $words words\n";
foreach $w (keys %uses) {
	print "\t$w\t$uses{$w}\n"
}

