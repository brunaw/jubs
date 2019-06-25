#!/usr/bin/perl

$x = "Hello";
$y = "$x World\n"; # Interpolated strings
print "$y";

$y = '$x World\n'; # Literal strings
print "$y";

$y = `ls`; # Backticks - runs a program.
print "$y";

$ifconfig = `ifconfig en0`;
if ($ifconfig =~ /inet ([0-9.]*) /) {
	print "The IP address was $1\n";
}

print <<EOF;
My summer holidays - on the first day of my
summer holidays I went to the beach... I wrote
a program using $x
EOF

print <<'EOF';
My summer holidays - on the first day of my
summer holidays I went to the beach... I wrote
a program using $x
EOF

$x = <<EOF;
Hello world!
EOF

