requires 'perl', '5.010';
requires 'JSON';
requires 'Furl';
requires 'Carp';
requires 'Digest::SHA1';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

