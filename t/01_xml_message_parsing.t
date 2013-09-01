
use strict;
use warnings;
use Test::More;
use Data::Dumper;

require_ok('Org::FRDCSA::UniLang::Messaging::XMLMessageFilter');

my $testData1 = <<TESTDATA1;
<message>
<id>400</id>
<sender>a test script</sender>
<target>Myself, actually</target>
<createDate>2013-09-01 03:36:39</createDate>
<data></data>
<dataFormat></dataFormat>
</message>

TESTDATA1

my $filter = Org::FRDCSA::UniLang::Messaging::XMLMessageFilter->new;
$filter->get_one_start( [$testData1] );
my $message = $filter->get_one;

#is( [], $filter->get_pending );

done_testing();
