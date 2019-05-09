//
//  RepoDetailViewController.h
//  GitHubViewer
//
//  Created by Alexandr Bondar on 5/9/19.
//  Copyright © 2019 Alexandr Bondar. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class RepoDTO;

@interface RepoDetailViewController : UIViewController
@property (nonatomic, strong) RepoDTO *repoDTO;

@end

NS_ASSUME_NONNULL_END
