#!/bin/bash
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ============================================================================
if [ $# -lt 3 ]
then
    echo "Usage: bash ./scripts/run_distribute_train_gpu.sh [CONFIG_PATH] [DEVICE_NUM] [VISIABLE_DEVICES(0,1,2,3,4,5,6,7)]"
exit 1
fi
BASEPATH=$(cd "`dirname $0`" || exit; pwd)
export CONFIG_PATH=$1
export CUDA_VISIBLE_DEVICES="$3"
export RANK_SIZE=$2
export DEVICE_NUM=$2

rm -rf train_gpu
mkdir ./train_gpu
cd ./train_gpu || exit
env > env.log

mpirun --allow-run-as-root -n $2 \
    python ${BASEPATH}/../train.py  --device_target="GPU" \
    --swin_config=$CONFIG_PATH \
    --seed=47 > log.txt 2>&1 &
cd ../


