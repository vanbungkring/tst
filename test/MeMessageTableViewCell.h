//
//  MeMessageTableViewCell.h
//  test
//
//  Created by Arie on 4/7/16.
//  Copyright © 2016 Dalvk Studio. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FZResponse;
@interface MeMessageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *messageTextViewHeightConstraints;
- (void)configureCell:(FZResponse *)response;
@end
