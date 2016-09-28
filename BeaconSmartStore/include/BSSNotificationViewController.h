//
//  BSSNotificationViewController.h
//  BeaconSmartStore
//
//  Created by Maksim Vialykh on 09.07.15.
//  Copyright (c) 2015 NEKLO. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BSSActionData.h"

/*!
 *  Used for customize notification view controller in shouldPresentNotificationController: method of 
 *  BSSNotificationViewDelegate
 */
@interface BSSNotificationViewController : UIViewController

@property (nonatomic, readonly) UINavigationBar *navigationBar;
@property (nonatomic, readonly) UIWebView *webView;
@property (nonatomic, readonly) UINavigationItem *navigationTitle;
@property (nonatomic, readonly) UIBarButtonItem *closeNavigationItem;

@property (nonatomic, copy) NSDictionary *actionData;

@end
