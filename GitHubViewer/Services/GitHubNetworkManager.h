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
+ (GitHubNetworkManager*) sharedManager;

- (void)getReposListFromServerOnSuccess:(void(^)(NSArray* news))success
                          onFailure:(void(^)(NSError* error))failure;
@end

NS_ASSUME_NONNULL_END

