//
//  OGHomeViewModel.h
//  OneGoal
//
//  Created by stone on 16/5/18.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "BSViewModel.h"

@class Goal;

@interface OGHomeViewModel : BSViewModel

@property (nonatomic, strong) NSMutableArray *goalArr;
@property (nonatomic, strong) Goal *goal;

@end
