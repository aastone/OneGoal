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
#import "OGGoalDetailViewController.h"

@interface OGHomeViewController()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) AppDelegate *myAppDelegate;

@property (nonatomic, strong) OGHomeTableViewCell *tmpCell;

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
    
    self.navigationItem.title = @"Goal";
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([OGHomeTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([OGHomeTableViewCell class])];
    
//    WEAK_SELF
//    [self.tableView addPullToRefreshWithActionHandler:^{
//        [weakSelf refreshTableView];
//        [weakSelf.tableView.pullToRefreshView stopAnimating];
//    }];
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.viewModel.goalArr = [NSMutableArray new];
    
    [self createUI];
    [self refreshTableView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshTableView];
}

- (void)createUI
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonPressed:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Remove" style:UIBarButtonItemStylePlain target:self action:@selector(removeAllData)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    
    self.tableView.separatorInset = UIEdgeInsetsZero;
}

- (void)addButtonPressed:(UIBarButtonItem *)sender
{
    // TODO: check user whether should create a new goal
    // factors: created goal nums & on-going goal nums & other issues
    
    OGCreateGoalViewController *createGoalVC = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([OGCreateGoalViewController class])];
    [self presentViewController:createGoalVC animated:YES completion:nil];
}

#pragma mark - Core Data

- (void)refreshTableView
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

- (void)removeAllData
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *goal = [NSEntityDescription entityForName:@"Goal" inManagedObjectContext:_myAppDelegate.managedObjectContext];
    [request setEntity:goal];
    
    NSError *error = nil;
    NSArray *result = [_myAppDelegate.managedObjectContext executeFetchRequest:request error:&error];
    if (!error) {
        for (Goal *tmp in result) {
            [_myAppDelegate.managedObjectContext deleteObject:tmp];
        }
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
    cell.singleGoal = goal;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.tmpCell) {
        self.tmpCell = (OGHomeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OGHomeTableViewCell class])];
    }
    self.tmpCell.singleGoal = self.viewModel.goalArr[indexPath.row];
    
    CGFloat height = [self.tmpCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
    return height+1+8;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 106;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Goal *goal = self.viewModel.goalArr[indexPath.row];
    OGGoalDetailViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([OGGoalDetailViewController class])];
    vc.viewModel.goal = goal;
    [self pushViewControllerHidesBottomBar:vc];
}

@end
