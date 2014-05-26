package Software::Release::Watch::Versioning;

use 5.010;
use Moo::Role;

our $VERSION = '0.02'; # VERSION

requires 'cmp_version';

1;
# ABSTRACT: Versioning role

__END__

=pod

=encoding UTF-8

=head1 NAME

Software::Release::Watch::Versioning - Versioning role

=head1 VERSION

This document describes version 0.02 of Software::Release::Watch::Versioning (from Perl distribution Software-Release-Watch), released on 2014-05-26.

=head1 HOMEPAGE

Please visit the project's homepage at L<https://metacpan.org/release/Software-Release-Watch>.

=head1 SOURCE

Source repository is at L<https://github.com/sharyanto/perl-Software-Release-Watch>.

=head1 BUGS

Please report any bugs or feature requests on the bugtracker website L<https://rt.cpan.org/Public/Dist/Display.html?Name=Software-Release-Watch>

When submitting a bug or request, please include a test-file or a
patch to an existing test-file that illustrates the bug or desired
feature.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
