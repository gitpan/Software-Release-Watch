package Software::Release::Watch::ExtractInfo::Filename;

use 5.010;
use Log::Any '$log';
use Moo::Role;

our $VERSION = '0.01'; # VERSION

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

=head1 NAME

Software::Release::Watch::ExtractInfo::Filename - Parse releases from name like 'NAME-VERSION'

=head1 VERSION

version 0.01

=for Pod::Coverage extract_info

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

