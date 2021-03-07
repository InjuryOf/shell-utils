#!/bin/bash
# desc : batch remove branch
# 1、查询当前仓库远程分支列表
# 2、查找符合匹配规则分支 || 筛选分支最后一个commit 时间点超过30天的
# 3、遍历筛选后的分支列表，将符合条件分支记录代操作日志
# 4、遍历分支列表，执行远程分支操作及本地分支操作，并将结果追加到文件内
# 筛选条件：现支持根据指定时间、前缀匹配、分支白名单三种方式

echo "路径：$0"
code_origin_url="/Users/yanglei/yanglei/"
origin_list=("service.trade")
# 前缀匹配条件
filter=$1
# 超时时间（30天）
limit=`expr 3600 \* 24 \* 30 `
echo "筛选条件：$filterr"
# 分支白名单
branch_write_list=("master")

for item in $origin_list
do
    echo "======【仓库信息：$item 】======";
    cd $code_origin_url$item
    `git fetch`
    `git checkout master`

    # 获取匹配分支列表 
    if [ -z $filter ]
    then
        branch_list=`git branch -a`
    else
        branch_list=`git branch -a | grep $filter`
    fi

    # 遍历分支列表
    for branch in $branch_list
    do
        echo ">>>>>>(1)原始分支信息：$branch <<<<<<"
        
        # 如果存在remotes/origin前缀，则去除远程仓库前缀
        origin_check=$(echo $branch | grep "remotes/origin")
        if [ "$origin_check" != "" ]
        then
            branch_length=${#branch}
            total=`expr $branch_length - 15`
            new_branch=${branch:15:total}
        else
            new_branch=${branch}
        fi
        echo "(2)转换分支信息：$new_branch"
        
        # 检查分支是否存在分支白名单中
        if [[ "${branch_write_list[@]}"  =~ "${new_branch}" ]]; 
        then
            echo "(exit)该分支命中白名单"
            continue
        fi

        # 查找分支最后一个commit时间是否大于1个月
        branch_last_commit_date=`git show -s --format=%at $branch` 
        current_date=`date +%s`
        diff=`expr $current_date - $branch_last_commit_date`
        echo "(3)时间差：$diff - $limit"
        if [ $diff -gt $limit ]
        then
            echo "(4)该分支超过一个月未提交"
            # echo "替换后的分支名： $new_branch";
            # 执行分支处理、删除远程分支成功后删除本地分支
            origin_delete_result=`git push origin --delete $new_branch`
            if [ $? = "0" ]
            then
                echo "(5)删除远程分支：$?"
                # local_delete_result=`git branch -D $new_branch`
                # echo "删除本地分支：$?"
                continue              
            fi
        else
            echo "(exit)该分支一个月内提交过"
            continue
        fi
    done
done