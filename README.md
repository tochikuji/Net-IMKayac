# NAME

Net::IMKayac - Simple and tiny wrapper for im.kayac API

# SYNOPSIS

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

# DESCRIPTION

Net::IMKayac is the simple and tiny message sender for im.kayac API.
You can send push notification in a few step;

# INTERFACE

## Class method

### Net::IMKayac->new(\\%args)

%args may expect

- username :Str (required)

    username on im.kayac;
    If it is not specified, new will croak with exception.

- auth :Str = none(default)

    specify auth type
    none: without authentication. If you didn't specify auth, it will be set.
    password(pass): password authentication
    secret\_key(secret): secret key authentication

- password :Str

    passphrase of password authentication or secret  key authentication.
    Valid passphrase is required

## Instance method

### send($message), send($message, $handler)

Send a request to im.kayac and returns a hash reference of API's response;
it contains $message as a message
$handler is optional. It is url scheme for iPhone apllications.
For futher details on it, refer to developer.apple.com

### is\_succeed()

Aliase of $self->{is\_succeed}
It returns a true value if previous send() method is succeeded.
otherwise, it returns false;
It will be updated each time called send() method. Watch out for it when you send a request in succession.

# LICENSE

Copyright (C) Aiga Suzuki a.k.a. tochikuji;

This software is released under the MIT license.
For more details, refer to LICENSE.

# AUTHOR

Aiga Suzuki

# POD ERRORS

Hey! __The above document had some coding errors, which are explained below:__

- Around line 111:

    '=item' outside of any '=over'

- Around line 128:

    You forgot a '=back' before '=head2'
