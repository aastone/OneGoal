//
//  OGCreateAlertViewController.h
//  OneGoal
//
//  Created by stone on 16/5/13.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "BSBaseViewController.h"

@class OGCreateGoalViewModel;

@interface OGCreateAlertViewController : BSBaseViewController

@property (nonatomic, copy) dispatch_block_t setUpCompleteBlock;

DECLARE_VIEWMODEL(OGCreateGoalViewModel)

@end
