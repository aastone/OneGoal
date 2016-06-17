//
//  OGInputGoalPlanViewController.m
//  OneGoal
//
//  Created by stone on 16/5/26.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "OGInputGoalPlanViewController.h"
#import "OGCreateAlertViewController.h"
#import "OGCreateGoalViewModel.h"
#import "Goal.h"
#import "AppDelegate.h"
#import "OGCoreDataOperation.h"
#import "NSString+Util.h"
#import "BSJSONWrapper.h"
#import "OGConfig.h"

@interface OGInputGoalPlanViewController()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (nonatomic, strong) AppDelegate *myAppDelegate;

@end

@implementation OGInputGoalPlanViewController

DECLARE_VIEWMODEL_GETTER(OGCreateGoalViewModel)

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.myAppDelegate) {
        self.myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    
    if (_shouldShowCancelButton) {
        [self.nextButton setTitle:@"Close" forState:UIControlStateNormal];
        self.textView.text = self.viewModel.goalPlan;
    }else {
        if (self.setUpCompleteBlock) {
            self.setUpCompleteBlock();
        }
    }
}

- (void)addPlan
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"createTime == %@", self.viewModel.goalCreateDate];
    
    [OGCoreDataOperation entityUpdateWithName:[Goal class] predicate:predicate context:self.myAppDelegate.managedObjectContext completion:^(NSError *error, id entity) {
        if (!error) {
            Goal *goal = entity;
            goal.plan = self.textView.text;
            [[NSNotificationCenter defaultCenter] postNotificationName:kOGGoalDetailPlanReloadNotification object:self.textView.text];
            [self.myAppDelegate saveContext];
        }
    }];
}

- (void)addDailyRemark
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"createTime == %@", self.viewModel.goalCreateDate];
    
    [OGCoreDataOperation entityUpdateWithName:[Goal class] predicate:predicate context:self.myAppDelegate.managedObjectContext completion:^(NSError *error, id entity) {
        if (!error) {
            Goal *goal = entity;
            NSMutableArray *newRemark = [NSMutableArray new];
            if (goal.dailyMark.length) {
                NSArray *oldRemark = goal.dailyMark.bs_objectFromJSONString;
                newRemark = [NSMutableArray arrayWithArray:oldRemark];
            }
            if (self.viewModel.isAddNewObject) {
                [newRemark addObject:[NSDictionary dictionaryWithObjectsAndKeys:self.textView.text, kGoalDailyRemarkContentKey, [NSString stringWithFormat:@"%@", [NSDate date]], kGoalDailyRemarkDateKey, nil]];
            }else {
                NSDictionary *lastDic = [newRemark objectAtIndex:newRemark.count - 1];
                NSDictionary *newDic = [NSDictionary dictionaryWithObjectsAndKeys:self.textView.text, kGoalDailyRemarkContentKey, [lastDic objectForKey:kGoalDailyRemarkDateKey], kGoalDailyRemarkDateKey, nil];
                [newRemark replaceObjectAtIndex:newRemark.count-1 withObject:newDic];
            }
            
            goal.dailyMark = [NSString stringWithFormat:@"%@", newRemark.bs_JSONString];
            [[NSNotificationCenter defaultCenter] postNotificationName:kOGGoalDetailRemarkReloadNotification object:newRemark.bs_JSONString];
            [self.myAppDelegate saveContext];
        }
    }];
}

- (IBAction)nextButtonPressed:(id)sender {
    if (_isFromDailyRemark) {
        [self addDailyRemark];
    }else {
        [self addPlan];
    }
    
    if (_shouldShowCancelButton) {
        [self dismissViewControllerAnimated:YES completion:nil];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    OGCreateAlertViewController *alertVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([OGCreateAlertViewController class])];
    alertVC.viewModel.goalName = self.viewModel.goalName;
    alertVC.viewModel.goalCreateDate = self.viewModel.goalCreateDate;
    alertVC.setUpCompleteBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    [self showViewController:alertVC sender:nil];
}

@end
