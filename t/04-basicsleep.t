# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl test.pl'

#########################

# change 'tests => 1' to 'tests => last_test_to_print';
	
use Test;

# we were going to use Test::Simple as rec'd in perldoc Test, but 
# Test::Simple isn't included by default even as of perl 5.6.1

BEGIN { plan tests => 1 };	# not needed by Test::Simple, only by Test

use Proc::NiceSleep;	

ok(testsleep1()); # If we made it this far, we're ok.  

sub testsleep1 {
	print "Sleeping about 1 seconds...\n";	# we try to do this fast
	my $t1 = Proc::NiceSleep::time();
	Proc::NiceSleep::minruntime(.1);
	Proc::NiceSleep::sleep(.2);	# we would s
	Proc::NiceSleep::maybesleep(.5);
	my $t2 = Proc::NiceSleep::time();
	my $t = $t2 - $t1;
	return ($t > .5);
}

