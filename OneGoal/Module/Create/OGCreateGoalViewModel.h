//
//  OGCreateGoalViewModel.h
//  OneGoal
//
//  Created by stone on 16/5/18.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "BSViewModel.h"

@interface OGCreateGoalViewModel : BSViewModel

@property (nonatomic, strong) NSString *goalName;
@property (nonatomic, strong) NSDate *goalCreateDate;
@property (nonatomic, strong) NSString *goalPlan;

@property (nonatomic, assign) BOOL isFromDetailVC;
@property (nonatomic, assign) BOOL isAddNewObject;

@end
