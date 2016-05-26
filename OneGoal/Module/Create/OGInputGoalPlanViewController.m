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

@interface OGInputGoalPlanViewController()

@property (weak, nonatomic) IBOutlet UITextView *textView;

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
    
    if (self.setUpCompleteBlock) {
        self.setUpCompleteBlock();
    }
}

- (void)addPlan
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"createTime == %@", self.viewModel.goalCreateDate];
    
    [OGCoreDataOperation entityUpdateWithName:[Goal class] predicate:predicate delegate:self.myAppDelegate completion:^(NSError *error, id entity) {
        if (!error) {
            Goal *goal = entity;
            goal.plan = self.textView.text;
            [self.myAppDelegate saveContext];
        }
    }];
}

- (IBAction)nextButtonPressed:(id)sender {
    NSLog(@"%@", self.textView.text);
    [self addPlan];
}

@end
