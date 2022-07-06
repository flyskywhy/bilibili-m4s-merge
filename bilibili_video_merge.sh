#!/usr/bin/env bash
# @Filename: bilibili_video_merge.sh
# @Author:	wjsaya(http://www.wjsaya.top)
# @Date:	2019-06-25 10:18:36
# @Last Modified by:	Li Zheng (flyskywhy@gmail.com)
# @Last Modified time:	2022-07-06


function do_merge() {
    # do_merge args1
    # args1 为想要合并的视频合集的相对路径
    counter=0
    MERGE_DIR=$1

    if [ ! -d $MERGE_DIR ]
    then
        echo "指定目录：[$MERGE_DIR]不存在，请检查"
        return -1
    fi

    sub_dir_number=`ls -l $MERGE_DIR | grep "^d" -c`

    for sub_dir in `ls $MERGE_DIR | sort -n`
    # 遍历目录，获取每个分p的相对路径
    do # 进入av编号目录
        merge_sub_dir=$MERGE_DIR/$sub_dir

        av_title=`cat $merge_sub_dir/entry.json | jq -r .title | sed "s/\// /g"`
        av_type_tag=`cat $merge_sub_dir/entry.json | jq -r .type_tag`
        av_page=`cat $merge_sub_dir/entry.json | jq -r .page_data.page`
        av_part=`cat $merge_sub_dir/entry.json | jq -r .page_data.part | sed "s/\// /g"`

        in_path=$merge_sub_dir/$av_type_tag

        if [ $sub_dir_number -gt 1 ]
        then
            out_path=$ROOT_PATH/$av_title
            out_file="$out_path/$av_page $av_part.mp4"
        else
            out_path=$ROOT_PATH
            out_file="$out_path/$av_title $av_part.mp4"
        fi

        echo "开始合并 [$in_path/] 为 $out_file"

        if [ ! -d $out_path ]
        then
            mkdir -p $out_path
        fi

        ffmpeg -i $in_path/video.m4s -i $in_path/audio.m4s -c copy -y -- "$out_file"

        let counter+=1
    done
        echo "#####$av_title全部转换完毕，共 $counter 个分 p #####"
}


# 合并后存放相对路径
ROOT_PATH=merged

echo -e "1: 合并单个合集\n2: 合并当前目录下所有合集\n"
read -p "请选择: " SW
if [ "1" == $SW ];then
    read -p "请输入想要合并的合集目录名: " collection
    do_merge $collection
elif [ "2" == $SW ];then
    for collection in `ls | grep -E ^[0-9]+&`
    # av编号最小是个位数，因此直接匹配纯数字文件夹。
    do
        do_merge $collection
    done
else
    echo "error"
fi
