//
//  DataSource.h
//  test
//
//  Created by Arie on 4/7/16.
//  Copyright © 2016 Dalvk Studio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/**
 *  separate the tableview datasource to make it maintainable
 */
@interface DataSource : NSObject <UITableViewDataSource>
@property (nonatomic,strong) NSArray *message;
@end
