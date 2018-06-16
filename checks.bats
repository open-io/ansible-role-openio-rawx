#! /usr/bin/env bats

# Variable SUT_IP should be set outside this script and should contain the IP
# address of the System Under Test.

# Tests

@test 'Request /info for a rawx with a specific id ' {
  run curl ${SUT_IP}:6299/info
  echo "output: "$output
  echo "status: "$status
  [[ "${status}" -eq "0" ]]
  [[ "${output}" =~ 'namespace TRAVIS' ]]
  [[ "${output}" =~ 'path /mnt/sdd1/TRAVIS/rawx-99' ]]
}

@test 'Request /stat for a rawx' {
  run curl -s ${SUT_IP}:6200/stat
  echo "output: "$output
  echo "status: "$status
  [[ "${status}" -eq "0" ]]
  [[ "${output}" =~ 'counter req.hits' ]]
  [[ "${output}" =~ 'counter req.hits.raw 0' ]]
}

@test 'Check location by FS id' {
  ID=$(docker exec -ti ${SUT_ID} python -c 'import os,stat; print os.stat("/mnt").st_dev')
  run docker exec -ti ${SUT_ID} grep location /etc/oio/sds/TRAVIS/watch/rawx-0.yml
  echo "output: "$output
  echo "status: "$status
  echo "FS ID: "$ID
  [[ "${status}" -eq "0" ]]
  [[ "${output}" =~ ".${ID}" ]]
}
