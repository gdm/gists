#!/usr/bin/perl
# Uploads all files and folders recursively to the WebDAV folder
# Usage: davpush.pl URL remote_path\n";
# Example:  
# ~/bin/davpush.pl https://dmgo.stackstorage.com/remote.php/webdav /remote.php/webdav/LanguageLearning/
use File::Find;

my $script = "";

my $target_url = $ARGV[0];
my $target_dir = $ARGV[1];

sub wanted() {
  my $f = $File::Find::name;
  if ($f ne ".") {
    if (-f $f) {
      $script .= "put '$f'\n";
    } else {
      $script .= "cd '$target_dir'\n";
      $script .= "mkdir '$f'\n";
      $script .= "cd '$f'\n"
    }
  }
}



find({'wanted'=>\&wanted, 'no_chdir' => 1},   ".");


$pid = open(POUT, "| cadaver $target_url");
# use line below for debug
#$pid = open(POUT, "| cat ");
print POUT $script;
print POUT "bye\n";
close POUT;


