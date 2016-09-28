//
//  BSSActionData+CoreDataProperties.h
//  BeaconSmartStore
//
//  Created by Air on 02.06.16.
//  Copyright © 2016 NEKLO. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "BSSActionData.h"

NS_ASSUME_NONNULL_BEGIN

@interface BSSActionData (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *actionID;
@property (nullable, nonatomic, retain) NSData *customActions;
@property (nullable, nonatomic, retain) NSString *fullContent;
@property (nullable, nonatomic, retain) NSNumber *latitude;
@property (nullable, nonatomic, retain) NSString *link;
@property (nullable, nonatomic, retain) NSNumber *longitude;
@property (nullable, nonatomic, retain) NSData *params;
@property (nullable, nonatomic, retain) NSNumber *performDelay;
@property (nullable, nonatomic, retain) NSNumber *repeatTime;
@property (nullable, nonatomic, retain) NSNumber *radius;
@property (nullable, nonatomic, retain) NSString *shortContent;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *type;

@end

NS_ASSUME_NONNULL_END
