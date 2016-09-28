//
//  BSSApiTest.m
//  BSS_iOS_Example
//
//  Created by Yaroslav on 16/08/16.
//  Copyright © 2016 NEKLO. All rights reserved.
//

// Active tests can be run together.
// Tests for user and customers run manual

#import <XCTest/XCTest.h>
#import "BSSURLRequest.h"
#import "AppDelegate.h"

@interface BSSApiTest : XCTestCase

@end

@implementation BSSApiTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)runApiTestWithExpectation:(XCTestExpectation *)expectation detailedURL:(NSString*)detailedURL method:(NSString*)method parameters:(NSString*)parameters {
    
    [BSSURLRequest requestWithType:detailedURL method:method parameters:parameters success:^(NSDictionary *response) {
        [expectation fulfill];
    } failure:nil];

    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        XCTAssertNil(error, "error should be nil");
    }];
}

- (void)runApiTestWithExpectation:(XCTestExpectation *)expectation detailedURL:(NSString*)detailedURL method:(NSString*)method parametersArray:(NSArray*)parametersArray {
    
    [BSSURLRequest requestWithType:detailedURL method:method parametersArray:parametersArray success:^(NSDictionary *response) {
        [expectation fulfill];
    } failure:nil];
    
    [self waitForExpectationsWithTimeout:5.0 handler:^(NSError *error) {
        XCTAssertNil(error, "error should be nil");
    }];
}


#pragma mark - Beacons

- (void)testBeaconsList {
    XCTestExpectation *expectation = [self expectationWithDescription:@"BeaconsListTest"];
    
    NSString *detailedURL = [NSString stringWithFormat:@"objects/%@/beacons", kObjectKey];
    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"GET" parameters:nil];
}


#pragma mark - Campaign

- (void)testCampaignsList {
    XCTestExpectation *expectation = [self expectationWithDescription:@"CampaignsListTest"];
    
    NSString *detailedURL = [NSString stringWithFormat:@"objects/%@/campaigns", kObjectKey];
    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"GET" parameters:nil];
}


#pragma mark - Customers

// need login test before this
- (void)testGetCustomerProfile {
    XCTestExpectation *expectation = [self expectationWithDescription:@"GetCustomerProfileTest"];
    
    NSString *detailedURL = [NSString stringWithFormat:@"customers/%@", @"57b40ecace1820154d3b733a"];
    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"GET" parameters:nil];
}

- (void)testRegisterCustomer {
    XCTestExpectation *expectation = [self expectationWithDescription:@"RegisterCustomerTest"];
    
    NSString *detailedURL = @"customers";
    
    NSMutableString *parameters = [NSMutableString new];
    [parameters appendFormat:@"%@=%@&", @"email", @"testApi@testApi.com"];
    [parameters appendFormat:@"%@=%@&", @"username", @"testApi"];
    [parameters appendFormat:@"%@=%@", @"password", @"testApi"];

    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"POST" parameters:parameters];
}

- (void)testRegisterCustomerWithExternalId {
    XCTestExpectation *expectation = [self expectationWithDescription:@"RegisterCustomerWithExternalIdTest"];
    
    NSString *detailedURL = @"customers";
    
    NSMutableString *parameters = [NSMutableString new];
    [parameters appendFormat:@"%@=%@&", @"email", @"testApiEx@testApi.com"];
    [parameters appendFormat:@"%@=%@&", @"name", @"testApiExternal"];
    [parameters appendFormat:@"%@=%@", @"external_id", @"11111"];
    
    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"POST" parameters:parameters];
}

// need login test before this
- (void)testUpdateCustomerProfile {
    XCTestExpectation *expectation = [self expectationWithDescription:@"UpdateCustomerProfileTest"];
    
    // need correct user id
    NSString *detailedURL = [NSString stringWithFormat:@"customers/%@", @"57b40ecace1820154d3b733a"];
    
    NSMutableString *parameters = [NSMutableString new];
    [parameters appendFormat:@"%@=%@&", @"phone", @"79001234567"];
    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"PUT" parameters:parameters];
}


#pragma mark - Devices

- (void)testSetDevice {
    XCTestExpectation *expectation = [self expectationWithDescription:@"SetDeviceTest"];
    
    NSString *detailedURL = [NSString stringWithFormat:@"objects/%@/devices", kObjectKey];
    
    NSString *parameters = [NSString stringWithFormat:@"deviceId=%@&deviceType=ios", @"64eeb27910c7a28b0cccb2e8da09e90a1de9bfdf36a5528c80f3dbe683d7dacd"];
    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"POST" parameters:parameters];
}


#pragma mark - Locations

- (void)testLocationsList {
    XCTestExpectation *expectation = [self expectationWithDescription:@"LocationsListTest"];
    
    NSString *detailedURL = [NSString stringWithFormat:@"objects/%@/locations", kObjectKey];
    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"GET" parameters:nil];
}


#pragma mark - Landmarks

- (void)testNewsLandmarks {
    XCTestExpectation *expectation = [self expectationWithDescription:@"LandmarksListTest"];
    
    NSString *detailedURL = [NSString stringWithFormat:@"objects/%@/landmarks", kObjectKey];
    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"GET" parameters:nil];
}


#pragma mark - News

- (void)testNewsList {
    XCTestExpectation *expectation = [self expectationWithDescription:@"NewsListTest"];
    
    NSString *detailedURL = [NSString stringWithFormat:@"objects/%@/news", kObjectKey];
    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"GET" parameters:nil];
}

- (void)testNewsDetail {
    XCTestExpectation *expectation = [self expectationWithDescription:@"NewsDetailTest"];
    
    NSString *detailedURL = [NSString stringWithFormat:@"objects/%@/news/a76a5ded88dae7403d5baeeb", kObjectKey];
    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"GET" parameters:nil];
}


#pragma mark - Objects

- (void)testObject {
    XCTestExpectation *expectation = [self expectationWithDescription:@"ObjectTest"];
    
    NSString *detailedURL = [NSString stringWithFormat:@"objects/%@", kObjectKey];
    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"GET" parameters:nil];
}

- (void)testObjectsList {
    XCTestExpectation *expectation = [self expectationWithDescription:@"ObjectsListTest"];
    
    NSString *detailedURL = [NSString stringWithFormat:@"objects"];
    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"GET" parameters:nil];
}


#pragma mark - Places

- (void)testPlacesList {
    XCTestExpectation *expectation = [self expectationWithDescription:@"PlacesListTest"];
    
    NSString *detailedURL = [NSString stringWithFormat:@"objects/%@/places", kObjectKey];
    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"GET" parameters:nil];
}


#pragma mark - Statistics

- (void)testSetStats {
    XCTestExpectation *expectation = [self expectationWithDescription:@"SetStatsTest"];
    
    NSString *detailedURL = [NSString stringWithFormat:@"stats"];
    
    NSArray *outputData = @[@{@"event": @"customEvent", @"params": @"ApiTest"}];
    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"POST" parametersArray:outputData];
}


#pragma mark - Stores

- (void)testStoresList {
    XCTestExpectation *expectation = [self expectationWithDescription:@"StoresListTest"];
    
    NSString *detailedURL = [NSString stringWithFormat:@"objects/%@/stores", kObjectKey];
    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"GET" parameters:nil];
}


#pragma mark - User

- (void)testUserForgotPassword {
    XCTestExpectation *expectation = [self expectationWithDescription:@"UserForgotPasswordTest"];
    
    NSString *detailedURL = @"auth/forgot-password";
    
    NSString *parameters = [NSString stringWithFormat:@"%@=%@", @"email", @"testApi@testApi.com"];
    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"POST" parameters:parameters];
}

- (void)testUserSetPassword {
    XCTestExpectation *expectation = [self expectationWithDescription:@"UserSetPasswordTest"];
    
    NSString *detailedURL = @"auth/set-password";
    
    NSMutableString *parameters = [NSMutableString new];
    [parameters appendFormat:@"%@=%@&", @"email", @"testApi@testApi.com"];
    // token from email
    [parameters appendFormat:@"%@=%@&", @"token", @"mDJEAxajFbImyUz+"];
    [parameters appendFormat:@"%@=%@", @"password", @"testApi"];
    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"POST" parameters:parameters];
}

- (void)testUserLogin {
    XCTestExpectation *expectation = [self expectationWithDescription:@"UserLoginTest"];
    
    NSString *detailedURL = @"auth/login";
    
    NSMutableString *parameters = [NSMutableString new];
    [parameters appendFormat:@"%@=%@&", @"email", @"testApi@testApi.com"];
    [parameters appendFormat:@"%@=%@", @"password", @"testApi"];
    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"POST" parameters:parameters];
}

- (void)testUserLogout {
    XCTestExpectation *expectation = [self expectationWithDescription:@"UserLogoutTest"];
    
    NSString *detailedURL = @"auth/logout";
    
    [self runApiTestWithExpectation:expectation detailedURL:detailedURL method:@"GET" parameters:nil];
}

@end
