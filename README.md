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

# LICENSE

Copyright (C) Aiga Suzuki.

This software is released under the MIT license.

# AUTHOR

Aiga Suzuki <tochikuji@gmail.com>
