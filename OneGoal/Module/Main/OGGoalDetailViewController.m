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
#import "OGCreateAlertViewController.h"
#import "OGCreateGoalViewModel.h"

@interface OGGoalDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *notificationInfoLabel;
@property (weak, nonatomic) IBOutlet UIView *notificationBgView;

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
    
    NSString *alertTime = nil;
    NSMutableString *alertWeekday = [NSMutableString new];
    
    for (UILocalNotification *local in arr) {
        NSDate *info = local.userInfo[kOGGoalNotificationInfo];
        if ([info isEqualToDate:self.viewModel.goal.createTime]) {
            [alertWeekday appendString:@"周"];
            [alertWeekday appendString:[self convertNumberToChineseWeekdayNumber:local.userInfo[kOGGoalNotificationDetailInfo]]];
            alertTime = [local.fireDate stringWithDateFormat:@"HH:mm"];
        }
    }
    
    self.notificationInfoLabel.text = [NSString stringWithFormat:@"提醒时间：\n每%@\n%@", alertWeekday, alertTime];
    [self.notificationInfoLabel setFont:[UIFont systemFontOfSize:14.0]];
    [self.notificationInfoLabel sizeToFit];
}

- (NSString *)convertNumberToChineseWeekdayNumber:(NSNumber *)number
{
    switch (number.integerValue) {
        case 1:
            return @"一";
            break;
        case 2:
            return @"二";
            break;
        case 3:
            return @"三";
            break;
        case 4:
            return @"四";
            break;
        case 5:
            return @"五";
            break;
        case 6:
            return @"六";
            break;
        case 7:
            return @"日";
            break;
        default:
            return @"";
            break;
    }
}

- (void)cancelNotifications
{
    NSArray *arr = [[UIApplication sharedApplication] scheduledLocalNotifications];
    
    for (UILocalNotification *local in arr) {
        NSDate *info = local.userInfo[kOGGoalNotificationInfo];
        if ([info isEqualToDate:self.viewModel.goal.createTime]) {
            [[UIApplication sharedApplication] cancelLocalNotification:local];
        }
    }
}


- (IBAction)editNotificationButtonPressed:(id)sender {
    [self cancelNotifications];
    
    OGCreateAlertViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([OGCreateAlertViewController class])];
    vc.viewModel.goalName = self.viewModel.goal.name;
    vc.viewModel.goalCreateDate = self.viewModel.goal.createTime;
    [self presentViewController:vc animated:YES completion:nil];
}

@end
