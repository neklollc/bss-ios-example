//
//  BSSURLRequest.h
//  BeaconSmartStore
//
//  Created by Maksim Vialykh on 01.10.15.
//  Copyright © 2015 NEKLO. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BSSConnectionSuccessCompletion)(NSDictionary *response);
typedef void (^BSSConnectionFailureCompletion)(NSError *error);

/*!
 *    @see Documentation: http://app-dev.beaconsmartstore.com/doc/
 */
@interface BSSURLRequest : NSMutableURLRequest

/*!
 *  Provides support to perform asynchronous loads of a URL request.
 *
 *  @param type         request URL string
 *  @param method       Types of requests. The server receives the three types of requests: GET, POST, PUT
 *  @param parameters   list of parameters
 *  @param successBlock successBlock
 *  @param failureBlock failureBlock
 *
 *  @return BSSURLRequest
 *
 *  Example:
 *  @code [BSSURLRequest requestWithType:@"objects/:objectKey/news"
                         method:@"GET"
                     parameters:nil
                        success:^(NSDictionary *response) {
 
                                 // Handele success
 
                      } failure:^(NSError *error) {
 
                                 // Handele failure
 }];
 */
+ (BSSURLRequest *)requestWithType:(NSString *)type
                            method:(NSString *)method
                        parameters:(NSString *)parameters
                           success:(BSSConnectionSuccessCompletion)successBlock
                           failure:(BSSConnectionFailureCompletion)failureBlock;

- (BSSURLRequest *)initWithType:(NSString *)type
                         method:(NSString *)method
                     parameters:(NSString *)parameters
                        success:(BSSConnectionSuccessCompletion)successBlock
                        failure:(BSSConnectionFailureCompletion)failureBlock;

+ (BSSURLRequest *)requestWithType:(NSString *)type
                            method:(NSString *)method
                   parametersArray:(NSArray *)parameters
                           success:(BSSConnectionSuccessCompletion)successBlock
                           failure:(BSSConnectionFailureCompletion)failureBlock;

- (BSSURLRequest *)initWithType:(NSString *)type
                         method:(NSString *)method
                parametersArray:(NSArray *)parameters
                        success:(BSSConnectionSuccessCompletion)successBlock
                        failure:(BSSConnectionFailureCompletion)failureBlock;

- (void)send;
- (void)cancel;


@end
