#!/usr/bin/perl

#
# Scalar
#
$n = 3;
$name = "David Malone";
$x = 2.74;
$a = undef;

print "n was $n and name was $name\n";

$y = $n + $x;
print "The sum of n and x was $y\n";

$names = $name x $n;
print "Names was $names\n";

$z = $n / 4;
print "A quarter of n is $z\n";

#
# Array
#
@array = (1, 2, 'three', $n);
print "The array was @array\n";
$array[0] = 1;
$array[1] = 'one';
$array[2] = 'three';
$array[3] = 'Tuesday';
$array[5] = 'Apples';
print "The array was @array\n";
print "The value of the third entry is $array[2]\n";

for ($i = 0; $i < 6; $i++) {
	print "Element $i is $array[$i]\n";
}

@new_array = @array;
$new_array[-1] = "Bananas";
for ($i = 0; $i < 6; $i++) {
	print "New element $i is $new_array[$i]\n";
}

$new_array[$#new_array] = "Cucumber";
for ($i = 0; $i < 6; $i++) {
	print "New element $i is $new_array[$i]\n";
}
$size = @array; # Number of things in the array - should put in 6
print "The size of array is $size\n";

@f = (@array, @new_array);
$size_f = @f;
print "The array f has size $size_f\n";

#
# Hashes
#
%seasons = ("Spring" => 1, "Summer" => 2, "Autumn" => 3, "Winter" => 4);
$num = $seasons{"Autumn"};
print "Autumn has number $num\n";
$seasons{"Fall"} = 3;

foreach $season (keys %seasons) {
	print "The number for $season is $seasons{$season}\n";
	$number2season{$seasons{$season}} = $season;
}

foreach $number (keys %number2season) {
	print "A season with number $number is $number2season{$number}\n";
}




