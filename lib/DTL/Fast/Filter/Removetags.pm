package DTL::Fast::Filter::Removetags;
use strict; use utf8; use warnings FATAL => 'all'; 
use parent 'DTL::Fast::Filter';

$DTL::Fast::FILTER_HANDLERS{'removetags'} = __PACKAGE__;

#@Override
sub parse_parameters
{
    my $self = shift;
    die "No tags to remove specified"
        if not scalar @{$self->{'parameter'}};
    $self->{'tags'} = $self->{'parameter'}->[0];
    return $self;
}

#@Override
sub filter
{
    my $self = shift;  # self
    shift;  # filter_manager
    my $value = shift;
    my $context = shift;
    
    my $tags_re = join '|', (split /\s+/, $self->{'tags'}->render($context));
    
    $value =~ s/<\/?($tags_re)[^>]*?>//gsi;
    
    return $value;
}

1;