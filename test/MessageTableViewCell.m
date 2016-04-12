//
//  MessageTableViewCell.m
//  test
//
//  Created by Arie on 4/7/16.
//  Copyright © 2016 Dalvk Studio. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "FZDataModels.h"
#import <ObjectiveGumbo.h>
@implementation MessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.avatar.layer.cornerRadius = self.avatar.frame.size.width/2;
    self.avatar.layer.masksToBounds = YES;
    self.chatTextView.layer.cornerRadius = 3.0f;
    self.chatTextView.layer.borderWidth = 0.1f;
    self.chatTextView.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor blueColor]};
    self.chatTextView.textColor = [UIColor blackColor];
    self.chatTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
- (void)configureCell:(FZResponse *)response withViewTag:(NSInteger)tag {
    self.chatTextView.tag = tag;
    [self.chatTextView setText:response.message];
    [self.chatTextView sizeThatFits:CGSizeMake(CGRectGetWidth(self.chatTextView.frame), MAXFLOAT)];
    self.chatTextViewHeightConstraints.constant = CGRectGetHeight(self.chatTextView.frame);
    [self.chatTextView updateConstraintsIfNeeded];
    [self getURLFromString:response.message withResponse:response andTag:tag];
    
}

- (void)getURLFromString:(NSString *)string withResponse:(FZResponse *)response andTag:(NSInteger)tag {
    NSDataDetector *detector = [NSDataDetector dataDetectorWithTypes:NSTextCheckingTypeAddress | NSTextCheckingTypePhoneNumber | NSTextCheckingTypeLink error:nil];
    [detector enumerateMatchesInString:string options:kNilOptions range:NSMakeRange(0, [string length]) usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        if (result.resultType == NSTextCheckingTypeLink) {
            [self matchUrl:result.URL response:response andTag:tag];
        }
    }];
    
}
-(NSString *)matchUrl:(NSURL *)urlAddress response:(FZResponse *)response andTag:(NSInteger)tag {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        OGNode * data = [ObjectiveGumbo parseDocumentWithUrl:urlAddress];
        OGElement *titleRow = [[data elementsWithTag:GUMBO_TAG_TITLE] firstObject];
        OGElement *headline = [[data elementsWithTag:GUMBO_TAG_H3] firstObject];
        dispatch_async(dispatch_get_main_queue(), ^{
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                NSString *grandString = [NSString stringWithFormat:@"%@\n\n%@\n%@",self.chatTextView.text,titleRow.text,[headline.text stringByReplacingOccurrencesOfString:@"            " withString:@""]];
                response.message = grandString;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"prefs.reload.tableview" object:[NSNumber numberWithInt:tag]];
            });
            
        });
    });
    
    return nil;
}
@end
