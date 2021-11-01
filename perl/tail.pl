#!/usr/bin/perl
use v5.12;
use strict;

# Solution from https://docstore.mik.ua/orelly/perl4/cook/ch08_06.htm
# wasn't used because of necessity to handle logrotate (need to add check for file size and inode)

say "Write someting to my.log file ...";

open my $pipe, "|-", '/usr/bin/tail', '-F', './my.log' or die "Something went wrong when trying to execute tail: $!";
while (<$pipe>) {
  print "New line: " + $_
}
close $pipe
  
