

##iOS数据转化组件 (JSONParser),支持JSON字符串、模型、字典、模型数组、字典数组之间相互的转化
##为什么要写转化组件？
其实github上已经有很多优秀的JSON转化库，我见过SBJSON和JSONModel这两个库就写的着实不错，
那我为什么还要写多一个库出来呢？
* 因为我要写一个比他们更强大的库（说起来挺害羞的）


## 优势
* 1.和JSONModel相比， 我的库只是单纯作为转化类，并不需要模型类继承JSONModel类，
* 并且我写出来的库，可以自动转化（NSDate *）格式
* 2.Hbb_JSONParser还支持"类中类"的转化

##声明: 所有的转化都是一句代码(为了方便阅读才写多了几行代码)

##转化的实例类
```java
@interface MyObject : NSObject

@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) int normalInt;
@property (nonatomic, assign) long normalLong;
@property (nonatomic, assign) NSInteger integer;
@property (nonatomic, strong) MyInnerObject *myInnerObject; //"类中类"
@property (nonatomic, assign) CGFloat cgfloat;
@property (nonatomic, assign) float normalFloat;

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) NSString *str;
@end

@interface MyInnerObject : NSObject
@property (nonatomic, strong) NSString *str;
@property (nonatomic, strong) NSString *str2;

@end


```
##支持的功能
## 1、json字符串转化为字典 
```java
  NSString *jsonStr = @"{\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }";
  
 Hbb_JSONParser *hbb_JSONParser = [[Hbb_JSONParser alloc] init];
 
 //json字符串转化为字典 
 MyObject *myObject = [hbb_JSONParser jsonStringToDictionary:jsonStr];
```
## 2、json字符串转化为字典数组
```java
  NSString *jsonArrayStr = @"[{\"date\":\"\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }, {\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }, {\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }]";
  
 Hbb_JSONParser *hbb_JSONParser = [[Hbb_JSONParser alloc] init];
 
 //json字符串转化为字典数组
 NSArray *beanArray = [hbb_JSONParser jsonStringToDictionaryArray:jsonArrayStr];
```
## 3、json字符串转化为模型
```java
  NSString *jsonStr = @"{\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }";
  
 Hbb_JSONParser *hbb_JSONParser = [[Hbb_JSONParser alloc] init];
 
 //json字符串转化为模型
 MyObject *myObject = [hbb_JSONParser jsonStringToBean:jsonStr cls:[MyObject class]];
```
## 4、json字符串转化为模型数组
```java
  NSString *jsonArrayStr = @"[{\"date\":\"\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }, {\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }, {\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }]";
  
 Hbb_JSONParser *hbb_JSONParser = [[Hbb_JSONParser alloc] init];
 
 //json字符串转化为模型数组
 NSArray *beanArray = [hbb_JSONParser jsonStringToBeanArray:jsonArrayStr cls:[MyObject class]];
```
## 6、字典转化为模型
```java
  NSString *jsonStr = @"{\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }";
  
   Hbb_JSONParser *hbb_JSONParser = [[Hbb_JSONParser alloc] init];
  NSDictionary *dict = [hbb_JSONParser jsonStringToDictionary:jsonStr];
  
  //字典转化为模型
    MyObject *myObject = [self.hbb_JSONParser dictionaryToBean:dict cls:[MyObject class]];
```
## 7、字典数组转化为模型数组
```java
  NSString *jsonArrayStr = @"[{\"date\":\"\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }, {\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }, {\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }]";
  
 Hbb_JSONParser *hbb_JSONParser = [[Hbb_JSONParser alloc] init];
 NSArray *dictArray = [hbb_JSONParser jsonStringToDictionary:jsonArrayStr]
 
 //字典数组转化为模型数组
 NSArray *beanArray =[hbb_JSONParser dictionaryArrayToBeanArray:dictArray cls:[MyObject class]];
```
## 8、字典转化为json字符串
```java
  NSString *jsonStr = @"{\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }";
  
   Hbb_JSONParser *hbb_JSONParser = [[Hbb_JSONParser alloc] init];
  NSDictionary *dict = [hbb_JSONParser jsonStringToDictionary:jsonStr];
  
  //字典转化为json字符串
  NSString *jsonString = [hbb_JSONParser dictionaryToJsonString:dict];
```
## 9、字典数组转化json字符串
```java
  NSString *jsonArrayStr = @"[{\"date\":\"\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }, {\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }, {\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }]";
  
 Hbb_JSONParser *hbb_JSONParser = [[Hbb_JSONParser alloc] init];
 NSArray *dictArray = [hbb_JSONParser jsonStringToDictionary:jsonArrayStr]
 
 //字典数组转化json字符串
 NSString *jsonArrayStr = [hbb_JSONParser dictionaryArrayToJsonString:dictArray];
```
## 10、模型转化为字典
```java
NSString *jsonStr = @"{\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }";
  
 Hbb_JSONParser *hbb_JSONParser = [[Hbb_JSONParser alloc] init];
 MyObject *myObject = [hbb_JSONParser jsonStringToDictionary:jsonStr];
 
 //模型转化为字典
NSDictionary *dict = [hbb_JSONParser beanToDictionary:myObject];
```
## 11、模型数组转化为字典数组
```java
NSString *jsonArrayStr = @"[{\"date\":\"\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }, {\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }, {\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }]";
  
 Hbb_JSONParser *hbb_JSONParser = [[Hbb_JSONParser alloc] init];
 NSArray *beanArray = [hbb_JSONParser jsonStringToBeanArray:jsonArrayStr cls:[MyObject class]];
 
 //模型数组转化为字典数组
 NSArray *dictArray = [hbb_JSONParser beanArrayToDictionaryArray:beanArray];

```
## 12、模型转化为json字符串
```java
NSString *jsonStr = @"{\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }";
  
 Hbb_JSONParser *hbb_JSONParser = [[Hbb_JSONParser alloc] init];
 MyObject *myObject = [hbb_JSONParser jsonStringToBean:jsonStr cls:[MyObject class]];
 
 //模型转化为json字符串
NSString *jsonString = [hbb_JSONParser beanToJsonString:myObject];
```

## 13、模型数组转化为json字符串
```java
  NSString *jsonArrayStr = @"[{\"date\":\"\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }, {\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }, {\"date\":\"2014-06-07 12:34:54\",\"normalInt\":2 , \"normalLong\":24, \"myInnerObject\":{\"str\":\"字符串1\"}, \"cgfloat\":1.0, \"normalFloat\":2.0, \"array\":[\"1\", \"2\"], \"dictionary\":{\"key\":\"value\"} }]";
  
 Hbb_JSONParser *hbb_JSONParser = [[Hbb_JSONParser alloc] init];
 NSArray *beanArray = [hbb_JSONParser jsonStringToBeanArray:jsonArrayStr cls:[MyObject class]];

//模型数组转化为json字符串
NSString *jsonArrayString = [self.hbb_JSONParser beanArrayToJsonString:self.myObjectArray cls:[MyObject class]];

```
