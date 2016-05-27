//
//  OGConfig.h
//  OneGoal
//
//  Created by stone on 16/5/24.
//  Copyright © 2016年 stone. All rights reserved.
//

#ifndef OGConfig_h
#define OGConfig_h

static NSString *const kOGGoalNotificationInfo = @"kOGGoalNotificationInfo";
static NSString *const kOGGoalNotificationDetailInfo = @"kOGGoalNotificationDetailInfo";

typedef enum : NSUInteger {
    OGGoalStatusOngoing     = 1,
    OGGoalStatusFinished    = 2,
    OGGoalStatusPaused      = 3,
    OGGoalStatusDeadline    = 4,
    OGGoalStatusCanceled    = 5,
    OGGoalStatusDeleted     = -1,
} OGGoalStatus;


#endif /* OGConfig_h */
