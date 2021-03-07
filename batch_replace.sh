#!/bin/bash
# desc：批量替换文件内容字符

dir_path=$1
match_str=$2
replace_str=$3

if [ -z "$dir_path" ]; then
    echo "请指定替换目录地址！"
    exit 1
elif [ -z "$match_str" ]; then
    echo "请输入匹配字符串！"
    exit 1
elif [ -z "$replace_str" ]; then
    echo "请输入替换字符串！"
    exit 1
fi

# mac command
grep -rl "$match_str" $dir_path  | xargs sed -i "" "s/$match_str/$replace_str/g"

# linux command
#grep -rl "$match_str" $dir_path  | xargs sed -i "s/$match_str/$replace_str/g"