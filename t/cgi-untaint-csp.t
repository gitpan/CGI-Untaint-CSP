#!perl -wT

# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl CGI-Untaint-telephone.t'

#########################

use Test::More tests => 7;
BEGIN { use_ok('CGI::Untaint::CSP') };

#########################

# Check regular expression checker
my $regex = CGI::Untaint::CSP::_untaint_re();
ok( 'MD' =~ $regex, 'valid state' );
ok( 'Kent' =~ $regex, 'valid state' );
ok( '12' !~ $regex, 'invalid state' );

use_ok('CGI::Untaint');
my $vars = {
    state1 => 'MD',
    state2 => 'Kent',
    state3 => ' ',
};

# None should work because we've not given any countries

diag "Ignore warnings about the need to specify a country";
my $untainter = CGI::Untaint->new($vars);
my $c = $untainter->extract(-as_CSP => 'state1');
is($c, undef, 'Maryland');

$c = $untainter->extract(-as_CSP => 'state2');
is($c, undef, 'Kent');

# and what about empty fields?
$c = $untainter->extract(-as_CSP => 'state3');
