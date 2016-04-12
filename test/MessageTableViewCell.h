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
@property (weak, nonatomic) IBOutlet UITextView *chatTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chatTextViewHeightConstraints;
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
- (void)configureCell:(FZResponse *)response withViewTag:(NSInteger)tag;
@end
