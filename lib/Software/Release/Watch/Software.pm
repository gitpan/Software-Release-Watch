package Software::Release::Watch::Software;

use 5.010;
use Moo::Role;

our $VERSION = '0.03'; # VERSION

has watcher => (is => 'rw', required => 1);

requires 'list_releases';

#with 'Software::Release::Watch::Versioning';
requires 'cmp_version';

1;
# ABSTRACT: Software role

__END__

=pod

=encoding UTF-8

=head1 NAME

Software::Release::Watch::Software - Software role

=head1 VERSION

This document describes version 0.03 of Software::Release::Watch::Software (from Perl distribution Software-Release-Watch), released on 2014-08-16.

=for Pod::Coverage watcher

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
