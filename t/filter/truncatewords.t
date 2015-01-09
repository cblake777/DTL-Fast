#!/usr/bin/perl
use strict; use warnings FATAL => 'all'; 
use Test::More;use utf8;

use DTL::Fast qw(get_template);
use DTL::Fast::Context;
use Data::Dumper;

my( $template, $test_string, $context);

$context = new DTL::Fast::Context({
});

# @todo some random testing
my $SET = [
    {
        'template' => '{{ "this is a test string"|truncatewords:4 }}',
        'test' => 'this is a test...',
        'title' => 'Truncating',
    },
    {
        'template' => '{{ "this is a test string"|truncatewords:10 }}',
        'test' => 'this is a test string',
        'title' => 'String is shorter than needed for truncting',
    },
];

foreach my $data (@$SET)
{
    is( DTL::Fast::Template->new($data->{'template'}, [])->render($context), $data->{'test'}, $data->{'title'});
    
}

done_testing();
