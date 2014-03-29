package Net::IMKayac;
our $VERSION = "0.01";

use 5.010;

use strict;
use warnings;
use utf8;

use JSON;
use Furl;
use Digest::SHA1 qw/sha1_hex/;
use Carp;

use constant {
    IMK_URI => 'http://im.kayac.com/api/post/',
};


sub new {
    my $package = shift;
    my $self = {
        client => Furl->new,
        auth => 'none',
        is_succeed => undef,
        @_,
    };

    Carp::croak "unsupported auth type $self->{auth}\n" unless $self->{auth} =~ /^(?:none|pass(?:word)?|secret(?:_key)?)$/;

    unless(defined $self->{username}){
        Carp::croak "username must be specified.\n";
    }   

    if($self->{auth} =~ /^pass(?:word)?$/i){
        $self->{type} = 'pass';
        Carp::croak "password must be specified in password authentication.\n" unless defined $self->{password};
    } elsif($self->{auth} =~ /^secret(?:_key)?/i){
        $self->{type} = 'secret';
        Carp::croak "password must be specified in secret key authentication.\n" unless defined $self->{password};
    }

    return bless $self, $package;
}


sub send {
    my $self = shift;
    my $msg = shift;
    my $handler = shift;

    $msg //= '';

    my %params = ('message', $msg);
    $params{handler} = $handler if defined $handler;
    $params{password} = $self->{password} if $self->{type} eq 'pass';
    $params{sig} = sha1_hex($msg.$self->{password}) if $self->{type} eq 'secret';

    my $response = $self->{client}->post(IMK_URI.$self->{username}, [], \%params);
    
    my $res = JSON::decode_json($response->content);
    $self->{is_succeed} = $res->{result} eq 'posted' ? 1 : 0;

    return $res;
}


sub is_succeed {
    shift->{is_succeed};
}

1;

__END__

=encoding utf-8

=head1 NAME

Net::IMKayac - Simple and tiny wrapper for im.kayac API

=head1 SYNOPSIS

    use Net::IMKayac;

    # without authentication
    my $non_auth = Net::IMKayac->new(username => 'your_name', auth => 'none');
    # with password authentication
    my $pass_auth = Net::IMKayac->new(username => 'your_name', auth => 'password', password => $passphrase);
    # with secret key authentication
    my $secret_auth = Net::IMKayac->new(username => 'your_name', auth => 'secret_key', password => $passphrase);

    # send message
    $obj->send('some message');
    # senf message with handler
    $obj->send($message, $handler);

=head1 DESCRIPTION

Net::IMKayac is the simple and tiny message sender for im.kayac API.
You can send push notification in a few step;

=head1 LICENSE

Copyright (C) Aiga Suzuki.

This software is released under the MIT license.

=head1 AUTHOR

Aiga Suzuki E<lt>tochikuji@gmail.comE<gt>

=cut
