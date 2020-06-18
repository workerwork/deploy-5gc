#/bin/bash -
#
# Copyright 2019 baicells Authors.
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

function local_apt() {
    if [ ! -d /opt/repository ];then
        cp -rf apt/repository /opt
    else
        echo "/opt/repository not empty,"
        rm -rf /opt/repository
        cp -rf apt/repository /opt
    fi

    if $(grep -q "^deb file:/opt/repository /" /etc/apt/sources.list);then
	echo "repository exist in /etc/apt/sources.list"
    else
        echo "deb file:/opt/repository /" >> /etc/apt/sources.list
        apt-key add apt/pub/baicells.pub
        apt-get update
    fi
    apt-get install ansible
}

if [[ $1 == "--init" ]]; then
    local_apt
fi

#ansible-playbook ansible/playbooks/install_5gc.yaml
