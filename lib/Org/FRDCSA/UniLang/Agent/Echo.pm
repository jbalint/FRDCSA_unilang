package Org::FRDCSA::UniLang::Agent::Echo;

# ABSTRACT: An agent that sends a reply message containing the same contents it received.

use Moose;
use namespace::autoclean;

use Org::FRDCSA::Platform::Log;

with 'Org::FRDCSA::UniLang::Agent::MessageProcessingAgent';

has 'name' => ( is => 'ro', default => 'Echo' );

has 'logger' =>
  ( is => 'ro', default => sub { Org::FRDCSA::Platform::Log->getLogger() } );

=pod

=method B<startup()>

=cut

sub startup {
}

=pod

=method B<shutdown()>

=cut

sub shutdown {
}

=pod

=method B<processMessage(message)>

=cut

sub processMessage {
}

__PACKAGE__->meta->make_immutable;
1;
