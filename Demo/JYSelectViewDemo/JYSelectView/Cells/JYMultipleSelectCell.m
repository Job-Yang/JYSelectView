//
//  JYMultipleSelectCell.m
//  JYChoicePopView
//
//  Created by 杨权 on 16/5/25.
//  Copyright © 2016年 Job-Yang. All rights reserved.
//

#import "JYMultipleSelectCell.h"
#import "UIResponder+Router.h"

@interface JYMultipleSelectCell()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
/**
 *  该行index
 */
@property (assign, nonatomic) NSIndexPath *index;
/**
 *  是否被选中
 */
@property (assign, nonatomic) BOOL isSeletced;
@end

@implementation JYMultipleSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setContentWithDic:(NSDictionary *)dic {
    self.title.text = dic[@"title"];
    self.index = dic[@"index"];
    self.isSeletced = [dic[@"isSeletced"] boolValue];
    
    if (self.isSeletced == YES) {
        self.imageview.image = [UIImage imageNamed:@"JYSelectView_select"];
        self.backgroundColor = [UIColor colorWithRed:238.f/255.f green:238.f/255.f blue:238.f/255.f alpha:1];
    }
    else {
        self.imageview.image = [UIImage imageNamed:@"JYSelectView_normal"];
        self.backgroundColor = [UIColor whiteColor];
    }
}
- (IBAction)clickAction:(id)sender {
    
    self.isSeletced = !self.isSeletced;
    
    if (self.isSeletced == YES) {
        self.imageview.image = [UIImage imageNamed:@"JYSelectView_select"];
        self.backgroundColor = [UIColor colorWithRed:238.f/255.f green:238.f/255.f blue:238.f/255.f alpha:1];
    }
    else {
        self.imageview.image = [UIImage imageNamed:@"JYSelectView_normal"];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    [self routerEventWithName:@"JYMultipleSelectCell" userInfo:@{@"indexPath":self.index,@"isSeletced":@(self.isSeletced)}];
}

@end
