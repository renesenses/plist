#!/usr/bin/env perl

use Data::Dumper;
use Mac::PropertyList qw(:all);

my %URLS;

#my $plist_file	= "/Users/LochNessIT/Desktop/NEW_BOOK.plist";
my $plist_file	= "/Users/LochNessIT/Library/Safari/Bookmarks.plist";
my $csv_res_url = "/Users/LochNessIT/Desktop/Bookmarks.csv";


#	foreach (keys %$info) {
#    	my $val = $$info{$_};
#    	if (ref $val eq 'ARRAY') {
#      		$val = join(', ', @$val);
#    	} elsif (ref $val eq 'SCALAR') {
#      		$val = '(Binary data)';
#    	}
#		# print $_,"\n";
#    	printf("%-24s : %s\n", $_, $val);
#	}

# my $data  = parse_plist_file( $plist_file );

my $text  = plist_as_string( $data );

my $perl  = $data->as_perl;


sub explore_hash {
	
	my $in_ref = shift;
	
	foreach ( keys ( %$in_ref )) {
		my $val = $$in_ref{$_};
		if ( ref $val eq 'ARRAY' ) {
			for my $new_ref ( @$val ) {
				explore_hash( \$new_ref ); # OR MAYBE \$new_ref
			}
		}		 	 
		elsif ( $_ eq 'URLString' ) {
#			print ("URL is :",$in->{$dict},"\n");
			$URLS{ $val }++;
		}
	}
}

sub pr_sc_URLs {
	
	for my $url ( keys (%URLS) ) {
		print $URLS{$url},"\t",$url,"\n";
	}
}

sub print_Dumper {
	
	open FILE, '+>:utf8', $csv_res_url or die "Can't open '$csv_res_url': $!";
	
	print FILE Dumper($perl);

	close(FILE);	   
}




sub print_URLs {
	
	open FILE, '+>:utf8', $csv_res_url or die "Can't open '$csv_res_url': $!";
	
	for my $url ( keys (%URLS) ) {
		print FILE $url,";",$URLS{$url},"\n";
	}
	close(FILE);	   
}







print "PERL\n";
print ref($perl),"\n";
#print Dumper($perl);

#print "URL\n";
#explore_hash($perl);

print_Dumper;
#pr_sc_URLs;
#print_URLs;
