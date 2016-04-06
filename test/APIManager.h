//
//  APIManager.h
//  test
//
//  Created by Arie on 4/7/16.
//  Copyright © 2016 Dalvk Studio. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface APIManager : AFHTTPSessionManager
+ (instancetype)sharedClient;
@end
