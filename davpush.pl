#!/usr/bin/perl
#  Uploads all files and folders recursively to the WebDAV folder passed in the url 
use File::Find;

my $script = "";

sub wanted() {
  my $f = $File::Find::name;
  if (-f $f) {
    $script .= "put '$f'\n";
  } else {
    $script .= "cd '$target_dir'\n";
    $script .= "mkdir '$f'\n";
    $script .= "cd '$f'\n"
  }
}

my $url = $ARGV[0];
print "URL: $url";

if ($url =~ m#https://.*?(/\S*)#) {

  my $target_url = "$0";
  my $target_dir = "$1";

  find({'wanted'=>\&wanted, 'no_chdir' => 1},   ".");


  $pid = open(POUT, "| cadaver $url");
  print POUT $script;
  print POUT "bye\n";
  close POUT;

} else {
  print "Usage: davpush.pl https//<hostname>:<port>/<upload path>\n";
  print "\n";
  print "Uploads all files and folders recursively to the WebDAV folder passed in the url.";
}
