#!/usr/local/bin/perl -w 

use strict;

# script to update 'latest' files in a .pm dist directory
# Copyright (c) 2002 Josh Rabinowitz, this program is
# licensed the same as perl itself.

die "Pass dir and dist to examine, for example /dir and dist-0.32\n" 
	unless (scalar(@ARGV) > 1);
my ($dir, $file) = @ARGV;

if (-e "$file.tar.gz" && !(-e "$file")) {
	print "$file does not exist but tarball does, extracting...\n";
	print `tar -zxf $file.tar.gz`;
} 
chdir($dir) || die "Couldn't cd to $dir";
if (-e "$file" && -e "$file.tar.gz") {
	my $strip = $file;
	if($strip =~ s/-(\d+)\.?([0-9.]*)$//) {
		print "$strip  $1  $2\n";
		#die "TESTING";
		if (-e "${strip}-latest") {
			unlink("${strip}-latest") || 
				die "Couldn't unlink ${strip}-latest";
		}
		if (-e "${strip}-latest.tar.gz") {
			unlink("${strip}-latest.tar.gz") || 
				die "Couldn't unlink ${strip}-latest.tar.gz";
		}
		symlink("$file", "${strip}-latest") ||
			die "Couldn't symlink ${strip}-latest";
		symlink("$file.tar.gz", "${strip}-latest.tar.gz") ||
			die "Couldn't symlink ${strip}-latest.tar.gz";
	}
} else { 
	die "Couldn't find $file and $file.tar.gz";
}

