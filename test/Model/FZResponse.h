//
//  FZResponse.h
//
//  Created by  on 4/7/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface FZResponse : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *message;
@property (nonatomic, assign) BOOL isFromMe;
@property (nonatomic, strong) NSString *sender;
@property (nonatomic, strong) NSString *time;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;
+ (NSURLSessionDataTask *)fetchMessage:(NSDictionary *)params completionBlock:(void(^)(NSArray *response ,NSError *error))completion;
@end
