# JYSelectView

### 简介

仅需一行代码就可以完成一个单行选择/多行选择View

### 用法

#### 添加一个单行选择/多行选择View

```objc
//数据源
  NSMutableArray *arr = [NSMutableArray array];
  for (int i = 0; i < 20; i++) {
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


#### 带Block且自定义风格的创建方法

```objc
//数据源
  NSMutableArray *arr = [NSMutableArray array];
  for (int i = 0; i < 40; i++) {
    [arr addObject:[NSString stringWithFormat:@"数据--%d",i]];
  }

//添加单行选择View
  JYSelectView *view = [[JYSelectView alloc]initWithTitleArray:arr
                                                         style:JYMultipleSelect
                                                      animated:YES
                                             completionHandler:^{
                                               // 点击确定时执行
                                             }];
  view.hintInfo = @"点击您喜爱的几个选项：";
  view.hintInfoColor = [UIColor redColor];
  view.okButtonColor = [UIColor blueColor];
  view.cancelButtonColor = [UIColor redColor];
  [self.view addSubview:view];

```
#### 多行选择效果图

![JYSelectView](https://github.com/Job-Yang/JYSelectView/blob/master/ScreenShots/JYMultipleSelect.jpg)

#### 有任何问题可以直接issues,或者邮箱联系我。
