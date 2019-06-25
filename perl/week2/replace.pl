#!/usr/bin/perl

while (<>) {
	tr/A-Z/a-z/; # Converts to lower case
	next unless (/qu/);
	s/qu/QU/g;
	print;
}
