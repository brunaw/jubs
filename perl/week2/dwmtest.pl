#!/usr/bin/perl

use CGI;

my $q = CGI->new;

print $q->header();
print $q->start_html('hello world (title)');
print $q->h1('hello world');
print $q->start_form(-method=>"POST");
print $q->textfield(-name=>'mytextbox',
			   -default=>'starting value',
			   -override=>1,
			   -size=>50,
			   -maxlength=>80);
print $q->end_form();
$val = $q->param('mytextbox');
if ($val) {
	print "Mytextbox was set and has value $val";
	$val =~ tr/a-z/A-Z/;
	print "In upper case that is $val.";
}
print $q->end_html;


