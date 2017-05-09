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
