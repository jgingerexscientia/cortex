#!/bin/bash

# Copyright 2021 Cortex Labs, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")"/.. >/dev/null && pwd)"

function run_go_tests() {
  (cd $ROOT && go test ./... && echo "go tests passed")
}

function run_python_tests() {
  docker build $ROOT -f $ROOT/images/test/Dockerfile -t cortexlabs/test
  docker run cortexlabs/test
}

cmd=${1:-""}

if [ "$cmd" = "go" ]; then
  run_go_tests
elif [ "$cmd" = "python" ]; then
  run_python_tests
else
  run_go_tests
  run_python_tests
fi
