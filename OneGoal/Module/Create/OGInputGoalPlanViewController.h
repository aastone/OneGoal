//
//  OGInputGoalPlanViewController.h
//  OneGoal
//
//  Created by stone on 16/5/26.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "BSBaseViewController.h"

@class OGCreateGoalViewModel;

@interface OGInputGoalPlanViewController : BSBaseViewController

DECLARE_VIEWMODEL(OGCreateGoalViewModel)

@property (nonatomic, copy) dispatch_block_t setUpCompleteBlock;

@property (nonatomic, assign) BOOL shouldShowCancelButton;

@end
