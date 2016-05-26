//
//  OGCoreDataOperation.h
//  OneGoal
//
//  Created by stone on 16/5/26.
//  Copyright © 2016年 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"

@interface OGCoreDataOperation : NSObject

+ (void)entityUpdateWithName:(id)entityClassName predicate:(NSPredicate *)predicate delegate:(AppDelegate *)delegate completion:(void (^)(NSError *error, id entity))completion;

@end
