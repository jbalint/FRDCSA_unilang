package Org::FRDCSA::UniLang::Agent::MessageProcessingAgent;

use Moose::Role;
use namespace::autoclean;

with 'Org::FRDCSA::UniLang::Agent::Agent';

requires 'processMessage';
requires 'startup';
requires 'shutdown';

1;
