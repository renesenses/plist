#!/usr/bin/env perl

use Data::Dumper;
use Mac::PropertyList qw(:all);

sub print_URL {
	my $in = shift;
	
	for my $dict ( keys ( %{$in} ) ) {
		if ( $dict eq 'URLString' ) {
			print( "KEY : ",$dict,"\n");
			print( "VALUE :",$in->{$dict},"\n");
		}
	}
}


my $plist_file = "/Users/LochNessIT/Desktop/NEW_BOOK.plist";

my $data  = parse_plist_file( $plist_file );

my $text  = plist_as_string( $data );

my $perl  = $data->as_perl;

#print "DATA\n";
#print ref($data),"\n"; # is a Mac::PropertyList::dict object for a safari bookmarks file type as chosen
#print Dumper($data); # 

#print "TEXT\n";
#print ref($text),"\n"; #  empty
#print Dumper($text);

print "PERL\n";
print ref($perl),"\n";
print Dumper($perl);

print "URL\n";
print_URL($perl);
