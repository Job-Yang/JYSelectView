# JYSelectView

### 简介

仅需一行代码就可以完成一个单行选择/多行选择View

### 用法

#### 添加一个单行选择/多行选择View

```
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




#### 带Block的创建方法

```
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