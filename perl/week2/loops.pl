#!/usr/bin/perl

for ($i = 0; $i < 10; $i++) {
	print "$i ";
}
print "\n";

$i = 0;
while ($i < 10) {
	print "$i ";
	$i++;
}
print "\n";

$x = 4 + 3;
if ($x > 5) {
	print "x is greater than 5\n";
} elsif ($x < 4) {
	print "x is less than 4\n";
} else {
	print "x is between 4 and 5\n";
}

unless ($x < 4) { # Tries once, moves on. Opposite of if()
	print "x is not less than 4\n";
}

# And foreach

$a = 4;
$b = 6;
$c = $b / $a unless ($a == 0);
$c = $b / $a if ($a != 0);

#
# Shortcut operators
#
$file = "/etc/ssh/ssh_host_ecdsa_key";
-r $file || print "The file is not readable\n";
-r $file && print "The file is readable\n";


