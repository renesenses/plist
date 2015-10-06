#!/usr/bin/env perl

use Data::Dumper;
use Mac::PropertyList qw( parse_plist_file );


my $plist_file	= "/Users/LochNessIT/Library/Safari/Bookmarks.plist";
my $csv_res_url = "/Users/LochNessIT/Desktop/Bookmarks.csv";

my $data = parse_plist_file( $plist_file );

my $perl  = $data->as_perl;
