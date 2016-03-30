# HBB_DataFormat_IOS

##iOS数据转化组件 (Hbb_JSONParser)
* 支持字符串、字典、极其对应数组的相互转化
##为什么要写转化组件？
其实github上已经有很多优秀的JSON转化库，我见过SBJSON和JSONModel这两个库就写的着实不错，
那我为什么还要写多一个库出来呢？
* 因为我要写一个比他们更强大的库（说起来挺害羞的）
## 优势
* 和JSONModel相比， 我的库只是单纯作为转化类，并不需要模型类继承JSONModel类，
* 并且我写出来的库，可以自动转化（NSDate *）格式
##支持的功能
* 1. json字符串转化为
