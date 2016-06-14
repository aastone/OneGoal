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
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveButtonPressed)];
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
            [self.myAppDelegate saveContext];
        }
    }];
}

- (void)saveButtonPressed
{
    [self addPlan];
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)nextButtonPressed:(id)sender {
    [self addPlan];
    
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
