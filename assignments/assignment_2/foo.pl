#!/usr/bin/perl

use strict;
use warnings;

use File::Slurp;
use Data::Dumper;

sub get_url {
    my ($url, $name) = @_;

    return "<a href=\"".$url."\" target=\"_blank\">".$name."</a>";
}

my %names_hash = ();
my @names = read_file("names");
foreach my $name (@names) {
    chomp $name;
    my @split_array = split('\|', $name);
    $names_hash{$split_array[0]} = [$split_array[1], $split_array[2]];
}

# print Dumper \%names_hash;

my @lines = read_file("orig");
# my %used_names = ();
# foreach my $l (@lines) {
#     if($l =~ /::(.*)::/) {
#         foreach my $s (split(",",$1)) {
#             $l =~ s/$s/$names_hash{$s}/;
#             $used_names{$names_hash{$s}} = $s;
#         }
#         # print "$l\n";
#     }
# }

# # print Dumper \%used_names;

# foreach my $name (sort { $used_names{$a} <=> $used_names{$b} } keys %used_names) {
#     printf "%s:%s:\n",$used_names{$name}, $name;
# }

# my %uniq_names = ();



# foreach my $uniq (keys %uniq_names) {
#     chomp $uniq;
# }

# foreach my $num (keys %names_hash) {
#     if (exists $uniq_names{$names_hash{$num}}) {
#         print "$num ".$names_hash{$num}."\n";
#     }
# }

my @converted = ();

foreach my $l (@lines) {
    if($l =~ /::(.*)::/) {
        foreach my $s (split(",",$1)) {
            my $string = get_url($names_hash{$s}->[1], $names_hash{$s}->[0]);
            $l =~ s/$s/$string/;
        }
        # print "$l\n";
    }
    chomp $l;
    push(@converted, $l);
}

print  join("\n", @converted);

# print Dumper \@names;
