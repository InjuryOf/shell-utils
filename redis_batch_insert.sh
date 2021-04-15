#!/bin/bash
# desc : redis batch insert

# 批量生成hash插入语句
#for((i=1;i<=10;i++))
#do
#   for((j = 1; j<=1000;j++))
#   do
#        echo "hset 1001$i $j 3301$i$j" >> data/redis_batch_insert.txt
#   done
#done

# 批量生成string插入语句
 for((i=1;i<=1000000;i++))
 do
     echo "set k1101$i v3301$i" >> data/redis_batch_insert.txt
 done
