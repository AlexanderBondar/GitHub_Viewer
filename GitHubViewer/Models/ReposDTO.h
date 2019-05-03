//
//  ReposModel.h
//  GitHubViewer
//
//  Created by Alexandr Bondar on 5/3/19.
//  Copyright © 2019 Alexandr Bondar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReposOwnerDTO.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReposDTO : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *reposDecscription;
@property (nonatomic, strong) ReposOwnerDTO *ownerDTO;
@end

NS_ASSUME_NONNULL_END
