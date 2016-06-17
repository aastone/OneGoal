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
static NSString *const kOGGoalDetailRemarkReloadNotification = @"kOGGoalDetailRemarkReloadNotification";
static NSString *const kOGGoalDetailPlanReloadNotification = @"kOGGoalDetailPlanReloadNotification";
static NSString *const kOGGoalDetailAlertReloadNotification = @"kOGGoalDetailAlertReloadNotification";


typedef enum : NSUInteger {
    OGGoalStatusOngoing     = 1,
    OGGoalStatusFinished    = 2,
    OGGoalStatusPaused      = 3,
    OGGoalStatusDeadline    = 4,
    OGGoalStatusCanceled    = 5,
    OGGoalStatusDeleted     = -1,
} OGGoalStatus;


#endif /* OGConfig_h */
