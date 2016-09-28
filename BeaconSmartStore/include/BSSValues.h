//
//  BSSValues.h
//  BeaconSmartStore
//
//  Created by Maksim Vialykh on 10.07.15.
//  Copyright (c) 2015 NEKLO. All rights reserved.
//

/*!
 *  List of types of beacon notifications
 */
typedef NS_ENUM(NSUInteger, BSSActionType) {
    /*!
     *  Type of campaign's action that are triggered by time
     */
    BSSActionTypeTime,
    /*!
     *  Type of campaign's action that are triggered when the user enters or exit from beacon region
     */
    BSSActionTypeBeaconZone,
    /*!
     *  Type of campaign's action that are triggered when the user enters or exit from region and
     *  call beaconSmartStore:didDetectAction:withState: method
     */
    BSSActionTypeApplicationAction,
    /*!
     *  Type of campaign's action that are triggered when the user enters or exit from geo region
     */
    BSSActionTypeGeoZone
};