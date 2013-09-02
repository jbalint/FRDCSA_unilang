package Org::FRDCSA::UniLang::Messaging::Message;

# ABSTRACT: A message.

use Moose;
use MooseX::Types::DateTime::MoreCoercions qw( DateTime );
use namespace::autoclean;

has 'id' => (
    is       => 'ro',
    isa      => 'Int',
    required => 1
);
has 'sender' => (
    is       => 'ro',
    isa      => 'Str',
    required => 1
);
has 'target' => ( is => 'rw', isa => 'Str' );
has 'createDate' => (
    is       => 'ro',
    isa      => DateTime,
    coerce   => 1,
    required => 1
);
has 'contents'   => ( is => 'rw', isa => 'Str' );
has 'data'       => ( is => 'rw', isa => 'Str' );
has 'dataFormat' => ( is => 'ro', isa => 'Str', default => 'Perl' );
has 'inReplyTo'  => ( is => 'ro', isa => 'Int' );

__PACKAGE__->meta->make_immutable;
1;
