# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';
	
use Test;

# we were going to use Test::Simple as rec'd in perldoc Test, but 
# Test::Simple isn't included by default even as of perl 5.6.1

BEGIN { plan tests => 1 };	# not needed by Test::Simple, only by Test

use Proc::NiceSleep qw(maybesleep minruntime minsleeptime maxload sleepfactor);	

Proc::NiceSleep::minruntime(.0001);	
#Proc::NiceSleep::minsleeptime(.0001);	

# init it; this should check for Sys::CpuLoad

if ($Proc::NiceSleep::_havesyscpuload) {
	ok(testload()); # If we made it this far, we're ok.  
} else {
	skip(1, 1, 1) 
}

# we can't really test this in all circumstatnce, other things could be 
# using the  CPU to cause our 'load' data to be influenced very little by
# us. We test that everything loads ok and works, and we test that we can
# drive the load up to .01 (if it's not there yet) and sleep as a result
sub testload {
	# this better work, we already tested!!
	my $load1 = Sys::CpuLoad::load();
	maxload(.01);
	my $t1 = Proc::NiceSleep::time();
	while(Proc::NiceSleep::time() - $t1 < 10) {	# for up to 10 seconds...
		for (my $i=0; $i < 10000; $i++) { my $b = $i + $i; }	# work!
		my $load2 = Sys::CpuLoad::load();
		return 1 if ( ($load2 > $load1 && maybesleep()) || maybesleep());	
		# goody! raised & slept
	} 
	1; # hey, just cause we couldn't raise the load doesn't mean we failed
}

