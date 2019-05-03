//
//  GitHubNetworkManager.m
//  GitHubViewer
//
//  Created by Alexandr Bondar on 5/2/19.
//  Copyright © 2019 Alexandr Bondar. All rights reserved.
//

#import "GitHubNetworkManager.h"
#import "ResponseAdapter.h"

#import <FastEasyMapping.h>

@interface GitHubNetworkManager ()
@property (strong, nonatomic) AFHTTPSessionManager* sessionManager;
@end

@implementation GitHubNetworkManager

+ (GitHubNetworkManager*)sharedManager {
    static GitHubNetworkManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[GitHubNetworkManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // TO DO
        NSURL* baseURL = [NSURL URLWithString:@"https://api.github.com/search/"];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    }
    return self;
}

- (void) getReposListFromServerOnSuccess:(void(^)(NSArray* news))success
                          onFailure:(void(^)(NSError* error))failure {
    
    
    [self.sessionManager GET:@"repositories?q=language:swift&sort=stars&order=desc"
                  parameters:nil
                    progress:nil
                     success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary   * _Nullable responseObject) {

                         NSArray *reposList = [ResponseAdapter getReposDTOsFromResponse:responseObject];
                         success(reposList);
                         
                     }
                     failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                         
                         NSLog(@"ERROR - %@", [error localizedDescription]);
                     }];
    
}
@end
