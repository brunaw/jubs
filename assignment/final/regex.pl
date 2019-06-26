use constant FALSE => 1==0;
use constant TRUE => not FALSE;

# introducing the chord to do the regex
my $chord = $ARGV[0];
# calculating all 'regexes'
$min =  $chord =~ /m/;
$dim =  $chord =~ /dim|\u00b0/;
$aug =  $chord =~ /aug|\+/;
$sus =  $chord =~ /(sus)/;
$with7 =  $chord =~ /7/;
$maj7 =  $chord =~ /7(M|\+)/;
$with6 =  $chord =~ /(6|13)/;
$with4 =  $chord =~ /(4|11)/;
$aug5 =  $chord =~ /5(#|\\+)/;
$dim5 =  $chord =~ /5(b|-)/;
$with9 =  $chord =~ /(9|2)/;
$bass = $chord =~ /(?<=\/).*/; 
# returning results as 0 and 1 for true and false
@array1 = ($min*1, $dim*1, $aug*1, $sus*1, $with7*1, $maj7*1, $with6*1,
$with4*1, $aug5*1, $dim5*1, $with9*1, $bass*1); 
print @array1;
