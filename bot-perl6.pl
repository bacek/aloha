#!/usr/bin/env perl -w
use warnings;
use strict;
use lib 'lib';
use Bot::BasicBot::Pluggable;
use Bot::BasicBot::Pluggable::Store::DBIJSON;

my $store = Bot::BasicBot::Pluggable::Store::DBIJSON->new(
    dsn          => "DBI:Pg:dbname=aloha",
    user         => "aloha",
    password     => "aloha",
    table        => "bot",

    # create indexes on key/values?
    create_index => 1,
);


# with all known options
my $bot = Bot::BasicBot::Pluggable->new(

    server => "irc.freenode.org",
    port   => "6667",
    channels => ["#perl6"],

    nick      => "aloha",
    username  => "aloha",
    name      => "bacek's nick completion bot",

    ignore_list => [qw(dipsy dadadodo laotse)],

    charset => "utf-8", # charset the bot assumes the channel is using

    loglevel => 'debug',

    store    => $store,

);
#$bot->store($store);

#$bot->load('Auth');
#$bot->load('Loader');
#$bot->load('Infobot');
$bot->load('Karma');
$bot->load('Seen');
#$bot->load('Message');
#$bot->load('Maths');
$bot->run();
