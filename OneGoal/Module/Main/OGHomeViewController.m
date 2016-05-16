//
//  OGHomeViewController.m
//  OneGoal
//
//  Created by stone on 16/5/14.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "OGHomeViewController.h"
#import "OGCreateGoalViewController.h"
#import "AppDelegate.h"
#import "UIViewController+Helper.h"

@interface OGHomeViewController()

@property (nonatomic, strong) AppDelegate *myAppDelegate;

@end

@implementation OGHomeViewController

#pragma mark - Life Cycles

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.myAppDelegate) {
        self.myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    
    self.navigationItem.title = @"Goal 1";
    
    [self createUI];
    [self queryInfo];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSArray *arr = [[UIApplication sharedApplication] scheduledLocalNotifications];
    if (arr.count) {
        NSLog(@"%@", arr);
        UILocalNotification *noti = arr[0];
        NSLog(@"%@", noti.fireDate);
    }
}

- (void)createUI
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonPressed:)];
}

- (void)addButtonPressed:(UIBarButtonItem *)sender
{
    // TODO: check user whether should create a new goal
    // factors: created goal nums & on-going goal nums & other issues
    
    OGCreateGoalViewController *createGoalVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([OGCreateGoalViewController class])];
    [self presentViewController:createGoalVC animated:YES completion:nil];
}

- (void)queryInfo
{
    NSError *error = nil;
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
