#!/usr/bin/env perl

use Data::Dumper;
use Mac::PropertyList qw(:all);

my %URLS;

sub explore_hash {
	
	my $in = shift;
	
	for my $dict ( keys ( $in )) {
#		print "KEY : ", $dict, " VAL(KEY) : ", $in->{$dict},"\n";
		if ( ref($in->{$dict}) eq 'ARRAY' ) {
			for my $vect ( @{ $in->{$dict} } ) {
				explore_hash( $vect );
			}
		}		 	 
		elsif ( $dict eq 'URLString' ) {
#			print ("URL is :",$in->{$dict},"\n");
			$URLS{$in->{$dict}}++;
		}
		else {
	
		}
	}
}

sub print_URLs {
	
	open( FILE, ">:encoding(UTF-8)", $csv_res_url)
    || die "can't open UTF-8 encoded $csv_res_url";
	
	for my $url ( keys (%URLS) ) {
		print FILE $url,";",$URLS{$url},"\n";
	}
	close(FILE);	   
}

my $plist_file	= "/Users/LochNessIT/Library/Safari/Bookmarks.plist";
my $csv_res_url = "/Users/LochNessIT/Desktop/Bookmarks.csv";

my $data  = parse_plist_file( $plist_file );

my $text  = plist_as_string( $data );

my $perl  = $data->as_perl;

#print "DATA\n";
#print ref($data),"\n";
#print Dumper($data);

#print "TEXT\n";
#print ref($text),"\n";
#print Dumper($text);

#print "PERL\n";
#print ref($perl),"\n";
#print Dumper($perl);

#print "URL\n";
explore_hash($perl);

print_URLs;
