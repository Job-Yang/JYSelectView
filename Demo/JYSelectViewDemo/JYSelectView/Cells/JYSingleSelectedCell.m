//
//  JYSingleSelectedCell.m
//  JYChoicePopView
//
//  Created by 杨权 on 16/5/25.
//  Copyright © 2016年 Job-Yang. All rights reserved.
//

#import "JYSingleSelectedCell.h"
#import "UIResponder+Router.h"

@interface JYSingleSelectedCell()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UISwitch *uiswitch;
/**
 *  该行index
 */
@property (assign, nonatomic) NSIndexPath *index;
/**
 *  是否被选中
 */
@property (assign, nonatomic) BOOL isSeletced;

@end

@implementation JYSingleSelectedCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setContentWithDic:(NSDictionary *)dic {
    self.title.text = dic[@"title"];
    self.index = dic[@"index"];
    self.isSeletced = [dic[@"isSeletced"] boolValue];
    [self.uiswitch setOn:self.isSeletced];
    
    if (self.isSeletced == YES) {
        self.backgroundColor = [UIColor colorWithRed:238.f/255.f green:238.f/255.f blue:238.f/255.f alpha:1];
    }
    else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (IBAction)switchAction:(id)sender {
    self.isSeletced = !self.isSeletced;
    [self.uiswitch setOn:self.isSeletced animated:YES];
    
    if (self.isSeletced == YES) {
        self.backgroundColor = [UIColor colorWithRed:238.f/255.f green:238.f/255.f blue:238.f/255.f alpha:1];
    }
    else {
        self.backgroundColor = [UIColor whiteColor];
    }
    
    [self routerEventWithName:@"JYSingleSelectedCell" userInfo:@{@"indexPath":self.index,@"isSeletced":@(self.isSeletced)}];
}

@end
