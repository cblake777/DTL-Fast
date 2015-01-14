package DTL::Fast::Template::Filter::Ru::Pluralize;
use strict; use utf8; use warnings FATAL => 'all'; 
use parent 'DTL::Fast::Template::Filter::Pluralize';
use Carp qw(confess);

$DTL::Fast::Template::FILTER_HANDLERS{'pluralize'} = __PACKAGE__;

use DTL::Fast::Template::Variable;

#@Override
sub parse_parameters
{
    my $self = shift;
    push @{$self->{'parameter'}}, '""' # specify suffix for one, two and five
        if not scalar @{$self->{'parameter'}};
    $self->{'suffix'} = DTL::Fast::Template::Variable->new($self->{'parameter'}->[0]);
    return $self;
}

sub pluralize
{
    my $self = shift;
    my $value = shift;
    my $suffix = shift;
    
    my $suffix_one = shift @$suffix // '';
    my $suffix_two = shift @$suffix // '';
    my $suffix_five = shift @$suffix // $suffix_two;
        
    my $last_digit = substr int($value), -1;
    my $amount = abs $value;
    
    if( $amount >= 10 and $amount <= 20 ) {
        $value = $suffix_five;
    }
    elsif( $last_digit == 1 ) {
        $value = $suffix_one;
    }
    elsif( $last_digit >= 2 and $last_digit <= 4 ) {
        $value = $suffix_two;
    }
    else{
        $value = $suffix_five;
    }    
    
    return $value;
    
}

1;