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
    self.layer.cornerRadius = 8.0;
    self.layer.borderWidth = 1.0;
    self.layer.borderColor = [UIColor colorWithHexString:@"0x979797"].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setSingleGoal:(Goal *)singleGoal
{
    self.name.text = singleGoal.name;
    self.plan.text = singleGoal.plan;
    self.createTime.text = singleGoal.createTime.dateString;
    
//    [self.statusImageView setImage:[[UIImage alloc] crea]]]
}

@end
