#!/usr/bin/perl

use Scrappy;
my $spidy = Scrappy->new;

$spidy->crawl('http://search.cpan.org/recent', {
        '#cpansearch li a' => sub {
            print shift->text, "\n";
        }
});
