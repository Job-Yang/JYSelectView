//
//  JYSelectView.m
//  JYSelectView
//
//  Created by 杨权 on 16/5/30.
//  Copyright © 2016年 Job-Yang. All rights reserved.
//

#import "JYSelectView.h"
#import "JYSingleSelectedCell.h"
#import "JYMultipleSelectCell.h"

//屏幕宽度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
//屏幕高度
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

NSString *const kJYSingleSelectCell   = @"JYSingleSelectedCell";
NSString *const kJYMultipleSelectCell = @"JYMultipleSelectCell";

@interface JYSelectView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UIView *selectView;
@property (assign, nonatomic) CGFloat collectionViewHeight;
@property (strong, nonatomic) NSArray *titleArray;
@property (assign, nonatomic) JYChoiceStyle style;
@property (strong, nonatomic) NSMutableArray *resultArr;
@property (assign, nonatomic) BOOL isAnimated;
@property (copy,   nonatomic) dismissViewWithButton completionBlock;

@end

@implementation JYSelectView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                 reason:@"NSCoding not supported"
                               userInfo:nil];
}

- (instancetype)initWithTitleArray:(NSArray<NSString *> * _Nonnull)titleArray style:(JYChoiceStyle)style animated:(BOOL)animated completionHandler:(dismissViewWithButton ) completionHandler {
  self = [super init];
  if (self) {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.937 alpha:1];
    self.titleArray = titleArray;
    self.style = style;
    self.isAnimated = animated;
    self.completionBlock = completionHandler;
    if (!self.resultArr) {
      self.resultArr = [NSMutableArray array];
      for (int i = 0; i < self.titleArray.count; i++) {
        [self.resultArr addObject:@(NO)];
      }
    }
    [self setupHeight];
    [self initSelectView];
    if (self.isAnimated) {
      [self addPopAnimation];
    }
  }
  return self;
}

- (instancetype)initWithTitleArray:(NSArray<NSString *> * _Nonnull)titleArray style:(JYChoiceStyle)style animated:(BOOL)animated{
  self = [self initWithTitleArray:titleArray
                            style:style
                         animated:animated
                completionHandler:nil];
  return self;
}

#pragma mark - setup methods

- (void)setupHeight {
  if (self.style == JYSingleSelect) {
    self.collectionViewHeight = self.titleArray.count * JYSingleSelectCellHeight;
  }
  else {
    if (self.titleArray.count % JYMultipleSelectCellNumber == 0) {
      self.collectionViewHeight = self.titleArray.count/JYMultipleSelectCellNumber * JYMultipleSelectCellHeight;
    }
    else {
      self.collectionViewHeight = (self.titleArray.count/JYMultipleSelectCellNumber+1) * JYMultipleSelectCellHeight;
    }
  }
  
  if (self.collectionViewHeight + 200 > SCREEN_HEIGHT) {
    self.collectionViewHeight = SCREEN_HEIGHT-200;
  }
}

- (void)initSelectView {
  
  self.selectView = [[UIView alloc]initWithFrame:CGRectMake(30, (SCREEN_HEIGHT-(self.collectionViewHeight+101))/2, SCREEN_WIDTH-60, self.collectionViewHeight+101)];
  self.selectView.backgroundColor = [UIColor whiteColor];
  self.selectView.layer.cornerRadius = 10;
  self.selectView.layer.shadowColor = [UIColor grayColor].CGColor;
  self.selectView.layer.shadowOffset = CGSizeMake(10, 10);
  self.selectView.layer.shadowOpacity = 0.5;
  self.selectView.layer.shadowRadius = 5;
  [self addSubview:self.selectView];
  /**
   标题Label
   */
  UILabel *tilteLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.selectView.frame.size.width, 50)];
  tilteLabel.text = @"请选择:";
  tilteLabel.font = [UIFont boldSystemFontOfSize:18.f];
  tilteLabel.textAlignment = NSTextAlignmentCenter;
  [self.selectView addSubview:tilteLabel];
  /**
   横线
   */
  UILabel *horizontal1 = [[UILabel alloc]initWithFrame:CGRectMake(0 , tilteLabel.frame.size.height-1, self.selectView.frame.size.width, 0.5)];
  horizontal1.backgroundColor = [UIColor grayColor];
  [tilteLabel addSubview:horizontal1];
  /**
   *  collectionView
   */
  UICollectionViewFlowLayout* flowLayout = [[UICollectionViewFlowLayout alloc]init];
  if (self.style == JYSingleSelect) {
    flowLayout.itemSize = CGSizeMake(self.selectView.frame.size.width, JYSingleSelectCellHeight<35 ? 35 : JYSingleSelectCellHeight);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
  }
  else {
    flowLayout.itemSize = CGSizeMake(self.selectView.frame.size.width/JYMultipleSelectCellNumber, JYMultipleSelectCellHeight<20 ? 20 : JYMultipleSelectCellHeight);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
  }
  CGRect frame = CGRectMake(0, 50, self.selectView.frame.size.width, self.collectionViewHeight);
  self.collectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:flowLayout];
  self.collectionView.backgroundColor = [UIColor whiteColor];
  self.collectionView.delegate = self;
  self.collectionView.dataSource = self;
  //注册CollectionView
  [self.collectionView registerNib:[UINib nibWithNibName:kJYSingleSelectCell bundle:nil] forCellWithReuseIdentifier:kJYSingleSelectCell];
  [self.collectionView registerNib:[UINib nibWithNibName:kJYMultipleSelectCell bundle:nil] forCellWithReuseIdentifier:kJYMultipleSelectCell];
  [self.selectView addSubview:self.collectionView];
  /**
   取消Button
   */
  UIButton *cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.selectView.frame.size.height-50, self.selectView.frame.size.width/2-1, 50)];
  [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
  [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchDown];
  [self.selectView addSubview:cancelButton];
  /**
   确定Button
   */
  UIButton *okButton = [[UIButton alloc]initWithFrame:CGRectMake(self.selectView.frame.size.width/2+1, self.selectView.frame.size.height-50, self.selectView.frame.size.width/2-1, 50)];
  [okButton setTitle:@"确定" forState:UIControlStateNormal];
  [okButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
  [okButton addTarget:self action:@selector(okButtonAction:) forControlEvents:UIControlEventTouchDown];
  [self.selectView addSubview:okButton];
  /**
   竖线
   */
  UILabel *verticalline = [[UILabel alloc]initWithFrame:CGRectMake(cancelButton.frame.size.width, cancelButton.frame.origin.y, 0.5, cancelButton.frame.size.height)];
  verticalline.backgroundColor = [UIColor grayColor];
  [self.selectView addSubview:verticalline];
  /**
   横线
   */
  UILabel *horizontal2 = [[UILabel alloc]initWithFrame:CGRectMake(0 , cancelButton.frame.origin.y-1, self.selectView.frame.size.width, 0.5)];
  horizontal2.backgroundColor = [UIColor grayColor];
  [self.selectView addSubview:horizontal2];
  
}

#pragma mark - Router

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
  NSIndexPath *indexPath = userInfo[@"indexPath"];
  NSNumber *isSeletced = userInfo[@"isSeletced"];
  [self.resultArr replaceObjectAtIndex:indexPath.row withObject:isSeletced];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return self.titleArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  id cell;
  NSString *cellID = (self.style == JYSingleSelect ? kJYSingleSelectCell : kJYMultipleSelectCell);
  cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
  [cell setContentWithDic:@{@"title":self.titleArray[indexPath.row],
                            @"isSeletced":self.resultArr[indexPath.row],
                            @"index":indexPath}];
  
  return cell;
}


#pragma make - Action

- (void)cancelButtonAction {
  [self removeFromSuperview];

}

- (void)okButtonAction:(id)sender {
  self.selectedArr = [self.resultArr copy];
  if (self.completionBlock) {
    self.completionBlock();
  }
  [self removeFromSuperview];
}

#pragma make - Animation

- (void)addPopAnimation {
  CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
  animation.fromValue = [NSNumber numberWithDouble:0.f];
  animation.toValue   = [NSNumber numberWithDouble:1.f];
  animation.duration  = .25f;
  animation.fillMode  = kCAFillModeBackwards;
  [self.layer addAnimation:animation forKey:nil];
}


@end
