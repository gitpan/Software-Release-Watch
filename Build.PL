
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.3601"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Watch latest software releases",
  "dist_author" => [
    "Steven Haryanto <stevenharyanto\@gmail.com>"
  ],
  "dist_name" => "Software-Release-Watch",
  "dist_version" => "0.01",
  "license" => "perl",
  "module_name" => "Software::Release::Watch",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Log::Any" => 0,
    "Module::List" => 0,
    "Moo" => 0,
    "Moo::Role" => 0,
    "Perinci::CmdLine" => "0.67",
    "Perinci::Sub::Gen::AccessTable" => "0.17",
    "SemVer" => "v0.3.0",
    "Software::Catalog" => "0.03",
    "WWW::Mechanize" => 0,
    "perl" => "5.010001"
  },
  "script_files" => [
    "bin/list-watchable-software",
    "bin/list-software-releases"
  ]
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
