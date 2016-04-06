//
//  FZResponse.m
//
//  Created by  on 4/7/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "FZResponse.h"
#import "APIManager.h"

NSString *const kFZResponseMessage = @"message";
NSString *const kFZResponseIsFromMe = @"is_from_me";
NSString *const kFZResponseSender = @"sender";
NSString *const kFZResponseTime = @"time";


@interface FZResponse ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation FZResponse

@synthesize message = _message;
@synthesize isFromMe = _isFromMe;
@synthesize sender = _sender;
@synthesize time = _time;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict {
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.message = [self objectOrNilForKey:kFZResponseMessage fromDictionary:dict];
        self.isFromMe = [[self objectOrNilForKey:kFZResponseIsFromMe fromDictionary:dict] boolValue];
        self.sender = [self objectOrNilForKey:kFZResponseSender fromDictionary:dict];
        self.time = [self objectOrNilForKey:kFZResponseTime fromDictionary:dict];
        
    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.message forKey:kFZResponseMessage];
    [mutableDict setValue:[NSNumber numberWithBool:self.isFromMe] forKey:kFZResponseIsFromMe];
    [mutableDict setValue:self.sender forKey:kFZResponseSender];
    [mutableDict setValue:self.time forKey:kFZResponseTime];
    
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description  {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    self.message = [aDecoder decodeObjectForKey:kFZResponseMessage];
    self.isFromMe = [aDecoder decodeBoolForKey:kFZResponseIsFromMe];
    self.sender = [aDecoder decodeObjectForKey:kFZResponseSender];
    self.time = [aDecoder decodeObjectForKey:kFZResponseTime];
    return self;
}

+ (NSURLSessionDataTask *)fetchMessage:(NSDictionary *)params completionBlock:(void(^)(NSArray *response ,NSError *error))completion {
    return [[APIManager sharedClient] GET:@"messages.json" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *array = [NSMutableArray new];
        for (NSDictionary *data in responseObject) {
            FZResponse *response = [[FZResponse alloc] initWithDictionary:data];
            [array addObject:response];
        }
        if (completion) {
            completion(array, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (completion) {
            completion(nil, error);
        }
    }];
}
@end
