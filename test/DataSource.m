//
//  DataSource.m
//  test
//
//  Created by Arie on 4/7/16.
//  Copyright © 2016 Dalvk Studio. All rights reserved.
//

#import "DataSource.h"
#import "MessageTableViewCell.h"
#import "FZDataModels.h"
@implementation DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.message.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FZResponse *response = [self.message objectAtIndex:indexPath.row];
    static NSString *CellIdentifier = @"MessageTableViewCell";
    MessageTableViewCell *cell = (MessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        UINib *cellNib = [UINib nibWithNibName:[MessageTableViewCell debugDescription] bundle:nil];
        [tableView registerNib:cellNib forCellReuseIdentifier:[MessageTableViewCell debugDescription]];
        cell = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil][0];
    }
    
    [cell configureCell:response];
    return cell;
}
@end
