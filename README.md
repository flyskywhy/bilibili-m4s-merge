
-------------------------
bilibili m4s merge
--
>bilibili 下载后的视频是 video.m4s 和 audio.m4s 格式，将其合并、转换为 mp4

起因
--
bilibili 客户端可以下载视频后观看，但是于个人而言还是有很多问题，比如目录结构混乱难管理、占用手机巨量内部存储空间等等。

所以，全部导出到电脑，然后在电脑上用本脚本（内部自动调用 ffmpeg ）合并，而且可以合并单个视频和合集视频。

使用&说明
--
```shell
./bilibili_video_merge.sh
```

目录结构
--
```shell
# 结构大致如下
├── 36210854
├── bilibili_video_merge.sh
├── merged
└── README.md
```
数字文件夹是 av 编号的缓存视频，安卓手机下载位置：存储卡根目录 `/Android/data/tv.danmaku.bili/download` ，结构如下图：

![bilibili_video_merge_01](https://raw.githubusercontent.com/wjsaya/BlogPictures/master/bilibili_video_merge_01.png)

直接把这里的文件夹弄到电脑上就好，和 bilibili_video_merge.sh 放在同一屋檐（同一目录）下。

执行脚本后，有两个选项：

1，脚本会检查目录是否存在，存在就执行合并并输出合并进度，如果目录不存在，那么直接提示不存在并返回。如下图：

![bilibili_video_merge_02](https://raw.githubusercontent.com/wjsaya/BlogPictures/master/bilibili_video_merge_02.png)

2，脚本会遍历当前目录下的所有纯数字文件夹并按照特定的目录格式找文件进行转换，因此在这个目录下请不要自己新建其他的纯数字文件夹。

当转换完毕，脚本会提示转换完毕，此时就可以去脚本目录下的 `merged` 下找转换后的文件了，这里面的文件名已经转换。
