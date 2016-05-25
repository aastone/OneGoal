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
#import "OGCreateGoalViewModel.h"
#import "OGConfig.h"

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
@property (nonatomic, strong) NSMutableArray *selectedDays;

@end

@implementation OGCreateAlertViewController

DECLARE_VIEWMODEL_GETTER(OGCreateGoalViewModel)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.buttons = @[_monButton, _tueButton, _wenButton, _thuButton, _friButton, _satButton, _sunButton];
    self.selectedDays = [NSMutableArray arrayWithCapacity:7];
    
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
    if (sender.isSelected) {
        [self.selectedDays removeAllObjects];
    }else {
        self.selectedDays = [NSMutableArray arrayWithObjects:@1, @2, @3, @4, @5, @6, @7, nil];
    }
    [UIButton setAllButtonSelectedOrUnselected:_allButton withButtons:self.buttons];
}

- (IBAction)monButtonPressed:(UIButton *)sender {
    [self addSelectedDay:@1 withButton:sender];
    sender.selected = !sender.isSelected;
}

- (IBAction)tueButtonPressed:(UIButton *)sender {
    [self addSelectedDay:@2 withButton:sender];
    sender.selected = !sender.isSelected;
}

- (IBAction)wenButtonPressed:(UIButton *)sender {
    [self addSelectedDay:@3 withButton:sender];
    sender.selected = !sender.isSelected;
}

- (IBAction)thuButtonPressed:(UIButton *)sender {
    [self addSelectedDay:@4 withButton:sender];
    sender.selected = !sender.isSelected;
}

- (IBAction)friButtonPressed:(UIButton *)sender {
    [self addSelectedDay:@5 withButton:sender];
    sender.selected = !sender.isSelected;
}

- (IBAction)satButtonPressed:(UIButton *)sender {
    [self addSelectedDay:@6 withButton:sender];
    sender.selected = !sender.isSelected;
}

- (IBAction)sunButtonPressed:(UIButton *)sender {
    [self addSelectedDay:@7 withButton:sender];
    sender.selected = !sender.isSelected;
}

- (void)addSelectedDay:(NSNumber *)day withButton:(UIButton *)sender
{
    if (sender.isSelected) {
        [self.selectedDays removeObject:day];
    }else {
        [self.selectedDays addObject:day];
    }
}



- (IBAction)doneButtonPressed:(id)sender {
    //另外要设置多个星期，根据上个页面选择的提醒日
    
    if (self.selectedDays.count) {
        for (NSNumber *day in self.selectedDays) {
            [self weeklyNotification:day];
        }
    }else {
        [self weeklyNotification:nil];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)weeklyNotification:(NSNumber *)weekday
{
    UILocalNotification *localAlert = [[UILocalNotification alloc] init];
    localAlert.timeZone = [NSTimeZone defaultTimeZone];
    localAlert.soundName = UILocalNotificationDefaultSoundName;
    localAlert.alertTitle = @"One Goal";
    localAlert.alertBody = self.viewModel.goalName;
    localAlert.hasAction = NO;
    if (weekday) {
        localAlert.fireDate = [self dateBySelectDayInWeek:weekday withDate:self.datePicker.date];
        localAlert.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:self.viewModel.goalCreateDate,kOGGoalNotificationInfo, weekday, kOGGoalNotificationDetailInfo, nil];
        localAlert.repeatInterval = NSCalendarUnitWeekOfYear; //每周同一时间提醒
    }else {
        localAlert.fireDate = self.datePicker.date;
        localAlert.userInfo = [NSDictionary dictionaryWithObjectsAndKeys:self.viewModel.goalCreateDate,kOGGoalNotificationInfo, @0, kOGGoalNotificationDetailInfo, nil];
    }
    [[UIApplication sharedApplication] scheduleLocalNotification:localAlert];
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
