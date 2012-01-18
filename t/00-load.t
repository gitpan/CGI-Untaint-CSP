#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'CGI::Untaint::CSP' ) || print "Bail out!
";
}

diag( "Testing CGI::Untaint::CSP $CGI::Untaint::CSP::VERSION, Perl $], $^X" );
