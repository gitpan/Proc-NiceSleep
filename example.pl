#!/usr/local/bin/perl -w

# this is a short example that illustrates use of Proc::NiceSleep

# Copyright (c) 2002 Josh Rabinowitz, All rights reserved
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.

use strict; 

use Proc::NiceSleep qw(:all);
use Data::Dumper;	# so we can show the Proc::NiceSleep internals

my $var = Proc::NiceSleep::Dump();	 # get what's going on inside
#print Data::Dumper::Dumper( $var );

nice(5);	# lower our priority if possible
minruntime(1.1);
sleepfactor(.9);

$var = Proc::NiceSleep::Dump();	 # get what's going on inside
print Data::Dumper::Dumper( $var );	 # show it

for (my $i=0; $i < 10; $i++) {	# pretend to do ten units of work
	print "Working for about one second... " . scalar(localtime(time())) . "\n";
	sleep(1);	# pretend this actually did something for a second
	my $slept = maybesleep(); 	# check to sleep.
	if ($slept) { 
		print "Slept " . sprintf("%1.2f", $slept) . " seconds              " . 
			scalar(localtime(time())) . "\n"; 
	}
}
$var = Proc::NiceSleep::Dump();	# get what's going on inside
print Data::Dumper::Dumper( $var );	# show it

exit(0);	# we're all finished here for now

