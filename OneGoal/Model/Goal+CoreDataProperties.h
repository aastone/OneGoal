//
//  Goal+CoreDataProperties.h
//  
//
//  Created by stone on 16/5/26.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Goal.h"

NS_ASSUME_NONNULL_BEGIN

@interface Goal (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate *actualEndTime;
@property (nullable, nonatomic, retain) NSDate *assumeEndTime;
@property (nullable, nonatomic, retain) NSString *completeStatus;
@property (nullable, nonatomic, retain) NSDate *createTime;
@property (nullable, nonatomic, retain) NSString *dailyMark;
@property (nullable, nonatomic, retain) NSNumber *duration;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *plan;
@property (nullable, nonatomic, retain) NSString *reserve;
@property (nullable, nonatomic, retain) NSDate *startTime;
@property (nullable, nonatomic, retain) NSNumber *status;
@property (nullable, nonatomic, retain) NSNumber *todayCompleteFlag;
@property (nullable, nonatomic, retain) NSString *todayCompleteStatus;
@property (nullable, nonatomic, retain) NSNumber *todayCompleteTimes;

@end

NS_ASSUME_NONNULL_END
