//
//  ReposLastActivityDTO.h
//  GitHubViewer
//
//  Created by Alexandr Bondar on 5/9/19.
//  Copyright © 2019 Alexandr Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RepoLastActivityDTO : NSObject

@property (nonatomic, strong) NSString *committerAvatarURLString;
@property (nonatomic, strong) NSString *commitHash;
@property (nonatomic, strong) NSString *commitMessage;
@property (nonatomic, strong) NSString *committerName;

@end

NS_ASSUME_NONNULL_END
