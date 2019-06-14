load '/opt/bats-support/load.bash'
load '/opt/bats-assert/load.bash'

@test "/usr/bin/entrypoint.sh returns 0" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"pwd && whoami\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "dojo init finished"
  assert_line --partial "/dojo/work"
  refute_output --partial "root"
  assert_equal "$status" 0
}
@test "correct scilab version is installed" {
  run /bin/bash -c "dojo -c Dojofile.to_be_tested \"scilab -version\""
  # this is printed on test failure
  echo "output: $output"
  assert_line --partial "scilab-6.0.2"
  assert_equal "$status" 0
}
