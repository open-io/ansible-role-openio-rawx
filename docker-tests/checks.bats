#! /usr/bin/env bats

# Variable SUT_IP should be set outside this script and should contain the IP
# address of the System Under Test.

# Tests

@test 'LEGACY: Request /info for a rawx with a specific id ' {
  run curl ${SUT_IP}:6200/info
  echo "output: "$output
  echo "status: "$status
  [[ "${status}" -eq "0" ]]
  [[ "${output}" =~ 'namespace TRAVIS' ]]
  [[ "${output}" =~ 'path /var/lib/oio/sds/TRAVIS/rawx-0' ]]
}

@test 'LEGACY: Request /stat for a rawx' {
  run curl -s ${SUT_IP}:6200/stat
  echo "output: "$output
  echo "status: "$status
  [[ "${status}" -eq "0" ]]
  [[ "${output}" =~ 'counter req.hits' ]]
  [[ "${output}" =~ 'counter req.hits.raw 0' ]]
}

@test 'GO: Request /info for a rawx with a specific id ' {
  run curl ${SUT_IP}:6201/info
  echo "output: "$output
  echo "status: "$status
  [[ "${status}" -eq "0" ]]
  [[ "${output}" =~ 'namespace TRAVIS' ]]
  [[ "${output}" =~ 'path /var/lib/oio/sds/TRAVIS/rawx-1' ]]
}

@test 'GO: Request /stat for a rawx' {
  run curl -s ${SUT_IP}:6201/stat
  echo "output: "$output
  echo "status: "$status
  [[ "${status}" -eq "0" ]]
  [[ "${output}" =~ 'counter req.hits' ]]
  [[ "${output}" =~ 'counter req.hits.raw 0' ]]
}
