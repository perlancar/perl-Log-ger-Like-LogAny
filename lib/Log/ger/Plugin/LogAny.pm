package Log::ger::Plugin::LogAny;

# DATE
# VERSION

use strict;
use warnings;

use Log::ger ();

sub get_hooks {
    my %conf = @_;

    return {
        create_routine_names => [
            __PACKAGE__, 50,
            sub {
                my %args = @_;

                my $levels = [keys %Log::ger::Levels];

                return [{
                    log_subs    => [map { ["log_$_", $_], ["log_${_}f", $_] }
                                        @$levels],
                    is_subs     => [map { ["log_is_$_", $_] } @$levels],
                    log_methods => [map { ["$_", $_], ["${_}f", $_] }
                                        @$levels],
                    is_methods  => [map { ["is_$_", $_] } @$levels],
                }];
            }],
    };
}

1;
# ABSTRACT: Plugin to mimic Log::Any

=for Pod::Coverage ^(.+)$

=head1 SYNOPSIS

 use Log::ger::Plugin 'LogAny';
 use Log::ger;

 log_warn "blah ...";


=head1 DESCRIPTION

This plugin does the following:

=over

=item * create log methods like Log::Any

In addition to debug(), trace(), etc al also create debugf(), tracef(), et al.

=back


=head1 SEE ALSO

L<Log::ger::Like::LogAny>