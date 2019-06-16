#!/usr/bin/perl
use strict;
use warnings;

# first, create your message
use Email::MIME;
my $message = Email::MIME->create(
  header_str => [
    From    => 'sh...@test.com',
    To      => 'dm..@test.com',
    CC      => 'dav..@test.com',
    Subject => 'test email with CC to D from new intance!',
  ],
  attributes => {
    encoding => 'quoted-printable',
    charset  => 'ISO-8859-1',
  },
  body_str => "This is a test email. \n BR\n Dmytro\n",
);

# send the message
use Email::Sender::Simple qw(sendmail);
sendmail($message);
