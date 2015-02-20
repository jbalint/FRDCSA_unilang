package Org::FRDCSA::UniLang::Agent::Echo;

# ABSTRACT: An agent that sends a reply message containing the same contents it received.

use Moose;
use namespace::autoclean;

use Org::FRDCSA::Platform::Log;

has 'name' => ( is => 'ro', default => 'Echo' );

with 'Org::FRDCSA::UniLang::Agent::MessageProcessingAgent';

has 'logger' =>
  ( is => 'ro', default => sub { Org::FRDCSA::Platform::Log->getLogger } );

=pod

=method B<startup()>

=cut

sub startup {
    my $self = shift;
    $self->logger->debug("startup... ");
}

=pod

=method B<shutdown()>

=cut

sub shutdown {
    my $self = shift;
    $self->logger->debug("shutdown... ");
}

=pod

=method B<processMessage(message)>

=cut

sub processMessage {
    my ( $self, $message ) = @_;
    $self->logger->debug("Processing a message... ");
    print "Got a message! ", $message;
}

__PACKAGE__->meta->make_immutable;
1;
