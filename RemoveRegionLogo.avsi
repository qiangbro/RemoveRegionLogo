
# 主要用于掩盖不透明的logo。
# 原理是取logo区域矩形边界的图像向logo区域中心进行延伸填充，以掩盖logo区域

# 用途同Virtualdub的RegionRemove.vdf，
# 与它的区别是：① 使用原生avisynth脚本实现。支持YV12色彩空间。
#               ② 功能可能稍欠缺一点，但能满足一般需求。

# 参数说明
# x, y, width, height 是logo区域的坐标。
#               可借助aviutl的logoscan插件确定坐标。
# start,end是logo出现的帧区间。
#               默认start=0,end=0，表示取全部帧。
# fade, fade_in, fade_out 用于产生渐入渐出的效果。
#               以添加的渐变帧数计数，请确保logo出现的之前和之后有足够的帧进行渐变。
#               默认fade_in=fade=0，fade_out=fade=0
# soft_edges 是否软化边缘。
#               若要启用该项，logo区域的坐标应向外扩大约8像素以保证logo被安全覆盖。

# author：mikey
# qhzq88@gmail.com
# 所在团队：有村花纯字幕组
# last modified : 2017.05.09

function RemoveRegionLogo(clip src, 
\ int x, int y, int width, int height, 
\ int "start", int "end", int "fade", int "fade_in", int "fade_out", 
\ bool "ignore_top", bool "ignore_bottom", bool "ignore_left", bool "ignore_right",
\ bool "soft_edges")
{

start= Default(start, 0)
end= Default(end, 0)

fade     = Default(fade, 0)
fade_in  = start!=0 ? Default(fade_in, fade) : 0
fade_out = end!=0 ? Default(fade_out, fade) : 0

ignore_top    = Default(ignore_top, false)
ignore_bottom = Default(ignore_bottom, false)
ignore_left   = Default(ignore_left, false)
ignore_right  = Default(ignore_right, false)

soft_edges = Default(soft_edges, false)


Assert(start>=0,"start must >= 0")
end = end<0 ? start + (-end) -1 : end

bit = 2

trim_start = start - fade_in
trim_end = end + fade_out

logo_src = src.Trim(trim_start, trim_end)
empty = BlankClip(src, color=$ffffff, pixel_type="RGB32")


top    = ignore_top ? empty : logo_src.Crop(x,y,width,bit)
bottom = ignore_bottom ? empty : logo_src.Crop(x,y+height,width,bit)
piece1 = ignore_top&&ignore_bottom ? empty \
    : ignore_top==false&&ignore_bottom==false ? StackVertical(top, bottom) \
    : ignore_top ? bottom \
    : top

left   = ignore_left ? empty : logo_src.Crop(x,y,bit,height)
right  = ignore_right ? empty : logo_src.Crop(x+width,y,bit,height)
piece2 = ignore_left&&ignore_right ? empty \
    : ignore_left==false&&ignore_right==false ? StackHorizontal(left,right) \
    : ignore_left ? right \
    : left


box1 = ignore_top==false||ignore_bottom==false ? piece1.PointResize(width,2*bit).Blur(1.0).BilinearResize(width,height) : empty
box2 = ignore_left==false||ignore_right==false ? piece2.PointResize(2*bit,height).Blur(1.0).BilinearResize(width,height) : empty

delogo = ignore_top&&ignore_bottom ? box2 \
    : ignore_left&&ignore_right ? box1 \
    : Merge(box1,box2)


mask = BlankClip(delogo, color=$ffffff, pixel_type="RGB32")

mask = soft_edges ? mask.AddBorders(4, 4, 4, 4, color=$000000)
\.Blur(1.50).Blur(1.50).Blur(1.50).Blur(1.50).Blur(1.50).Blur(1.50).Blur(1.50).Blur(1.50).Blur(1.50).Blur(1.50).Blur(1.50).Blur(1.50)
\.Crop(2,2,-2,-2).BilinearResize(width,height)
\:mask

mask = fade_out==0 ? mask : mask.FadeOut(fade_out, color=$000000)
mask = fade_in==0? mask : mask.FadeIn(fade_in, color=$000000)

delogo_clip = logo_src.Overlay(delogo,x,y,mask)

new_clip = delogo_clip
new_clip = trim_start>0 ? src.Trim(0, -trim_start) + new_clip : new_clip
new_clip = trim_start+logo_src.FrameCount != src.FrameCount() ? new_clip + src.Trim(trim_start+logo_src.FrameCount, 0) : new_clip

Assert(src.FrameCount() == new_clip.FrameCount() , "internal error. frame count not equal.")

return new_clip

}


# example
#~ RemoveRegionLogo(244,36,948,158)
#~ RemoveRegionLogo(462,114,510,62, 955,1554, fade=20)
#~ RemoveRegionLogo(270,52,910,62, 955,1554, fade=20, soft_edges=true)
