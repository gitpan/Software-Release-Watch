package Software::Release::Watch::Versioning::SemVer;

use 5.010;
use Moo::Role;

use SemVer;

our $VERSION = '0.01'; # VERSION

sub cmp_version {
    my ($a, $b) = @_;
    SemVer->new($a) <=> SemVer->new($b);
}

1;
# ABSTRACT: Semantic versioning as per semver.org


__END__
=pod

=head1 NAME

Software::Release::Watch::Versioning::SemVer - Semantic versioning as per semver.org

=head1 VERSION

version 0.01

=for Pod::Coverage cmp_version

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

