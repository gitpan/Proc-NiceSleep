#!/usr/local/bin/perl -w

# this is a short example that illustrates use of Proc::NiceSleep

# Copyright (c) 2002 Josh Rabinowitz, All rights reserved
# This program is free software; you can redistribute it and/or modify
# it under the same terms as Perl itself.

use strict; 

use Proc::NiceSleep qw(:all);

nice(5);	# lower our priority if possible
minruntime(.9);	# how long to run without interruption
sleepfactor(.4);	
	# successive calls of maybesleep() will cause Proc::NiceSleep to
	# try to maintain (runtime * sleepfactor) = sleep time

for (my $i=0; $i < 5; $i++) {	# pretend to do ten units of work
	print "Working for a little while...   " . 
		scalar(localtime(time())) . "\n";
	dosomework();	# pretend this actually did something for a second
	my $slept = maybesleep(); 	# check to sleep.
	if ($slept) { 	# maybesleep() returns 0 if it didn't sleep
		print "Slept " . sprintf("%1.2f", $slept) . 
			" seconds.             " .  scalar(localtime(time())) . "\n"; 
	}
} 
print "Done working!                   " .  
	scalar(localtime(time())) . "\n"; 
print "-- Informational Data About Proc::NiceSleep: --\n";
print Proc::NiceSleep::DumpText(); # show what went on inside 
exit(0);	# we're all finished here for now

# dosomework() just sit still for a second, pretending to do work
sub dosomework { Proc::NiceSleep::sleep(.7); }


