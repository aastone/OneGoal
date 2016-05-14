//
//  OGCreateAlertViewController.m
//  OneGoal
//
//  Created by stone on 16/5/13.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "OGCreateAlertViewController.h"

@interface OGCreateAlertViewController ()

@end

@implementation OGCreateAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)doneButtonPressed:(id)sender {
    
    NSArray *arr = [[UIApplication sharedApplication] scheduledLocalNotifications];
    if (arr.count) {
        NSLog(@"%ld", arr.count);
    }
    
    
    UILocalNotification *localAlert = [[UILocalNotification alloc] init];
    if (localAlert) {
        NSDate *now = [NSDate new];
        localAlert.fireDate = [now dateByAddingTimeInterval:10];
        localAlert.repeatInterval = 0;
        localAlert.timeZone = [NSTimeZone defaultTimeZone];
        localAlert.soundName = UILocalNotificationDefaultSoundName;
        localAlert.alertTitle = @"alertTitle";
        localAlert.alertBody = @"alertBody";
        localAlert.alertAction = @"alertAction";
        localAlert.hasAction = YES;
    }
    [[UIApplication sharedApplication] presentLocalNotificationNow:localAlert];
    [[UIApplication sharedApplication] scheduleLocalNotification:localAlert];
}







































@end
