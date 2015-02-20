package Org::FRDCSA::UniLang::Client::SingleThreadedAgent;

# ASTRACT: Client class for running a single-threaded agent (MessageProcessingAgent)

use Moose;
use POE::Filter::Line;
use Switch;
use Org::FRDCSA::UniLang::Messaging::XMLMessageFilter;

has 'agent' => ( isa => 'Org::FRDCSA::UniLang::Agent::MessageProcessingAgent' );
has 'lineFilter' =>
  ( isa => 'POE::Filter::Line', default => sub { POE::Filter::Line->new } );
has 'messageFilter' => (
    isa     => 'Org::FRDCSA::UniLang::Messaging::XMLMessageFilter',
    default => sub { Org::FRDCSA::UniLang::Messaging::XMLMessageFilter->new }
);

sub on_client_connected {
    my $self      = shift;
    my $agentName = $self->agent->name;
    $self->connection->put("REGISTER $agentName");
    $self->agent->startup;    # TODO pass broker
}

sub on_client_data {
    my ( $self, $event ) = @_;
    my $command = $self->lineFilter->get_one( $event->data );
    return unless $command =~ m/^([A-Z_])+\s*(.*)$/;
    my $commandName = $1;
    my @args = split( $2, m/,\s*/ );
    switch ($command) {
        case "LIST_AGENT_COMMANDS" {

            # TODO return
            die "Can't accept this command yet";
        }
        case "ACCEPT_MESSAGE" {

            # swap filters to read message
            $self->messageFilter->get_one_start(
                $self->lineFilter->get_pending );
            $self->lineFilter( $self->lineFilter->clone );

            # read stream until we get a complete message
            my $message;
            $message = $self->messageFilter->get_one( $self->next->data )
              until $message;

            # swap streams back to read next command
            $self->lineFilter->get_one_start(
                $self->messageFilter->get_pending );
            $self->messageFilter( $self->messageFilter->clone );

            # deliver message to agent
            my $response = $self->agent->processMessage($message);
        }
        case "SHUTDOWN" {
            $self->agent->shutdown;
            $self->stop;
        }
        case "PING" {

        }
    }
}

__PACKAGE__->meta->make_immutable;
1;
