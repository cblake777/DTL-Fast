package DTL::Fast::Template::FilterManager;
use strict; use utf8; use warnings FATAL => 'all'; 

use DTL::Fast::Template;

sub new
{
    my $proto = shift;
    my $filters = shift;
    
    my $self = bless
    {
        'filters' => []
    }, $proto;
    
    if( $filters )
    {
        if( ref $filters eq 'ARRAY' )
        {
            $self->add_filters($filters);
        }
        else
        {
            $self->parse_filters($filters);
        }
    }
    
    return $self;
}

sub filter
{
    my $self = shift;
    my $value = shift;
    my $context = shift;
    
    $self->{'safe'} = 0;
    
    foreach my $filter (@{$self->{'filters'}})
    {
        $value = $filter->filter($self, $value, $context)
            if defined $filter;
    }
    
    return $value;
}

sub parse_filters
{
    my $self = shift;
    my $filter_string = shift;
    
    $filter_string =~ s/(^\s+|\s+$)//gsi;
    return $self->add_filters([split /\|+/, $filter_string]);
}

sub add_filters
{
    my $self = shift;
    my $filter_names = shift;

    foreach my $filter_name (@$filter_names)
    {
        $self->add_filter($filter_name);
    }
    return $self;
}

sub add_filter
{
    my $self = shift;
    my $filter_name = shift;
    
    my @arguments = split ':', $filter_name;
    $filter_name = shift @arguments;

    if( exists $DTL::Fast::Template::FILTER_HANDLERS{$filter_name} )
    {
        push @{$self->{'filters'}}, $DTL::Fast::Template::FILTER_HANDLERS{$filter_name}->new(\@arguments);
    }
    else
    {
        warn "Unknown filter: $filter_name.";
    }
    
    return $self;
}

sub is_safe{ return shift->{'safe'}; }

1;