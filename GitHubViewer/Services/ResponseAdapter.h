//
//  ResponceMapper.h
//  GitHubViewer
//
//  Created by Alexandr Bondar on 5/3/19.
//  Copyright © 2019 Alexandr Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class RepoDTO;
@class RepoLastActivityDTO;

@interface ResponseAdapter : NSObject

+ (NSArray *)getReposDTOsFromResponse:(NSDictionary *)response;
+ (RepoLastActivityDTO *)getLastActivityFromResponse:(NSArray *)response;

@end

NS_ASSUME_NONNULL_END
