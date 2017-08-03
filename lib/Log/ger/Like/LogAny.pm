package Log::ger::Like::LogAny;

# DATE
# VERSION

# IFUNBUILT
use strict 'subs', 'vars';
use warnings;
# END IFUNBUILT

use Log::ger::Level::Like::LogAny;

sub get_logger {
    my ($package, %args) = @_;

    my $caller = caller(0);
    require Log::ger;
    require Log::ger::Plugin;
    my $log = Log::ger->get_logger(category => $caller, %args);
    Log::ger::Plugin->set({
        name       => 'LogAny',
        target     => 'object',
        target_arg => $log,
    });
    $log;
}

sub import {
    my $package = shift;

    if (@_ && $_[0] eq '$log') {
        shift;
        my $caller = caller(0);
        my $log = __PACKAGE__->get_logger(category => $caller, @_);
        *{"$caller\::log"} = \$log;
    }
}

package
    Log::Any; # hide from PAUSE

unless (defined(&{"get_logger"})) {
    sub get_logger { goto &Log::ger::Like::LogAny::get_logger }
}

1;
# ABSTRACT: Log like Log::Any

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

To switch your code from L<Log::Any> to L<Log::ger>, replace this:

 use Log::Any;
 use Log::Any '$log';

to:

 use Log::ger::Like::LogAny;
 use Log::ger::Like::LogAny '$log';

The rest of this works in Log::Any as well as under Log::ger::Like::LogAny:

 my $log = Log::Any->get_logger(category => 'My::Package');

 $log->err("blah ...", "more blah ...");
 $log->tracef("fmt %s %s", "blah ...", {data=>'structure'});

 if ($log->is_trace) {
    ...
 }

To set output, use one of the available C<Log::ger::Output::*>. You can send
logs to Log::Any using L<Log::ger::Output::LogAny>.


=head1 DESCRIPTION

This module mimics Log::Any-like logging interface. The idea is that you replace
the C<use> statement like shown in the Synopsis and you're done switching.
Useful for code that uses Log::Any. Not everything is supported though (see the
above Synopsis).


=head1 SEE ALSO

L<Log::ger>

L<Log::Any>
