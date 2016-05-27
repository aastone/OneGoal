//
//  OGCoreDataOperation.h
//  OneGoal
//
//  Created by stone on 16/5/26.
//  Copyright © 2016年 stone. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface OGCoreDataOperation : NSObject

/**
 *  查询特定条件的数据，可用于单个entity的展示和更新
 *
 *  @param entityClassName <#entityClassName description#>
 *  @param predicate       <#predicate description#>
 *  @param context         <#context description#>
 *  @param completion      <#completion description#>
 */
+ (void)entityUpdateWithName:(id)entityClassName predicate:(NSPredicate *)predicate context:(NSManagedObjectContext *)context completion:(void (^)(NSError *error, id entity))completion;

@end
