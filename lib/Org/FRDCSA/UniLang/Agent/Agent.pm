package Org::FRDCSA::UniLang::Agent::Agent;

# ABSTRACT: Base interface for all agent implementations.

use Moose::Role;
use namespace::autoclean;

requires 'name';

1;
