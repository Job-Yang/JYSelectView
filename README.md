# JYSelectView

### 简介

仅需一行代码就可以完成一个单行选择/多行选择View

### 用法

#### 添加一个单行选择/多行选择View

```objc
//数据源
  for (int i = 0; i < 40; i++) {
    [arr addObject:[NSString stringWithFormat:@"数据--%d",i]];
  }

//添加单行选择View
JYSelectView *view = [[JYSelectView alloc]initWithTitleArray:arr
                                                       style:JYSingleSelect
                                                    animated:YES];
  [self.view addSubview:view];

```
#### 单行选择效果图

![JYSelectView](https://github.com/Job-Yang/JYSelectView/blob/master/ScreenShots/JYSingleSelect.jpg)


#### 带Block的创建方法

```objc
//数据源
  for (int i = 0; i < 20; i++) {
    [arr addObject:[NSString stringWithFormat:@"数据--%d",i]];
  }

//添加单行选择View
  JYSelectView *view = [[JYSelectView alloc]initWithTitleArray:arr
                                                         style:JYMultipleSelect
                                                      animated:YES
                                             completionHandler:^{
                                               // 点击确定时执行
                                             }];
  [self.view addSubview:view];

```
#### 多行选择效果图

![JYSelectView](https://github.com/Job-Yang/JYSelectView/blob/master/ScreenShots/JYMultipleSelect.jpg)

#### 有任何问题可以直接issues,或者邮箱联系我。
