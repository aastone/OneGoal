//
//  OGCoreDataOperation.m
//  OneGoal
//
//  Created by stone on 16/5/26.
//  Copyright © 2016年 stone. All rights reserved.
//

#import "OGCoreDataOperation.h"

@implementation OGCoreDataOperation

+ (void)entityUpdateWithName:(Class)entityClassName predicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context completion:(void (^)(NSError *error, id entity))completion
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:NSStringFromClass([entityClassName class]) inManagedObjectContext:context]];
    
    [request setPredicate:predicate];
    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    if (error) {
        completion(error, nil);
    }else {
        completion(nil, [results objectAtIndex:0]);
    }
}

@end
