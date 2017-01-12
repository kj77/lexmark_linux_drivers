#!/usr/bin/perl -w
use strict;

open FILE, "<", "/etc/apparmor.d/usr.sbin.cupsd" or die $!;
my @lines = <FILE>;
close FILE;
foreach my $line (@lines)
{
    if (index($line, "/usr/lexinkjet/** Ux") >= 0)
    {
         print "Apparmor cupsd exception already done.\n";
         exit 0;
    }
}
open FILE, ">", "/etc/apparmor.d/usr.sbin.cupsd" or die $!;
my $marker = 0;
my $mark = 0;
foreach my $line (@lines)
{
    chomp($line);
    my $string = $line;
    my $n = index($line, "/usr/sbin/cupsd");
    if ($n >= 0)
    {
        $mark = 1;
        $string = substr($line, $n+15, length($line)-$n-15);
        print FILE substr($line, 0, $n+15);
    }
    if ($marker == 3)
    {
        print FILE "$line\n";
    }
    else
    {
        while ($string =~ /(.)/g) 
        {
            if ($1 eq '{')
            {
                $marker++;
                if ($mark == 1)
                {
                    $mark = 2;
                }
            }
            if ($1 eq '}')
            {
                $marker--;
                if ($marker == 0 && $mark == 2)
                {
                    print FILE "  # adding lexmark exception\n";
                    print FILE "  /usr/lexinkjet/** Ux,\n";
                    print FILE "  /usr/local/lexmark/** Ux,\n";
                    $marker = 3;
                }
            }
            print FILE $1;
        }
        print FILE "\n";
    }
}
close FILE;
print "Apparmor cupsd exception done.\n";
