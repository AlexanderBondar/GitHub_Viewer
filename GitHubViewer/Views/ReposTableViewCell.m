//
//  ReposTableViewCell.m
//  GitHubViewer
//
//  Created by Alexandr Bondar on 5/2/19.
//  Copyright © 2019 Alexandr Bondar. All rights reserved.
//

#import "ReposTableViewCell.h"
#import "RepoDTO.h"
#import "PINImageView+PINRemoteImage.h"

@interface ReposTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *reposTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *reposDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *ownerNameLabel;
@end

@implementation ReposTableViewCell

#pragma mark - Interface -

- (void)setupWithReposDTO:(RepoDTO *)reposDTO {
    [self.avatarImageView setPin_updateWithProgress: YES];
    [self.avatarImageView pin_setImageFromURL:[NSURL URLWithString:reposDTO.ownerDTO.avatarURLString]];
    self.reposTitleLabel.text = [reposDTO.name capitalizedString];
    self.reposDescriptionLabel.text = reposDTO.reposDecscription;
    self.ownerNameLabel.text = reposDTO.ownerDTO.name;
}

@end
