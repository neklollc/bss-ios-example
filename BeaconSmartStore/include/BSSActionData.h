//
//  BSSActionData.h
//  BeaconSmartStore
//
//  Created by Air on 07.10.15.
//  Copyright © 2015 NEKLO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BSSValues.h"

NS_ASSUME_NONNULL_BEGIN

@interface BSSActionData : NSManagedObject

@property (nonatomic, readonly) NSDictionary *userDictionary;

@property (nonatomic, readonly) NSString *screenName;

- (void)updateWithJSON:(NSDictionary *)data;

@end

NS_ASSUME_NONNULL_END

#import "BSSActionData+CoreDataProperties.h"
