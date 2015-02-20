
use strict;
use warnings;
use Test::More;
use Data::Dumper;

require_ok('Org::FRDCSA::UniLang::Messaging::XMLMessageFilter');

my ( $filter, $message );

############################################################
# First test parses a basic message in XML format
my $testData1 = <<TESTDATA1;
<message>
<id>400</id>
<sender>a test script</sender>
<target>Myself, actually</target>
<createDate>2013-09-01T03:36:39</createDate>
<data></data>
<dataFormat></dataFormat>
</message>

TESTDATA1

$filter = Org::FRDCSA::UniLang::Messaging::XMLMessageFilter->new;
$filter->get_one_start( [$testData1] );
$message = $filter->get_one;

# check details
is( $message->{id},         400 );
is( $message->{sender},     'a test script' );
is( $message->{target},     'Myself, actually' );
is( $message->{createDate}, '2013-09-01T03:36:39' );
is( $message->{data},       '' );
is( $message->{dataFormat}, '' );
is( $message->{inReplyTo},  undef );

# make sure buffer is empty
is( $filter->get_pending, undef );

############################################################
# Second test parses includes slightly more than one complete message
my $testData2 = <<TESTDATA2;
<message>
<id>401</id>
<sender>another test script</sender>
<target>Myself, actually</target>
<createDate>2013-09-01T03:36:39</createDate>
<data></data>
<dataFormat></dataFormat>
</message>

<message>
<id>401</id>
<sender>a test script</sen
TESTDATA2

$filter = Org::FRDCSA::UniLang::Messaging::XMLMessageFilter->new;
$filter->get_one_start( [$testData2] );
$message = $filter->get_one;

# check details (same as above)
is( $message->{id},         401 );
is( $message->{sender},     'another test script' );
is( $message->{target},     'Myself, actually' );
is( $message->{createDate}, '2013-09-01T03:36:39' );
is( $message->{data},       '' );
is( $message->{dataFormat}, '' );
is( $message->{inReplyTo},  undef );

# make sure buffer is NOT empty
ok( $filter->get_pending->[0] =~ m#^<message>.*</sen#ms );

# TODO test with two messages

done_testing();
