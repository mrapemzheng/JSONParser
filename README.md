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
## 1、json字符串转化为字典 
```java
  NSString *jsonStr = @"{\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }";
  
 Hbb_JSONParser *hbb_JSONParser = [[Hbb_JSONParser alloc] init];
 MyObject *myObject = [hbb_JSONParser jsonStringToBean:self.jsonStr cls:[MyObject class]];
```

## 2、json字符串转化为字典数组
## 3、json字符串转化为模型
## 4、json字符串转化为模型数组
## 6、字典转化为模型
## 7、字典数组转化为模型数组
## 8、字典转化为json字符串
## 9、字典数组转化json字符串
## 10、模型转化为字典
## 11、模型数组转化为字典数组
## 12、模型转化为json字符串
## 13、模型数组转化为json字符串
