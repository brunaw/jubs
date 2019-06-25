#!/usr/opt/local/bin/perl

use LWP::UserAgent;
my $ua = LWP::UserAgent->new;
$ua->agent("MyApp/0.1 ");

$area = $ARGV[0];

# Create a request
my $req = HTTP::Request->new(GET => 'https://www.cifraclub.com.br/');

# Pass request to the user agent and get a response back
my $res = $ua->request($req);

# Check the outcome of the response
if (!$res->is_success) {
	die "Couldn't make web request succesfully";
}

#@lines = split(/\n/, $res->content);
#foreach (@lines) {
	#next unless (/^<tr>/);
	#foreach $row (split(/<\/tr>/)) {
#		($date) = ($row =~ m#(\d\d/\d\d/\d\d\d\d)#);
		#($price) = ($row =~ m#€([0-9,]+\.\d\d)#);
		#print "$date\t$price\n";
	#}
#}
