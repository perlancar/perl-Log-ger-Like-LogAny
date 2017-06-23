package Log::ger::Like::LogAny;

# DATE
# VERSION

use strict;
use warnings;

use Log::ger::Plugin 'LogAny';

sub get_logger {
    my ($package, %args) = @_;

    my $caller = caller(0);
    require Log::ger;
    Log::ger->get_logger(category => $caller, %args);
}

sub import {
    my $package = shift;

    if (@_ && $_[0] eq '$log') {
        no strict 'refs';
        shift;
        my $caller = caller(0);
        require Log::ger;
        my $log = Log::ger->get_logger(category => $caller, @_);
        *{"$caller\::log"} = \$log;
    }
}

1;
# ABSTRACT: Log like Log::Any

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

To get logger object:

 use Log::ger::Like::LogAny '$log';

or:

 use Log::ger::Like::LogAny;

To log:

 $log->debug("blah ...");

 if ($log->is_trace) {
     $log->tracef("Foo is %s", $foo);
 }

To set output, use one of the available Log::ger::Output::*. You can send logs
to Log::Any using L<Log::ger::Output::LogAny>.


=head1 DESCRIPTION

This module mimics Log::Any-like logging interface.


=head1 SEE ALSO

L<Log::ger>

L<Log::Any>
