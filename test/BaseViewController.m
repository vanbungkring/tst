//
//  BaseViewController.m
//  test
//
//  Created by Arie on 4/7/16.
//  Copyright © 2016 Dalvk Studio. All rights reserved.
//

#import "BaseViewController.h"
#import "FZDataModels.h"
#import "DataSource.h"
#define SYSTEM_VERSION                              ([[UIDevice currentDevice] systemVersion])
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([SYSTEM_VERSION compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IS_IOS8_OR_ABOVE                            (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8.0"))
@interface BaseViewController () <UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) DataSource *dataSource;
@end

@implementation BaseViewController


- (void)viewDidLoad {
    
    /**
     separate datasource of tableview
     */
    self.dataSource = [[DataSource alloc] init];
    self.tableView.delegate = self;
    /**
     *  set datasource as custom datasource
     */
    self.tableView.dataSource = self.dataSource;
    self.tableView.tableFooterView = [UIView new];
    self.title = @"Chat";
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadTableData:)
                                                 name:@"prefs.reload.tableview"
                                               object:nil];
    
    [FZResponse fetchMessage:nil completionBlock:^(NSArray *response, NSError *error) {
        if (!error) {
            self.dataSource.message = response;
            [self.tableView reloadData];
            
        }
    }];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/**
 *  reload table row just what you need to reload
 *
 *  @param object nsobject passing from nsnotification from child, it not good, need research for better
 */
- (void)reloadTableData:(NSNotification *)object {
    NSInteger row = [[object object] integerValue];
    [self.tableView beginUpdates];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    NSArray *indexPaths = [[NSArray alloc] initWithObjects:indexPath, nil];
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView endUpdates];
}


/**
 *  uitableview delegate
 *
 *  @param tableView already have auto height
 *  @param indexPath <#indexPath description#>
 *
 *  @return <#return value description#>
 */
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IOS8_OR_ABOVE) {
        return UITableViewAutomaticDimension;
    }
    else {
        UITableViewCell *orderCell = [self.dataSource tableView:self.tableView
                                          cellForRowAtIndexPath:indexPath];
        [orderCell updateConstraintsIfNeeded];
        [orderCell layoutIfNeeded];
        float height = [orderCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        return height;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width, 0.f, 0.f);
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
