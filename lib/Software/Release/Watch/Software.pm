package Software::Release::Watch::Software;

use 5.010;
use Moo::Role;

our $VERSION = '0.01'; # VERSION

has watcher => (is => 'rw', required => 1);

requires 'list_releases';

#with 'Software::Release::Watch::Versioning';
requires 'cmp_version';

1;
# ABSTRACT: Software role


__END__
=pod

=head1 NAME

Software::Release::Watch::Software - Software role

=head1 VERSION

version 0.01

=for Pod::Coverage watcher

=head1 DESCRIPTION


This module has L<Rinci> metadata.

=head1 FUNCTIONS


None are exported by default, but they are exportable.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

