//
//  OGHomeTableViewCell.m
//  OneGoal
//
//  Created by stone on 16/5/18.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "OGHomeTableViewCell.h"
#import "Goal.h"
#import "NSDate+TimeUtil.h"
#import "UIColor+Tools.h"

@implementation OGHomeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
    self.layer.cornerRadius = 16.0;
    self.layer.borderWidth = 2.0;
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSingleGoal:(Goal *)singleGoal
{
    self.name.text = singleGoal.name;
    if (singleGoal.plan.length) {
        self.plan.text = singleGoal.plan;
    }else {
        self.plan.text = @"#You can add your plan here.#";
    }
    self.createTime.text = singleGoal.createTime.dateString;
}

@end
