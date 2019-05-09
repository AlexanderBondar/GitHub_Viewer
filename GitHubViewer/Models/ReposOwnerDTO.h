//
//  ReposOwnerDTO.h
//  GitHubViewer
//
//  Created by Alexandr Bondar on 5/3/19.
//  Copyright © 2019 Alexandr Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReposOwnerDTO : NSObject

@property (nonatomic, strong) NSString *avatarURLString;
@property (nonatomic, strong) NSString *name;

@end

NS_ASSUME_NONNULL_END
