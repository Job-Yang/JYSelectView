//
//  JYSelectView.h
//  JYSelectView
//
//  Created by 杨权 on 16/5/30.
//  Copyright © 2016年 Job-Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  单行选择--Cell行高（最小为35）
 */
const CGFloat JYSingleSelectCellHeight = 40;
/**
 *  多行选择--Cell行高 (最小为20)
 */
const CGFloat JYMultipleSelectCellHeight  = 30;
/**
 *  多行选择--每行Cell数量
 */
const NSUInteger JYMultipleSelectCellNumber = 2;

@class JYSelectView;

typedef void (^dismissViewWithButton)();

@interface JYSelectView : UIView

typedef NS_ENUM(NSInteger, JYChoiceStyle) {
  JYSingleSelect = 0,
  JYMultipleSelect
};

/**
 *  点选信息,在点击确定后赋值
 */
@property (strong, nonatomic) NSArray *selectedArr;

/**
 *  使用默认点击事件
 *
 *  @param titleArray 数据源，用于设置标题
 *  @param style      cell样式
 *  @param animated   是否使用动画
 *
 *  @return JYSelectView对象
 */
- (instancetype)initWithTitleArray:(NSArray<NSString *> * _Nonnull)titleArray
                             style:(JYChoiceStyle)style
                          animated:(BOOL)animated;

/**
 *  使用自定义点击事件
 *
 *  @param titleArray        数据源，用于设置标题
 *  @param style             cell样式
 *  @param animated          是否使用动画
 *  @param completionHandler 点击确定后执行该block
 *
 *  @return JYSelectView对象
 */
- (instancetype)initWithTitleArray:(NSArray<NSString *> * _Nonnull)titleArray
                             style:(JYChoiceStyle)style
                          animated:(BOOL)animated
                 completionHandler:(dismissViewWithButton _Nonnull)completionHandler;

@end
