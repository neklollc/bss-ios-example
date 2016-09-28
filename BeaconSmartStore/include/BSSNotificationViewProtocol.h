//
//  BSSNotificationViewProtocol.h
//  BeaconSmartStore
//
//  Created by Maksim Vialykh on 13.07.15.
//  Copyright (c) 2015 NEKLO. All rights reserved.
//

@class BSSNotificationViewController;
@class UIViewController;

@protocol BSSNotificationViewDelegate <NSObject>

@required

/*!
 *  Asks the delegate whether alert controller should present.
 *
 *  @param actionData dictionary with action data for presentation
 */

- (BOOL)shouldPresentAlertNotificationWithActionData:(NSDictionary *)actionData;

/*!
 *  Asks the delegate whether notification controller should present.
 *
 *  @param actionData dictionary with action data for presentation
 */

- (BOOL)shouldPresentNotificationControllerWithActionData:(NSDictionary *)actionData;

@optional

/*!
 *  Used for init custom ViewController for display notification to user with action data.
 *
 *  @param actionData dictionary with beacon data
 *
 *  @return custom UIViewController
 */
- (UIViewController *)notificationViewController:(UIViewController *)viewController withActionData:(NSDictionary *)actionData;

/*!
 *  Used to determine which ViewController should present notification view controller
 *
 *  @param actionData dictionary with beacon data
 *
 */
- (UIViewController *)notificationPresenterViewControllerForActionData:(NSDictionary *)actionData;

@end

