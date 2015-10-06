#!/usr/bin/env perl

use Data::Dumper;
use Mac::PropertyList qw(:all);

my %URLS;

my $plist_file	= "/Users/LochNessIT/Desktop/NEW_BOOK.plist";
#my $plist_file	= "/Users/LochNessIT/Library/Safari/Bookmarks.plist";
my $csv_res_url = "/Users/LochNessIT/Desktop/Bookmarks.csv";

sub explore_hash {
	
	my $in_ref = shift;
	
	for my $dict ( keys ( %{$in_ref} )) {
		print "KEY : ", $dict, " VAL(KEY) : ", ${$in_ref}{$dict},"\n";
		if ( ref(${$in_ref}->{$dict}) eq 'ARRAY' ) {
			for my $vect ( @{ ${$in_ref}->{$dict} } ) {
				explore_hash( \$vect );
			}
		}		 	 
		elsif ( $dict eq 'URLString' ) {
#			print ("URL is :",$in->{$dict},"\n");
			$URLS{ ${$in_ref}->{$dict} }++;
		}
	}
}

sub pr_sc_URLs {
	
	for my $url ( keys (%URLS) ) {
		print $URLS{$url},"\t",$url,"\n";
	}
}

sub print_URLs {
	
	open FILE, '+>:utf8', $csv_res_url or die "Can't open '$csv_res_url': $!";
	
	for my $url ( keys (%URLS) ) {
		print FILE $url,";",$URLS{$url},"\n";
	}
	close(FILE);	   
}



my $data  = parse_plist_file( $plist_file );

my $text  = plist_as_string( $data );

my $perl  = $data->as_perl;



print "PERL\n";
print ref($perl),"\n";
#print Dumper($perl);

#print "URL\n";
explore_hash($perl);

pr_sc_URLs;
#print_URLs;
