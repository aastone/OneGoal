//
//  OGCreateGoalViewController.m
//  OneGoal
//
//  Created by stone on 16/5/12.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "OGCreateGoalViewController.h"
#import "Goal.h"
#import "NSDate+TimeUtil.h"
#import "AppDelegate.h"
#import "OGCreateAlertViewController.h"
#import "UIViewController+Helper.h"
#import "OGCreateGoalViewModel.h"
#import "SVProgressHUD.h"
#import "OGInputGoalPlanViewController.h"

@interface OGCreateGoalViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (strong, nonatomic) AppDelegate *myAppDelegate;

DECLARE_VIEWMODEL(OGCreateGoalViewModel)

@end

@implementation OGCreateGoalViewController

DECLARE_VIEWMODEL_GETTER(OGCreateGoalViewModel)

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

#pragma mark - Actions

- (IBAction)closeButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextButtonPressed:(id)sender {
    if (self.textField.text.length == 0) {
        //TODO 提示
        [SVProgressHUD showErrorWithStatus:@"Please input your Goal !"];
        return;
    }
    [self saveData];
}
    
- (void)saveData
{
    self.myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Goal *goal = (Goal *)[NSEntityDescription insertNewObjectForEntityForName:@"Goal" inManagedObjectContext:self.myAppDelegate.managedObjectContext];
    
    self.viewModel.goalName = self.textField.text;
    self.viewModel.goalCreateDate = [NSDate date];
    
    [goal setValue:self.textField.text forKey:@"name"];
    [goal setValue:self.viewModel.goalCreateDate forKey:@"createTime"];
    
    NSError *error = nil;
    BOOL success = [self.myAppDelegate.managedObjectContext save:&error];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
    }else {
        NSLog(@"SUCCESS!");
        [self gotoCreateAlertVC];
    }
}

- (void)gotoCreateAlertVC
{
    __weak typeof(self) weakSelf = self;
    OGInputGoalPlanViewController *alertVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([OGInputGoalPlanViewController class])];
    alertVC.viewModel.goalName = self.viewModel.goalName;
    alertVC.viewModel.goalCreateDate = self.viewModel.goalCreateDate;
    alertVC.setUpCompleteBlock = ^{
        [weakSelf dismissViewControllerAnimated:NO completion:nil];
    };
    [self showViewController:alertVC sender:nil];
}

@end
