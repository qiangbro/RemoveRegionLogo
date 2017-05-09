# RemoveRegionLogo

主要用于掩盖不透明的logo。
原理是取logo区域矩形边界的图像向logo区域中心进行延伸填充，以掩盖logo区域

用途同Virtualdub的RegionRemove.vdf，
与它的区别是：① 使用原生avisynth脚本实现。支持YV12色彩空间。
               ② 功能可能稍欠缺一点，但能满足一般需求。


# 参数说明
 
 x, y, width, height 是logo区域的坐标。
               可借助aviutl的logoscan插件确定坐标。
               
 start,end是logo出现的帧区间。
              默认start=0,end=0，表示取全部帧。
              
 fade, fade_in, fade_out 用于产生渐入渐出的效果。
               以添加的渐变帧数计数，请确保logo出现的之前和之后有足够的帧进行渐变。
               默认fade_in=fade=0，fade_out=fade=0
               
 soft_edges 是否软化边缘。
               若要启用该项，logo区域的坐标应向外扩大约8像素以保证logo被安全覆盖。

------------
 author：mikey
 qhzq88@gmail.com
 所在团队：有村花纯字幕组


# 用例
sample1

<img src="https://cloud.githubusercontent.com/assets/4646469/25834226/0b9afd18-34a9-11e7-87b1-8f5c29a17452.jpg" alt="" width="400"/><img src="https://cloud.githubusercontent.com/assets/4646469/25834232/11cc89cc-34a9-11e7-9550-34db8d44ef8a.jpg" alt="" width="400"/>

sample2

<img src="https://cloud.githubusercontent.com/assets/4646469/25834254/21befbc6-34a9-11e7-9ecc-73abb593986a.jpg" alt="" width="400"/><img src="https://cloud.githubusercontent.com/assets/4646469/25834233/11fea3e4-34a9-11e7-97a6-bc5db3a25472.jpg" alt="" width="400"/>

sample2

<img src="https://cloud.githubusercontent.com/assets/4646469/25834255/24ad1b60-34a9-11e7-83d2-e741ab380d9f.jpg" alt="" width="400"/><img src="https://cloud.githubusercontent.com/assets/4646469/25834234/12245bca-34a9-11e7-96c7-d524a3bacfc0.jpg" alt="" width="400"/>
