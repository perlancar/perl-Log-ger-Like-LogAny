package Log::ger::Plugin::LogAny;

# DATE
# VERSION

use strict;
use warnings;

use Log::ger ();

sub get_hooks {
    my %conf = @_;

    return {
        create_formatter => [
            __PACKAGE__, 50,
            sub {
                my $formatter = sub {
                    return join " ", @_;
                };
                return [$formatter, 0, 'join'];
            },
        ],
        create_routine_names => [
            __PACKAGE__, 50,
            sub {
                my %args = @_;

                my $levels = [keys %Log::ger::Levels];

                return [{
                    log_subs    => [map { (["log_$_", $_, "join"], ["log_${_}f", $_, "default"]) }
                                        @$levels],
                    is_subs     => [map { ["log_is_$_", $_] } @$levels],
                    log_methods => [map { (["$_", $_, "join"], ["${_}f", $_, "default"]) }
                                        @$levels],
                    is_methods  => [map { ["is_$_", $_] } @$levels],
                }, 1];
            }],
    };
}

1;
# ABSTRACT: Plugin to mimic Log::Any

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

Use from L<Log::ger::Like::LogAny>.


=head1 DESCRIPTION


=head1 SEE ALSO

L<Log::ger::Like::LogAny>
