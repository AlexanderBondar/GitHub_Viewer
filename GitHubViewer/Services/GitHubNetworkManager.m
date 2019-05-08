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

#define BASE_URL [NSURL URLWithString:@"https://api.github.com/search/"]
#define REQUEST_PARAMETERS @"repositories?q=language:swift&sort=stars&order=desc"

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
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:BASE_URL];
    }
    return self;
}

- (void)getReposListFromPage:(int)pageNumber
               withPostCount:(int)postCount
                   onSuccess:(void(^)(NSArray* repos))success
                   onFailure:(void(^)(NSError* error))failure {
 	
    NSString *parameters = [NSString stringWithFormat:@"%@&per_page=%d&page=%d", REQUEST_PARAMETERS, postCount, pageNumber];
    [self.sessionManager GET:parameters
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
