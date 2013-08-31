package Org::FRDCSA::UniLang::Messaging::Message;

# ABSTRACT: A message.

use Moose;
use MooseX::Types::DateTime qw(DateTime);
use namespace::autoclean;

has 'id'         => ( is => 'ro', isa => 'Str' );
has 'sender'     => ( is => 'ro', isa => 'Str' );
has 'receiver'   => ( is => 'ro', isa => 'Str' );
has 'createdate' => ( is => 'ro', isa => 'DateTime' );

__PACKAGE__->meta->make_immutable;
1;
