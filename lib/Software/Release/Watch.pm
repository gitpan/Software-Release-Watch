package Software::Release::Watch;

use 5.010;
use Log::Any '$log';
use Moo;

use Perinci::Sub::Gen::AccessTable 0.17 qw(gen_read_table_func);
use Software::Catalog;

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(
                       list_software
                       list_software_releases
               );

our $VERSION = '0.01'; # VERSION

our %SPEC;

has mech => (
    is => 'rw',
    default => sub {
        require WWW::Mechanize;

        # to do automatic retry, pass a WWW::Mechanize::Pluggable object with
        # WWW::Mechanize::Plugin::Retry.

        WWW::Mechanize->new(autocheck=>0);
    },
);

sub get_url {
    my ($self, $url) = @_;

    my $resp = $self->mech->get($url);
    unless ($resp->is_success) {
        # 404 is permanent, otherwise we assume temporary error
        die [$resp->code == 404 ? 542 : 541,
             "Failed retrieving URL", undef,
             {
                 network_status  => $resp->code,
                 network_message => $resp->message,
                 url => $url,
             }];
    }
    $resp;
}

my $table_spec = {
    fields => {
        id => {
            index      => 0,
            schema     => ['str*' => {
                match => $Software::Catalog::swid_re,
            }],
            searchable => 1,
        },
    },
    pk => 'id',
};

my $res = gen_read_table_func(
    name => 'list_software',
    table_data => sub {
        require Module::List;

        my $query = shift;
        state $res = do {
            my $mods = Module::List::list_modules(
                "Software::Release::Watch::sw::", {list_modules=>1});
            $mods = [map {[[s/.+:://, $_]->[-1]]} keys %$mods];
            {data=>$mods, paged=>0, filtered=>0, sorted=>0, fields_selected=>0};
        };
        $res;
    },
    table_spec => $table_spec,
    langs => ['en_US'],
);
die "BUG: Can't generate func: $res->[0] - $res->[1]"
    unless $res->[0] == 200;

$SPEC{list_software_releases} = {
    v => 1.1,
    summary => 'List software releases',
    description => <<'_',

Statuses:

* 541 - transient network failure
* 542 - permanent network failure (e.g. server returns 404 page)
* 543 - parsing failure (permanent)

_
    args => {
        software_id => {
            schema => ["str*", {
                match => $Software::Catalog::swid_re,
            }],
            req => 1,
            pos => 0,
        },
    },
    "_perinci.sub.wrapper.validate_args" => 0,
};
sub list_software_releases {
    my %args = @_; if (!exists($args{'software_id'})) { return [400, "Missing argument: software_id"] } my $arg_err; ((defined($args{'software_id'})) ? 1 : (($arg_err = "TMPERRMSG: required data not specified"),0)) && ((!ref($args{'software_id'})) ? 1 : (($arg_err = "TMPERRMSG: type check failed"),0)) && (($args{'software_id'} =~ /(?^:\A[a-z]([a-z0-9_])*\z)/) ? 1 : (($arg_err = "TMPERRMSG: clause failed: match"),0)); if ($arg_err) { return [400, "Invalid argument value for software_id: $arg_err"] } # VALIDATE_ARGS
    my $swid = $args{software_id};

    my $res;

    $res = Software::Catalog::get_software_info(id => $swid);
    return $res unless $res->[0] == 200;

    my $mod = __PACKAGE__ . "::SW::$swid";
    my $mod_pm = $mod; $mod_pm =~ s!::!/!g; $mod_pm .= ".pm";
    eval { require $mod_pm };
    return [500, "Can't load $mod: $@"] if $@;

    my $obj = $mod->new(watcher => __PACKAGE__->new);

    $res = eval { $obj->list_releases };
    my $err = $@;

    if ($err) {
        if (ref($err) eq 'ARRAY') {
            return $err;
        } else {
            return [500, "Died: $err"];
        }
    } else {
        return [200, "OK", $res];
    }
}

1;
# ABSTRACT: Watch latest software releases



__END__
=pod

=head1 NAME

Software::Release::Watch - Watch latest software releases

=head1 VERSION

version 0.01

=head1 SYNOPSIS

 use Software::Release::Watch qw(
     list_software
     list_software_releases
 );

 my $res;
 $res = list_software();
 $res = list_software_releases(software_id=>'wordpress');

=for Pod::Coverage get_url mech

=head1 FAQ

=head1 SEE ALSO

L<Software::Catalog>

C<Software::Release::Watch::*> modules.

=head1 DESCRIPTION


This module has L<Rinci> metadata.

=head1 FUNCTIONS


None are exported by default, but they are exportable.

=head2 list_software(%args) -> [status, msg, result, meta]

REPLACE ME.

REPLACE ME

Data is in table form. Table fields are as follow:

=over

=item *

I<id> (ID field)


=back

Arguments ('*' denotes required arguments):

=over 4

=item * B<detail> => I<bool> (default: 0)

Return array of full records instead of just ID fields.

By default, only the key (ID) field is returned per result entry.

=item * B<fields> => I<array>

Select fields to return.

=item * B<id> => I<str>

Only return records where the 'id' field equals specified value.

=item * B<id.contains> => I<str>

Only return records where the 'id' field contains specified text.

=item * B<id.is> => I<str>

Only return records where the 'id' field equals specified value.

=item * B<id.max> => I<str>

Only return records where the 'id' field is less than or equal to specified value.

=item * B<id.min> => I<array>

Only return records where the 'id' field is greater than or equal to specified value.

=item * B<id.not_contains> => I<str>

Only return records where the 'id' field does not contain a certain text.

=item * B<id.xmax> => I<str>

Only return records where the 'id' field is less than specified value.

=item * B<id.xmin> => I<array>

Only return records where the 'id' field is greater than specified value.

=item * B<q> => I<str>

Search.

=item * B<random> => I<bool> (default: 0)

Return records in random order.

=item * B<result_limit> => I<int>

Only return a certain number of records.

=item * B<result_start> => I<int> (default: 1)

Only return starting from the n'th record.

=item * B<sort> => I<str>

Order records according to certain field(s).

A list of field names separated by comma. Each field can be prefixed with '-' to
specify descending order instead of the default ascending.

=item * B<with_field_names> => I<bool>

Return field names in each record (as hash/associative array).

When enabled, function will return each record as hash/associative array
(field name => value pairs). Otherwise, function will return each record
as list/array (field value, field value, ...).

=back

Return value:

Returns an enveloped result (an array). First element (status) is an integer containing HTTP status code (200 means OK, 4xx caller error, 5xx function error). Second element (msg) is a string containing error message, or 'OK' if status is 200. Third element (result) is optional, the actual result. Fourth element (meta) is called result metadata and is optional, a hash that contains extra information.

=head2 list_software_releases(%args) -> [status, msg, result, meta]

List software releases.

Statuses:

=over

=item *

541 - transient network failure


=item *

542 - permanent network failure (e.g. server returns 404 page)


=item *

543 - parsing failure (permanent)


=back

Arguments ('*' denotes required arguments):

=over 4

=item * B<software_id>* => I<str>

=back

Return value:

Returns an enveloped result (an array). First element (status) is an integer containing HTTP status code (200 means OK, 4xx caller error, 5xx function error). Second element (msg) is a string containing error message, or 'OK' if status is 200. Third element (result) is optional, the actual result. Fourth element (meta) is called result metadata and is optional, a hash that contains extra information.

=head1 AUTHOR

Steven Haryanto <stevenharyanto@gmail.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2012 by Steven Haryanto.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut

