//
//  GitHubNetworkManager.h
//  GitHubViewer
//
//  Created by Alexandr Bondar on 5/2/19.
//  Copyright © 2019 Alexandr Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface GitHubNetworkManager : NSObject

+ (GitHubNetworkManager*)sharedManager;

- (void)getReposListFromPage:(int)pageNumber
               withPostCount:(int)postCount
                   onSuccess:(void(^)(NSArray* repos))success
                   onFailure:(void(^)(NSError* error))failure;

- (void)getLastActivitiesFromRepo:(NSString *)repoName
                    withOwnerName:(NSString *)ownerName
                        onSuccess:(void(^)(NSArray* activities))success
                        onFailure:(void(^)(NSError* error))failure;

@end

NS_ASSUME_NONNULL_END

