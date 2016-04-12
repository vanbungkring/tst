//
//  MeMessageTableViewCell.m
//  test
//
//  Created by Arie on 4/7/16.
//  Copyright © 2016 Dalvk Studio. All rights reserved.
//

#import "MeMessageTableViewCell.h"
#import "FZDataModels.h"
@implementation MeMessageTableViewCell

- (void)awakeFromNib {
    self.avatar.layer.cornerRadius = self.avatar.frame.size.width/2;
    self.avatar.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.avatar.layer.masksToBounds = YES;
    self.messageTextView.layer.cornerRadius = 3.0f;
    self.messageTextView.layer.borderWidth = 0.1f;
    self.messageTextView.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor blueColor]};
    self.messageTextView.textColor = [UIColor whiteColor];
    // Initialization codeuic
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)configureCell:(FZResponse *)response {
    [self.messageTextView setText:response.message];
    self.messageTextView.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor blueColor]};
    [self.messageTextView sizeThatFits:CGSizeMake(CGRectGetWidth(self.messageTextView.frame), MAXFLOAT)];
    self.messageTextViewHeightConstraints.constant = CGRectGetHeight(self.messageTextView.frame);
    [self.messageTextView updateConstraintsIfNeeded];
    //[self  matchUrl:@"http://www.infoq.com/presentations/Are-We-There-Yet-Rich-Hickey"];
    
}

@end
