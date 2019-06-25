#!/usr/bin/perl

print "@ARGV\n";

while (<>) {
	$count++;
	@words = split;
	$words += scalar(@words);
	foreach (@words) {
		$uses{$_}++;
	}
}
print "The file had $count lines\n";
print "The file had $words words\n";
foreach (sort {$uses{$b} <=> $uses{$a} } keys %uses) {
	print "\t$_\t$uses{$_}\n"
}

