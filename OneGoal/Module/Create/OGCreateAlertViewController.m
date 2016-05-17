//
//  OGCreateAlertViewController.m
//  OneGoal
//
//  Created by stone on 16/5/13.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "OGCreateAlertViewController.h"
#import "NSDate+TimeUtil.h"
#import "UIButton+Extension.h"

@interface OGCreateAlertViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet UIButton *monButton;
@property (weak, nonatomic) IBOutlet UIButton *tueButton;
@property (weak, nonatomic) IBOutlet UIButton *wenButton;
@property (weak, nonatomic) IBOutlet UIButton *thuButton;
@property (weak, nonatomic) IBOutlet UIButton *friButton;
@property (weak, nonatomic) IBOutlet UIButton *satButton;
@property (weak, nonatomic) IBOutlet UIButton *sunButton;

@property (nonatomic, strong) NSArray<UIButton*> *buttons;

@end

@implementation OGCreateAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.buttons = @[_monButton, _tueButton, _wenButton, _thuButton, _friButton, _satButton, _sunButton];
    
    self.datePicker.timeZone = [NSTimeZone defaultTimeZone];
    
    if (self.setUpCompleteBlock) {
        self.setUpCompleteBlock();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (IBAction)allButtonPressed:(UIButton *)sender {
    [UIButton setAllButtonSelectedOrUnselected:_allButton withButtons:self.buttons];
}

- (IBAction)monButtonPressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

- (IBAction)tueButtonPressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

- (IBAction)wenButtonPressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

- (IBAction)thuButtonPressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

- (IBAction)friButtonPressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

- (IBAction)satButtonPressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}

- (IBAction)sunButtonPressed:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}



- (IBAction)doneButtonPressed:(id)sender {
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    UILocalNotification *localAlert = [[UILocalNotification alloc] init];
    if (localAlert) {
        localAlert.fireDate = [self dateBySelectDayInWeek:@1 withDate:self.datePicker.date];
        localAlert.repeatInterval = NSCalendarUnitWeekOfYear; //每周同一时间提醒
        localAlert.timeZone = [NSTimeZone defaultTimeZone];
        localAlert.soundName = UILocalNotificationDefaultSoundName;
        localAlert.alertTitle = @"alertTitle";
        localAlert.alertBody = @"alertBody";
        localAlert.alertAction = @"alertAction";
        localAlert.hasAction = YES;
        localAlert.userInfo = [NSDictionary dictionaryWithObject:@"alertTime1" forKey:@"alertTime1"];
        
        //另外要设置多个星期，根据上个页面选择的提醒日
        
    }
    [[UIApplication sharedApplication] scheduleLocalNotification:localAlert];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSDate *)dateBySelectDayInWeek:(NSNumber *)day withDate:(NSDate *)date
{
    NSNumber *currentDay = [NSDate currentDayInWeek:nil];
    if ([day isEqualToNumber:currentDay]) {
        return date;
    }
    
    if (day.integerValue > currentDay.integerValue) {
        return [date dateByAddingTimeInterval:24*60*60*(day.integerValue - currentDay.integerValue)];
    }else {
        return [date dateByAddingTimeInterval:24*60*60*(day.integerValue - currentDay.integerValue + 7)];
    }
}





































@end
