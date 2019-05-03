//
//  ReposListViewController.m
//  GitHubViewer
//
//  Created by Alexandr Bondar on 5/2/19.
//  Copyright © 2019 Alexandr Bondar. All rights reserved.
//

#import "ReposListViewController.h"
#import "ReposTableViewCell.h"
#import "GitHubNetworkManager.h"
#import "ReposDTO.h"

#define VERTICAL_OFFSET 30 + UIScreen.mainScreen.bounds.size.width/4
#define HORIZONTAL_OFFSET 40

static NSString* kReposCellIdentifier = @"ReposTableViewCell";

@interface ReposListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *reposListTableView;
@property (nonatomic, strong) NSMutableArray <ReposDTO *> *reposList;
@end

@implementation ReposListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reposList = [NSMutableArray new];
    [[GitHubNetworkManager sharedManager] getReposListFromServerOnSuccess:^(NSArray * _Nonnull repos) {
        [self.reposList addObjectsFromArray:repos];
        [self.reposListTableView reloadData];
    } onFailure:^(NSError * _Nonnull error) {
        NSLog(@"<<<Error during loading repos: %@", error.localizedDescription);
    }];
}

#pragma mark - UITableViewDataSource

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    ReposTableViewCell *cell = [self.reposListTableView dequeueReusableCellWithIdentifier:kReposCellIdentifier];
    if (indexPath.row < self.reposList.count) {
        [cell setupWithReposDTO:self.reposList[indexPath.row]];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    return self.reposList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.reposList.count) {
        ReposDTO* dto = self.reposList[indexPath.row];
        return [self heightForCellWithText:dto.reposDecscription];
    }
    return 180;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (CGFloat)heightForCellWithText:(NSString*)text {
    UIFont* font = [UIFont systemFontOfSize:17.f];
    NSDictionary* attributes = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName, nil];
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake([UIApplication sharedApplication].keyWindow.frame.size.width - HORIZONTAL_OFFSET, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:attributes
                                     context:nil];
    return CGRectGetHeight(rect) + VERTICAL_OFFSET;
}

@end
