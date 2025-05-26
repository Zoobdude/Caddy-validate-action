#!/usr/bin/perl

my $input;
$input = $_ while (<STDIN>);

my $filePath = $ENV{'CADDYFILE'};

if ($input =~ /Valid configuration/) {
    print "Valid configuration\n";
    exit 0;

} elsif ($input =~ m{^Error: adapting config using caddyfile: }) {
    our $error = substr($input, 40); # Extract the error message (remove the prefix)

} else {
    print "::error title=Unknown error:: $input";
    exit 1;
}

# Extract the line number from the error message if it exists
if ($error =~ m{/etc/caddy/Caddyfile:(\d+)}) {
    our $line_number = $1;
}

$error =~ s{/etc/caddy/Caddyfile}{$filePath}; # Replace the container file path with the actual file path

if ($line_number) {
    our $error_msg = "::error file=$filePath,line=$line_number" . "::" . $error;
} else {
    # If no line number is found, just report the error
    our $error_msg = "::error file=$filePath" . "::" . $error;
}

print $error_msg;
exit 1;