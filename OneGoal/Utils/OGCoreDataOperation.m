//
//  OGCoreDataOperation.m
//  OneGoal
//
//  Created by stone on 16/5/26.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "OGCoreDataOperation.h"
#import <CoreData/CoreData.h>

@implementation OGCoreDataOperation

+ (void)entityUpdateWithName:(Class)entityClassName predicate:(NSPredicate *)predicate delegate:(AppDelegate *)delegate completion:(void (^)(NSError *error, id entity))completion
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:NSStringFromClass([entityClassName class]) inManagedObjectContext:delegate.managedObjectContext]];
    
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [delegate.managedObjectContext executeFetchRequest:request error:&error];
    
    if (error) {
        completion(error, nil);
    }else {
        completion(nil, [results objectAtIndex:0]);
    }
}

@end
