//
//  DataSource.h
//  test
//
//  Created by Arie on 4/7/16.
//  Copyright © 2016 Dalvk Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DataSource : NSObject <UITableViewDataSource>
@property (nonatomic,strong) NSArray *message;
+ (NSURLSessionDataTask *)fetchMessage:(NSDictionary *)params completionBlock:(void(^)(NSArray *response ,NSError *error))completion;
@end
