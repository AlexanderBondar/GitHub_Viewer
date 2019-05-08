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

#import <UIScrollView+SVInfiniteScrolling.h>
#import <UIScrollView+SVPullToRefresh.h>

#define VERTICAL_OFFSET 30 + UIScreen.mainScreen.bounds.size.width/4
#define HORIZONTAL_OFFSET 40

#define DEFAULT_REPOS_COUNT 20

static NSString* kReposCellIdentifier = @"ReposTableViewCell";

@interface ReposListViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UITableView *reposListTableView;
@property (nonatomic, strong) NSMutableArray <ReposDTO *> *reposList;
@property (assign, nonatomic) BOOL isLoadingData;
@end

@implementation ReposListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.reposList = [NSMutableArray new];
    self.isLoadingData = NO;
    [self addInfiniteScrolling];
    [self getPostsFromGitHub];
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
    
//    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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

#pragma mark - Private methods

- (void)getPostsFromGitHub {
    self.isLoadingData = NO;
    __weak typeof(self) weakSelf = self;

    [[GitHubNetworkManager sharedManager] getReposListFromPage:(int)self.reposList.count/DEFAULT_REPOS_COUNT + 1
                                                 withPostCount:DEFAULT_REPOS_COUNT
     
                                                     onSuccess:^(NSArray * _Nonnull repos) {
                                                         [weakSelf.reposList addObjectsFromArray:repos];
                                                         [weakSelf.reposListTableView reloadData];
                                                         weakSelf.isLoadingData = NO;
                                                         [weakSelf.reposListTableView.infiniteScrollingView stopAnimating];
                                                         
                                                     } onFailure:^(NSError * _Nonnull error) {
                                                         NSLog(@"<<<Error during loading repos: %@", error.localizedDescription);
                                                         weakSelf.isLoadingData = NO;
                                                         [weakSelf.reposListTableView.infiniteScrollingView stopAnimating];
                                                     }];
}

- (void)addInfiniteScrolling {
    __weak ReposListViewController *weakSelf = self;
    
    [self.reposListTableView addPullToRefreshWithActionHandler:^{
        [weakSelf refreshWall];
        weakSelf.reposListTableView.showsInfiniteScrolling = YES;
    }];
    
    [self.reposListTableView addInfiniteScrollingWithActionHandler:^{
        [weakSelf getPostsFromGitHub];
    }];
}


- (void)refreshWall {
    
    if (self.isLoadingData == NO) {
        self.isLoadingData = YES;
        
        [[GitHubNetworkManager sharedManager] getReposListFromPage:1
                                                     withPostCount:(int)self.reposList.count
         
                                                         onSuccess:^(NSArray * _Nonnull repos) {
                                                             if ([repos count] > 0) {
                                                                 [self.reposList removeAllObjects];
                                                                 [self.reposList addObjectsFromArray:repos];
                                                                 [self.reposListTableView reloadData];
                                                             }
                                                             self.isLoadingData = NO;
                                                             [self.reposListTableView.pullToRefreshView stopAnimating];
                                                             
                                                         } onFailure:^(NSError * _Nonnull error) {
                                                             NSLog(@"error = %@", [error localizedDescription]);
                                                             [self.reposListTableView.pullToRefreshView stopAnimating];
                                                             self.isLoadingData = NO;
                                                         }];
    }
}

@end
