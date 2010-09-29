package Bot::BasicBot::Pluggable::Module::Clock;
use strict;
use warnings;
use Bot::BasicBot::Pluggable::Module;
use base 'Bot::BasicBot::Pluggable::Module';

our $VERSION = 0.01;
use POSIX qw{ strftime tzset };

=head1 SYNOPSIS

Simple module to display time in different timezones.

=cut

# Sort the Time Zones from West to East.
my @time_zones = (
    ['LAX', 'America/Los_Angeles'],
    ['CHI', 'America/Chicago'],
    ['NYC', 'America/New_York'],
    ['UTC', 'UTC'],
    ['LON', 'Europe/London'],
    ['BER', 'Europe/Berlin'],
    ['TOK', 'Asia/Tokyo'],
    ['SYD', 'Australia/Sydney'],
);

sub told {
    my ( $self, $message ) = @_;

    ( my $msg_body = $message->{'body'} ) =~ s/^\s+//;
    if ($msg_body eq 'clock?') {
        my @dates;
        for my $tz (@time_zones) {
            local $ENV{TZ} = $tz->[1];
            push @dates, strftime("$tz->[0]: %a, %H:%M %Z", localtime());
        }
        $self->reply($message, $message->{who} . ': ' . join(' / ', @dates));
    }
}

1;
