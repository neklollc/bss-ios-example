//
//  AppDelegate.m
//  BSS_iOS_Example
//
//  Created by Air on 29.10.15.
//  Copyright © 2015 NEKLO. All rights reserved.
//

#import "AppDelegate.h"
#import "BeaconSmartStore.h"

@interface AppDelegate () <BSSDelegateStates, BSSNotificationViewDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [BeaconSmartStore startWithOptions:@{kBSSAPIKey: kAPIKey,
                                         kBSSDefaultObjectKey: kObjectKey,
                                         
                                         // Manual request permissions
                                         //kBSSUsePrereleaseAPI: @(YES),
                                         kBSSManualLocationPermissionRequest: @YES,
                                         kBSSManualNotificationPermissionRequest: @YES
                                         }];
    [BeaconSmartStore sharedInstance].notificationDelegate = self;
    [BeaconSmartStore sharedInstance].delegateStates = self;

    // Manual request permissions
    [[BeaconSmartStore sharedInstance] requestLocationPermissions];
    [[BeaconSmartStore sharedInstance] requestNotificationPermissions];
    
// The application opened from the notification?
    UILocalNotification *localNotification = launchOptions[UIApplicationLaunchOptionsLocalNotificationKey];
    if (localNotification) {
        [[BeaconSmartStore sharedInstance] processLocalNotification:localNotification];
    }
    
    return YES;
}


#pragma mark - handle notifications for BSS

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [[BeaconSmartStore sharedInstance] processLocalNotification:notification];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(nonnull void (^)(UIBackgroundFetchResult))completionHandler {
    [[BeaconSmartStore sharedInstance] processRemoteNotification:userInfo andCompletionHandler:^(NSError *error) {
        if (error) {
            completionHandler(UIBackgroundFetchResultFailed);
        } else {
            completionHandler(UIBackgroundFetchResultNewData);
        }
    }];
}


#pragma mark - handle notifications states

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings {

}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    [[BeaconSmartStore sharedInstance] setDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {

}


#pragma mark - BSSNotificationViewDelegate

- (BOOL)shouldPresentNotificationControllerWithActionData:(NSDictionary *)actionData {
    return YES;
}

- (BOOL)shouldPresentAlertNotificationWithActionData:(NSDictionary *)actionData {
    return YES;
}


#pragma mark - BSS bluetooth and location states

- (void)beaconSmartStore:(BeaconSmartStore *)beaconSmartStore bluetoothChangeState:(CBManagerState)state {
    
}

- (void)beaconSmartStore:(BeaconSmartStore *)beaconSmartStore locationChangeAutorizationStatus:(CLAuthorizationStatus)status {
    
}

@end
