#!/usr/bin/perl

$z = add_numbers(2,3,4);
print "$z\n";
@ans = sum_and_diff(4,7);
print "@ans\n";
$w = sum_and_diff(4,7);
print "$w\n";

sub add_numbers {
	my ($sum, $x);

	foreach $x (@_) {
		$sum += $x;
	}

	return $sum;
}

sub sum_and_diff {
	my ($x, $y) = @_;

	return ($x + $y, $x - $y);
}
