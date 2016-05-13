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

@interface OGCreateGoalViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property (strong, nonatomic) AppDelegate *myAppDelegate;

@end

@implementation OGCreateGoalViewController

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

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

- (IBAction)nextButtonPressed:(id)sender {
    OGCreateAlertViewController *alertVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([OGCreateAlertViewController class])];
    [self showViewController:alertVC sender:nil];
}
    
- (void)saveData
{
    self.myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSLog(@"%@", self.myAppDelegate.managedObjectContext);
    
    Goal *goal = (Goal *)[NSEntityDescription insertNewObjectForEntityForName:@"Goal" inManagedObjectContext:self.myAppDelegate.managedObjectContext];
    
    
    
    [goal setValue:self.textField.text forKey:@"name"];
    [goal setValue:[NSDate date] forKey:@"createTime"];
    
    NSError *error = nil;
    BOOL success = [self.myAppDelegate.managedObjectContext save:&error];
    if (!success) {
        [NSException raise:@"访问数据库错误" format:@"%@", [error localizedDescription]];
    }else {
        NSLog(@"SUCCESS!");
    }
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *user = [NSEntityDescription entityForName:@"Goal" inManagedObjectContext:self.myAppDelegate.managedObjectContext];
    [request setEntity:user];
    NSArray *result = [self.myAppDelegate.managedObjectContext executeFetchRequest:request error:&error];
    NSLog(@"%@", result);
    
    for (NSManagedObject *obj in result) {
        NSLog(@"%@", [obj valueForKey:@"name"]);
        NSLog(@"%@", [obj valueForKey:@"createTime"]);
    }
}

@end
