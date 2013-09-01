package Org::FRDCSA::UniLang::Messaging::XMLMessageFilter;

# ABSTRACT: manages as one big string

use Moose;
use XML::Twig;
use namespace::autoclean;

use Org::FRDCSA::Platform::Log;
use Org::FRDCSA::UniLang::Messaging::Message;

has 'buffer' => ( is => 'rw', isa => 'Str' );

has 'logger' =>
  ( is => 'ro', default => sub { Org::FRDCSA::Platform::Log->getLogger } );

sub clone {
    die "Can't clone";
}

sub get_one_start {
    my ( $self, $args ) = @_;
    my $buf = $self->buffer;

    # append chunks to internal buffer
    for my $x (@$args) {
        $buf .= $x;
    }
    $self->buffer($buf);
}

sub get_one {
    my $self = shift;
    if ( $self->buffer =~ m#\s*(<message>.*?</message>)\s*(.*)#ms ) {

        # save remaining data
        $self->buffer($2);

        # parse matched message
        my $parser = XML::Twig->new;
        $parser->parse($1);
        my $messageElement = $parser->root;
        my @items          = (
            'id',   'sender',     'target', 'createDate',
            'data', 'dataFormat', 'inReplyTo'
        );
        my %messageHash;
        map {
            my $child = $messageElement->first_child($_);
            $messageHash{$_} = $child->text if $child;
        } @items;

        return Org::FRDCSA::UniLang::Messaging::Message->new( \%messageHash );

        # TODO improve object serialization method
        #		my $dataFormat;
        #		if ($dataFormat eq "perl") {
        #			my $VAR1 = eval $dataFormat;
        #		} else {
        #			die "unknown format " . $dataFormat;
        #		}
    }
    else {
        return undef;
    }
}

# sub get

# sub put

sub get_pending {
    my $self = shift;
    return $self->buffer eq "" ? [] : [ $self->buffer ];
}

__PACKAGE__->meta->make_immutable;
1;
