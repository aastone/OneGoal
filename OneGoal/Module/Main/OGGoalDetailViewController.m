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
#import "AppDelegate.h"
#import "OGCoreDataOperation.h"
#import "OGInputGoalPlanViewController.h"
#import "OGDetailDailyRemarkTableViewCell.h"
#import "NSNumber+Util.h"
#import "OGDetailHeaderView.h"

@interface OGGoalDetailViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *notificationInfoLabel;
@property (weak, nonatomic) IBOutlet UIView *notificationBgView;
@property (weak, nonatomic) IBOutlet UITextView *planTextView;
@property (nonatomic, strong) AppDelegate *myAppDelegate;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (nonatomic, strong) UIView *detailHeaderView;

@end

@implementation OGGoalDetailViewController

DECLARE_VIEWMODEL_GETTER(OGHomeViewModel)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!self.myAppDelegate) {
        self.myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([OGDetailHeaderView class]) owner:self options:nil];
    
    self.detailHeaderView = [nib objectAtIndex:0];
    
    [self showViewContent];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OGDetailDailyRemarkTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([OGDetailDailyRemarkTableViewCell class])];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    self.tableViewHeight.constant = [self tableView:self.tableView heightForHeaderInSection:0] + [self tableView:self.tableView numberOfRowsInSection:0]*60;
    
    [self.view layoutSubviews];
}

#pragma mark - View Content
- (void)showViewContent
{
    self.titleLabel.text = self.viewModel.goal.name;
    self.dateLabel.text = self.viewModel.goal.createTime.dateString;
    
    [self showAllNotifications];
    [self showPlanInfo];
}

#pragma mark  Notifications

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
    if (alertTime) {
        self.notificationInfoLabel.text = [NSString stringWithFormat:@"提醒时间：每%@%@", alertWeekday, alertTime];
    }else {
        self.notificationInfoLabel.text = @"点击设置提醒时间";
    }
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

#pragma mark  Plans

- (void)showPlanInfo
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"createTime == %@", self.viewModel.goal.createTime];
    [OGCoreDataOperation entityUpdateWithName:[Goal class] predicate:predicate context:self.myAppDelegate.managedObjectContext completion:^(NSError *error, id entity) {
        if (!error) {
            Goal *goal = entity;
            self.planTextView.text = goal.plan.length?goal.plan:@"#You can write your plan here.";
        }
    }];
}

- (IBAction)tapPlanTextView:(id)sender {
    OGInputGoalPlanViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([OGInputGoalPlanViewController class])];
    vc.viewModel.goalCreateDate = self.viewModel.goal.createTime;
    vc.shouldShowCancelButton = YES;
    vc.viewModel.goalPlan = self.planTextView.text;
    [self.navigationController pushViewController:vc animated:YES];
}



#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OGDetailDailyRemarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OGDetailDailyRemarkTableViewCell class])];
    cell.contentLabel.text = @"jnjnjnjnj";
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.detailHeaderView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 100;
}









@end
