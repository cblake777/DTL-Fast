package DTL::Fast::Template::Expression::Operator::Binary::Minus;
use strict; use utf8; use warnings FATAL => 'all'; 
use parent 'DTL::Fast::Template::Expression::Operator::Binary';
use Carp qw(confess);

$DTL::Fast::Template::Expression::Operator::KNOWN{'-'} = __PACKAGE__;

use Scalar::Util qw(looks_like_number);
use DTL::Fast::Utils qw(has_method);

sub dispatch
{
    my( $self, $arg1, $arg2) = @_;
    my ($arg1_type, $arg2_type) = (ref $arg1, ref $arg2);
    
    if( looks_like_number($arg1) and looks_like_number($arg2))
    {
        return $arg1 - $arg2;
    }
    elsif( $arg1_type eq 'ARRAY' ) # @todo array substitution
    {
        confess 'Arrays substitution not yet implemented';
    }
    elsif( $arg1_type eq 'HASH' )   # @todo hash substitution
    {
        confess 'Hashes substitution not yet implemented';
    }
    elsif( has_method($arg1, 'minus'))
    {
        return $arg1->minus($arg2);
    }
    else
    {
        confess sprintf("Don't know how to substitute %s (%s) from %s (%s)"
            , $arg2 // 'undef'
            , $arg2_type // 'undef'
            , $arg1 // 'undef'
            , $arg1_type // 'undef'
        );
    }
}

1;