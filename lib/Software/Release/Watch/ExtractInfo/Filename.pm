package Software::Release::Watch::ExtractInfo::Filename;

use 5.010;
use Log::Any '$log';
use Moo::Role;

our $VERSION = '0.02'; # VERSION

#my @archive_exts = qw(tar.gz tar.bz2 tar zip rar);
#my $archive_re   = join("|", map {quotemeta} @archive_exts);
#$archive_re = qr/\.$archive_re$/i;

# XXX some software use _ (or perhaps space) to separate name and
# version

sub extract_info {
    my ($sel, $fn) = @_;

    unless ($fn =~ /\A(.+)-([0-9].+)\z/) {
        $log->warnf("Can't parse filename: %s", $fn);
        return;
    }

    {name=>$1, v=>$2};
}

1;
# ABSTRACT: Parse releases from name like 'NAME-VERSION'

__END__

=pod

=encoding UTF-8

=head1 NAME

Software::Release::Watch::ExtractInfo::Filename - Parse releases from name like 'NAME-VERSION'

=head1 VERSION

This document describes version 0.02 of Software::Release::Watch::ExtractInfo::Filename (from Perl distribution Software-Release-Watch), released on 2014-05-26.

=for Pod::Coverage extract_info

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
