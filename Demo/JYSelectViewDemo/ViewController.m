//
//  ViewController.m
//  JYSelectViewDemo
//
//  Created by 杨权 on 16/5/30.
//  Copyright © 2016年 Job-Yang. All rights reserved.
//

#import "ViewController.h"
#import "JYSelectView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (IBAction)JYSingleSelect:(id)sender {
  NSMutableArray *arr = [NSMutableArray array];
  for (int i = 0; i < 20; i++) {
    [arr addObject:[NSString stringWithFormat:@"数据--%d",i]];
  }
  JYSelectView *view = [[JYSelectView alloc]initWithTitleArray:arr
                                                         style:JYSingleSelect
                                                      animated:YES
                                             completionHandler:^{
                                               NSLog(@"233333333333333");
                                             }];
  [self.view addSubview:view];
}

- (IBAction)JYMultipleSelect:(id)sender {
  NSMutableArray *arr = [NSMutableArray array];
  for (int i = 0; i < 40; i++) {
    [arr addObject:[NSString stringWithFormat:@"数据--%d",i]];
  }
  JYSelectView *view = [[JYSelectView alloc]initWithTitleArray:arr
                                                         style:JYMultipleSelect
                                                      animated:NO];
  [self.view addSubview:view];
}

@end
