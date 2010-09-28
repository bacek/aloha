package Bot::BasicBot::Pluggable::Module::Clock;
use strict;
use warnings;
use Bot::BasicBot::Pluggable::Module;
use base 'Bot::BasicBot::Pluggable::Module';

our $VERSION = 0.01;
use POSIX qw{ strftime tzset };

my %tz = (
    SYD => 'Australia/Sydney',
    UTC => 'UTC',
);

sub told {
    my ( $self, $message ) = @_;

    ( my $msg_body = $message->{'body'} ) =~ s/^\s+//;
    if ($msg_body eq 'clock?') {
        my @dates;
        while (my ($name, $tz) = each %tz) {
            local $ENV{TZ} = $tz;
            push @dates, strftime("$name: %a, %H:%M %Z", localtime());
        }
        $self->reply($message, $message->{who} . ': ' . join(' / ', @dates));
    }
}

1;
