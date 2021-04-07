#!/bin/bash
# desc : redis batch insert

for((i=1;i<100;i++))
do
    echo "set k1101$i v3301$i" >> data/redis_batch_insert.txt
done