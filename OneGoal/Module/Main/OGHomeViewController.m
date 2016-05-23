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
#import "BSLoadStatusView.h"
#import "OGHomeTableViewCell.h"
#import "OGHomeViewModel.h"
#import "Goal.h"
#import "NSDate+TimeUtil.h"
#import "SVPullToRefresh.h"

@interface OGHomeViewController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) AppDelegate *myAppDelegate;

DECLARE_VIEWMODEL(OGHomeViewModel)

@end

@implementation OGHomeViewController

DECLARE_VIEWMODEL_GETTER(OGHomeViewModel)

#pragma mark - Life Cycles

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (!self.myAppDelegate) {
        self.myAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    
    self.navigationItem.title = @"Goal 1";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OGHomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([OGHomeTableViewCell class])];
    
    WEAK_SELF
    [self.tableView addPullToRefreshWithActionHandler:^{
        [weakSelf queryInfo];
        [weakSelf.tableView.pullToRefreshView stopAnimating];
    }];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.viewModel.goalArr = [NSMutableArray new];
    
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
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
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
    if (!error) {
        [self.viewModel.goalArr removeAllObjects];
        for (Goal *obj in result) {
            [self.viewModel.goalArr addObject:obj];
        }
        [self.tableView reloadData];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.goalArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OGHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OGHomeTableViewCell class])];
    Goal *goal = self.viewModel.goalArr[indexPath.row];
    cell.textLabel.text = goal.name;
    cell.detailTextLabel.text = goal.createTime.dateString;
    return cell;
}

@end
