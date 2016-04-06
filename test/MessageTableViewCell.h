//
//  MessageTableViewCell.h
//  test
//
//  Created by Arie on 4/7/16.
//  Copyright © 2016 Dalvk Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FZResponse;
@interface MessageTableViewCell : UITableViewCell
- (void)configureCell:(FZResponse *)response;
@end
