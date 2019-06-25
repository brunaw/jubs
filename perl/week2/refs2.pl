#!/usr/bin/perl

$a = ["Hello", "Goodbye"]; # A reference to an anonymous array with two elements
$b = { "one" => 1, "two" => 2 };

%props = (
	"pockets" => ["keys", "cards", "memory stick" ],
	"bag" => ["paper", "books" ],
	);

foreach (keys %props) {
	print "In my $_ I have: \n";
	foreach $thing ( @{$props{$_}} ) {
		print "\t$thing\n";
	}
}

push @{$props{"purse"}}, "cash";
push @{$props{"purse"}}, "ID card";


foreach (keys %props) {
	print "In my $_ I have: \n";
	foreach $thing ( @{$props{$_}} ) {
		print "\t$thing\n";
	}
}

