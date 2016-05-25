//
//  OGGoalDetailViewController.m
//  OneGoal
//
//  Created by stone on 16/5/24.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "OGGoalDetailViewController.h"
#import "OGHomeViewModel.h"
#import "OGConfig.h"
#import "Goal.h"
#import "NSDate+TimeUtil.h"

@interface OGGoalDetailViewController ()

@end

@implementation OGGoalDetailViewController

DECLARE_VIEWMODEL_GETTER(OGHomeViewModel)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showAllNotifications];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAllNotifications
{
    NSArray *arr = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification *local in arr) {
        NSDate *info = local.userInfo[kOGGoalNotificationInfo];
        NSString *hour = [local.fireDate stringWithDateFormat:@"HH:mm"];
        if ([info isEqualToDate:self.viewModel.goal.createTime]) {
            NSLog(@"%@--%@", local.userInfo[kOGGoalNotificationDetailInfo], hour);
        }
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
