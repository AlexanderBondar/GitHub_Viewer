//
//  ResponceMapper.m
//  GitHubViewer
//
//  Created by Alexandr Bondar on 5/3/19.
//  Copyright © 2019 Alexandr Bondar. All rights reserved.
//

#import "ResponseAdapter.h"
#import <FastEasyMapping.h>
#import "ReposDTO.h"
#import "ReposOwnerDTO.h"

@implementation ResponseAdapter

+ (NSArray *)getReposDTOsFromResponse:(NSDictionary *)response {
 
    NSArray* sources = response[@"items"];
    
    NSArray* sourcesArray = [FEMDeserializer collectionFromRepresentation:sources mapping:[ResponseAdapter defaultReposMapping]];
    
    return sourcesArray;
}

+ (FEMMapping*)defaultReposMapping {
    FEMMapping* mapping = [[FEMMapping alloc] initWithObjectClass:[ReposDTO class]];
    
    [mapping addAttributesFromDictionary:@{@"title"             : @"name" ,
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
@end


