//
//  ReposModel.h
//  GitHubViewer
//
//  Created by Alexandr Bondar on 5/3/19.
//  Copyright © 2019 Alexandr Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReposOwnerDTO.h"
#import "RepoLastActivityDTO.h"

NS_ASSUME_NONNULL_BEGIN

@interface RepoDTO : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *reposDecscription;
@property (nonatomic, strong) ReposOwnerDTO *ownerDTO;
@property (nonatomic, strong) RepoLastActivityDTO *lastActivityDTO;

@end

NS_ASSUME_NONNULL_END
