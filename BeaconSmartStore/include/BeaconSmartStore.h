//
//  BeaconSmartStore.h
//  BeaconSmartStore
//
//  Created by Air on 28.09.15.
//  Copyright © 2015 NEKLO. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLLocationManager.h>
#import <CoreBluetooth/CBCentralManager.h>
#import "BSSValues.h"
#import "BSSNotificationViewProtocol.h"
#import "BSSActionData.h"

typedef void (^BSSDataModelUpdateCompletion)(NSError *error);

/*!
 *  Start Option's keys. Should be used for create options dictionary in startWithOptions: method.
 */

/*!
 *  APIKey on production server. 
 *  NSString value.
 */
extern NSString *const kBSSAPIKey;

/*!
 *  The unique identifier of the object in admin panel. 
 *  NSString value.
 */
extern NSString *const kBSSDefaultObjectKey;

/*!
 *  Should app request locaton authorization instead BSS library. 
 *  BOOL value. 
 *  Default is NO.
 */
extern NSString *const kBSSManualLocationPermissionRequest;

/*!
 *  Should app request notification instead BSS library. 
 *  BOOL value. 
 *  Default is NO.
 */
extern NSString *const kBSSManualNotificationPermissionRequest;

/*!
 *  Should run beacon monitoring instead BSS library.
 *  BOOL value.
 *  Default is NO.
 */
extern NSString *const kBSSManualStartBeaconMonitoring;

/*!
 *  Should run update location instead BSS library.
 *  BOOL value.
 *  Default is NO.
 */
extern NSString *const kBSSManualStartUpdateLocation;

/*!
 *  Should app check bluetooth status instead BSS library. 
 *  BOOL value. 
 *  Default is NO.
 */
extern NSString *const kBSSShowBluetoothAlerts;

/*!
 *  Time interval for the same notifications. 
 *  NSTimeInterval value.
 *  Default is 6 hours.
 */
extern NSString *const kBSSSameNotificationsTimeInterval;

/*!
 *  Time interval for check new data from backend.
 *  NSTimeInterval value.
 *  Default is 24 hours.
 */
extern NSString *const kBSSUpdateTimeInterval;

/*!
 *  Should show notifications when handle beacon region. 
 *  BOOL value. 
 *  Default is YES.
 */
extern NSString *const kBSSShowLocalNotifications;

/*!
 *  Should show time notifications from BSS library.
 *  BOOL value. 
 *  Default is NO.
 */
extern NSString *const kBSSShowTimeNotifications;

/*!
 *  Should use APIKey on development server. 
 *  BOOL value. 
 *  Default is NO.
 */
extern NSString *const kBSSUsePrereleaseAPI;

/*!
 *  Message string in UIAlertView.  
 *  NSString value. 
 *  Default is "powered by NEKLO".
 */
extern NSString *const kBSSNotificationAlertMessage;

/*!
 *  Alert action string in UILocalNotification show in UIAlert button or 'slide to unlock...'.
 *  NSString value. 
 *  Default is "powered by NEKLO".
 */
extern NSString *const kBSSNotificationAlertAction; 

@protocol BSSDelegate;
@protocol BSSDelegateStates;

@class UILocalNotification;

@interface BeaconSmartStore : NSObject

/*!
 *  Check status for option's key kBSSManualLocationPermissionRequest
 */
@property (nonatomic, readonly) BOOL isManualLocationPermisionRequest;

/*!
 *  Check status for option's key kBSSManualNotificationPermissionRequest
 */
@property (nonatomic, readonly) BOOL isManualNotificationPermisionRequest;

/*!
 *  Check status for option's key kBSSShowBluetoothAlerts
 */
@property (nonatomic, readonly) BOOL isShowBluetoothAlerts;

/*!
 *  Check NSTimeInterval for option's key kBSSSameNotificationsTimeInterval
 */
@property (nonatomic, readonly) NSTimeInterval sameNotificationsTimeInterval;

/*!
 *  Check NSTimeInterval for option's key kBSSUpdateTimeInterval
 */
@property (nonatomic, readonly) NSTimeInterval updateTimeInterval;

/*!
 *  Should show notifications when handle beacon region.
 */
@property (nonatomic) BOOL shouldShowLocalNotifications;

/*!
 *  Should show time notifications from BSS library.
 */
@property (nonatomic) BOOL shouldShowTimeNotifications;

/*!
 *  Get user prerelease API
 */
@property (nonatomic, readonly) BOOL isUsePrereleaseAPI;

@property (nonatomic, weak) id <BSSDelegate> delegate;
@property (nonatomic, weak) id <BSSDelegateStates> delegateStates;
@property (nonatomic, weak) id <BSSNotificationViewDelegate> notificationDelegate;

+ (instancetype)sharedInstance;

/*!
 *  Method for lunch BSS library with option's keys
 *
 *  @param optionsData dictionary with start option's keys
 *
 *  @return BeaconSmartStore
 */
+ (instancetype)startWithOptions:(NSDictionary *)optionsData;

/*!
 *  Method for manual request locaton authorization, if option's key kBSSManualLocationPermissionRequest is YES
 */
- (void)requestLocationPermissions;

/*!
 *  Method for manual request local notification, if option's key kBSSManualNotificationPermissionRequest is YES
 */
- (void)requestNotificationPermissions;

/*!
 *  Method for manual run beacon monitoring, if option's key kBSSManualStartBeaconMonitoring is YES
 */
- (void)startBeaconMonitoring;

/*!
 *  Method for manual run update location, if option's key kBSSManualStartUpdateLocation is YES
 */
- (void)startUpdateLocation;

/*!
 *  Deprecated method use updateDataWithCompletionHandler:
 */
- (void)updateData __attribute((deprecated("use updateDataWithCompletionHandler: method")));

/*!
 *  Force check beacon data on server.
 */
- (void)updateDataWithCompletionHandler:(BSSDataModelUpdateCompletion)completionHandler;

/*!
 *  Method for the implementation of work local notifaction service in aplication.
 *  @todo This code must be implement in AppDelegate in application:didFinishLaunchingWithOptions: method
 *  @code UILocalNotification *localNotification = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
          if (localNotification) {
                [[BeaconSmartStore sharedInstance] processLocalNotification:localNotification];
          }
 *  @endcode
 *  @todo This code must be implement in AppDelegate in application:didReceiveLocalNotification: method
 *  @code [[BeaconSmartStore sharedInstance] processLocalNotification:notification];
 *  @endcode
 */
- (void)processLocalNotification:(UILocalNotification *)localNotification;

/*!
 *  Deprecated method use processRemoteNotification:andCompletionHandler:
 */
- (void)processRemoteNotification:(NSDictionary *)userInfo __attribute((deprecated("use processRemoteNotification:andCompletionHandler: method")));

/*!
 *  Method for the implementation of work remote notifaction service in aplication.
 *  @todo This code must be implement in AppDelegate in application:didReceiveRemoteNotification:fetchCompletionHandler: method
 *  @code [[BeaconSmartStore sharedInstance] processRemoteNotification:userInfo andCompletionHandler:^(NSError *error) {
              if (error) {
                  completionHandler(UIBackgroundFetchResultFailed);
              } else {
                  completionHandler(UIBackgroundFetchResultNewData);
              }
           }];
 *  @endcode
 */
- (void)processRemoteNotification:(NSDictionary *)userInfo andCompletionHandler:(void (^)(NSError *error))completionHandler;

/*!
 *  Method for manual loging data on Server
 */
- (void)logEvent:(NSString *)message parameters:(NSDictionary *)params;

/*!
 *  Method for setting DeviceToken
 */
- (void)setDeviceToken:(NSData *)deviceToken;

/*!
 *  Method for registration new users with externalID
 */
- (void)registerUserWithExternalID:(NSString *)externalID name:(NSString *)name email:(NSString *)email completion:(void (^)(NSError *error))completion;

/*!
 *  Method for login users with externalID
 */
- (void)loginUserWithExternalID:(NSString *)externalID completion:(void (^)(NSError *error))completion;

/*!
 *   Method for logout users
 */
- (void)logoutUserWithCompletion:(void (^)(NSError* error))completion;

/*!
 *  Method for the manual implementation run action with delay
 */
- (BOOL)perfromActionWithID:(NSString *)actionID afterDelay:(double)delay;

@end


@protocol BSSDelegate <NSObject>

@optional

/*!
 *  beaconSmartStore:didDetectAction:withState: is invoked when the user enters or exit from region (Actual for campaign type - Event in application).
 *
 *  @param beaconSmartStore BeaconSmartStore object
 *  @param actionData       useDictionary - action parameters
 *  @param state            Represents the current state of the device with reference to a region
 */
- (void)beaconSmartStore:(BeaconSmartStore *)beaconSmartStore didDetectAction:(BSSActionData *)actionData withState:(CLRegionState)state __attribute((deprecated("use beaconSmartStore:didDetectAction:withState:withRegion")));

/*!
 *  beaconSmartStore:didDetectAction:withState:withRegion is invoked when the user enters or exit from region (Actual for campaign type - Event in application).
 *
 *  @param beaconSmartStore BeaconSmartStore object
 *  @param actionData       useDictionary - action parameters
 *  @param state            Represents the current state of the device with reference to a region
 *  @param region           Represents reference to a region
 */
- (void)beaconSmartStore:(BeaconSmartStore *)beaconSmartStore didDetectAction:(BSSActionData *)actionData withState:(CLRegionState)state withRegion:(CLBeaconRegion *)region;

@end

@protocol BSSDelegateStates <NSObject>

@optional

/*!
 *  Invoked whenever the central manager's state has been updated.
 */
- (void)beaconSmartStore:(BeaconSmartStore *)beaconSmartStore bluetoothChangeState:(CBManagerState)state;

/*!
 *   Invoked whenever the location manager's state has been updated.
 */
- (void)beaconSmartStore:(BeaconSmartStore *)beaconSmartStore locationChangeAutorizationStatus:(CLAuthorizationStatus)status;

@end
