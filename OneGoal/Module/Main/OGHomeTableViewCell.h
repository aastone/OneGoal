//
//  OGHomeTableViewCell.h
//  OneGoal
//
//  Created by stone on 16/5/18.
//  Copyright © 2016年 stone. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Goal;

@interface OGHomeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *plan;
@property (weak, nonatomic) IBOutlet UILabel *createTime;
@property (weak, nonatomic) IBOutlet UIImageView *statusImageView;

@property (nonatomic, strong) Goal *singleGoal;

@end
