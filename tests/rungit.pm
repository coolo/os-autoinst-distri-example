# Copyright (C) 2020 SUSE LLC
#
# SPDX-Identifier: CC0-1.0

use base 'basetest';
use strict;
use testapi;

sub run {
    wait_serial("Welcome to openSUSE", 300);
    assert_script_run('git clone https://github.com/openSUSE/openSUSE-release-tools.git repo');
    assert_script_run('cd repo');
    assert_script_run('sed -i -e "s,../..:,$PWD:," dist/ci/docker-compose.yml');
    assert_script_run('docker-compose -f dist/ci/docker-compose.yml run flaker', timeout => 1200);
    assert_script_run('docker-compose -f dist/ci/docker-compose.yml run test', timeout => 1200);
}

1;
