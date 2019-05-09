//
//  ReposTableViewCell.h
//  GitHubViewer
//
//  Created by Alexandr Bondar on 5/2/19.
//  Copyright © 2019 Alexandr Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RepoDTO;

@interface ReposTableViewCell : UITableViewCell

- (void)setupWithReposDTO:(RepoDTO *)reposDTO;

@end

NS_ASSUME_NONNULL_END
