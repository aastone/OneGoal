//
//  OGInputGoalPlanViewController.h
//  OneGoal
//
//  Created by stone on 16/5/26.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "BSBaseViewController.h"

@class OGCreateGoalViewModel;

static const NSString *kGoalDailyRemarkContentKey = @"kGoalDailyRemarkContentKey";
static const NSString *kGoalDailyRemarkDateKey = @"kGoalDailyRemarkDateKey";

@interface OGInputGoalPlanViewController : BSBaseViewController

DECLARE_VIEWMODEL(OGCreateGoalViewModel)

@property (nonatomic, copy) dispatch_block_t setUpCompleteBlock;

@property (nonatomic, assign) BOOL shouldShowCancelButton;

@property (nonatomic, assign) BOOL isFromDailyRemark;

@end
