use strict;
use warnings;
use Test::More;

BEGIN {
    plan skip_all => 'backends required' if(!-f 'thruk_local.conf' and !defined $ENV{'CATALYST_SERVER'});
    plan tests => 265;
}

BEGIN {
    use lib('t');
    require TestUtils;
    import TestUtils;
}
BEGIN { use_ok 'Thruk::Controller::notifications' }

my $testcontact     = TestUtils::get_test_user();
my ($host,$service) = TestUtils::get_test_service();

my $pages = [
    { url => '/thruk/cgi-bin/notifications.cgi',                                    like => 'All Hosts and Services' },
    { url => '/thruk/cgi-bin/notifications.cgi?contact='.$testcontact,              like => 'Contact Notifications' },
    { url => '/thruk/cgi-bin/notifications.cgi?host='.$host,                        like => 'Host Notifications' },
    { url => '/thruk/cgi-bin/notifications.cgi?host='.$host."&service=".$service,   like => 'Service Notifications' },
    { url => '/thruk/cgi-bin/notifications.cgi?contact='.$testcontact,              like => 'Contact Notifications' },
    { url => '/thruk/cgi-bin/notifications.cgi?contact=all&type=0&archive=1',       like => 'Contact Notifications' },
    { url => '/thruk/cgi-bin/notifications.cgi?contact=all&type=0',                 like => 'Contact Notifications' },
    { url => '/thruk/cgi-bin/notifications.cgi?contact=all&type=2',                 like => 'Contact Notifications' },
    { url => '/thruk/cgi-bin/notifications.cgi?contact=all&type=512',               like => 'Contact Notifications' },
    { url => '/thruk/cgi-bin/notifications.cgi?contact=all&type=4',                 like => 'Contact Notifications' },
    { url => '/thruk/cgi-bin/notifications.cgi?contact=all&type=8',                 like => 'Contact Notifications' },
    { url => '/thruk/cgi-bin/notifications.cgi?contact=all&type=16',                like => 'Contact Notifications' },
    { url => '/thruk/cgi-bin/notifications.cgi?contact=all&type=32',                like => 'Contact Notifications' },
    { url => '/thruk/cgi-bin/notifications.cgi?contact=all&type=2048',              like => 'Contact Notifications' },
    { url => '/thruk/cgi-bin/notifications.cgi?contact=all&type=1024',              like => 'Contact Notifications' },
    { url => '/thruk/cgi-bin/notifications.cgi?contact=all&type=64',                like => 'Contact Notifications' },
    { url => '/thruk/cgi-bin/notifications.cgi?contact=all&type=128',               like => 'Contact Notifications' },
    { url => '/thruk/cgi-bin/notifications.cgi?contact=all&type=256',               like => 'Contact Notifications' },
    { url => '/thruk/cgi-bin/notifications.cgi?contact=all&type=4096',              like => 'Contact Notifications' },
    {
      url => '/thruk/cgi-bin/notifications.cgi?start=2010-03-02+00%3A00%3A00&end=2010-03-03+00%3A00%3A00',
      like => 'All Hosts and Services'
    },
    {
      url => '/thruk/cgi-bin/notifications.cgi?start=2010-03-02+00%3A00%3A00&end=2010-03-03+00%3A00%3A00&oldestfirst=on',
      like => 'All Hosts and Services'
    },
];

for my $url (@{$pages}) {
    TestUtils::test_page(
        'url'     => $url->{'url'},
        'like'    => $url->{'like'},
    );
}


$pages = [
# Excel Export
    '/thruk/cgi-bin/notifications.cgi?view_mode=xls',
];

for my $url (@{$pages}) {
    TestUtils::test_page(
        'url'          => $url,
        'content_type' => 'application/x-msexcel',
    );
}
