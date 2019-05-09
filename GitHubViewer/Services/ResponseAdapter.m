//
//  ResponceMapper.m
//  GitHubViewer
//
//  Created by Alexandr Bondar on 5/3/19.
//  Copyright © 2019 Alexandr Bondar. All rights reserved.
//

#import "ResponseAdapter.h"
#import <FastEasyMapping.h>
#import "RepoDTO.h"
#import "ReposOwnerDTO.h"

@implementation ResponseAdapter

+ (NSArray *)getReposDTOsFromResponse:(NSDictionary *)response {
 
    NSArray* sources = response[@"items"];
    
    NSArray* sourcesArray = [FEMDeserializer collectionFromRepresentation:sources mapping:[ResponseAdapter defaultReposMapping]];
    
    return sourcesArray;
}

+ (FEMMapping*)defaultReposMapping {
    FEMMapping* mapping = [[FEMMapping alloc] initWithObjectClass:[RepoDTO class]];
    
    [mapping addAttributesFromDictionary:@{@"name"              : @"name" ,
                                           @"reposDecscription" : @"description" }];
    [mapping addRelationshipMapping:[ResponseAdapter defaultReposOwnerMapping] forProperty:@"ownerDTO" keyPath:@"owner"];
    return mapping;
}

+ (FEMMapping*)defaultReposOwnerMapping {
    
    FEMMapping* mapping = [[FEMMapping alloc] initWithObjectClass:[ReposOwnerDTO class]];
    
    [mapping addAttributesFromDictionary:@{@"avatarURLString" : @"avatar_url",
                                           @"name"            : @"login"       }];
    return mapping;
}

+ (RepoLastActivityDTO *)getLastActivityFromResponse:(NSArray *)response {
    
    RepoLastActivityDTO *lastActivityDTO = nil;
    NSDictionary *commit = response.firstObject;
    if (commit) {
        NSDictionary *authorAvatarDict = commit[@"author"];
        NSString *authorAvatarString = authorAvatarDict[@"avatar_url"];
        
        NSDictionary *commitDetailDict = commit[@"commit"];
        NSDictionary *authorNameDictionary = commitDetailDict[@"author"];
        NSString *authotName = authorNameDictionary[@"name"];
        
        NSString *commitMessage = commitDetailDict[@"message"];
        
        NSString *commitHash = commit[@"sha"];
        lastActivityDTO = [RepoLastActivityDTO new];
        lastActivityDTO.committerName = authotName;
        lastActivityDTO.committerAvatarURLString = authorAvatarString;
        lastActivityDTO.commitHash = commitHash;
        lastActivityDTO.commitMessage = commitMessage;
        return lastActivityDTO;
    }
    return lastActivityDTO;
}

@end


