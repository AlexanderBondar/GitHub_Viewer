//
//  RepoDetailViewController.m
//  GitHubViewer
//
//  Created by Alexandr Bondar on 5/9/19.
//  Copyright © 2019 Alexandr Bondar. All rights reserved.
//

#import "RepoDetailViewController.h"
#import "RepoDTO.h"
#import "RepoLastActivityDTO.h"
#import "GitHubNetworkManager.h"
#import "PINImageView+PINRemoteImage.h"

@interface RepoDetailViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *authorImageView;
@property (weak, nonatomic) IBOutlet UILabel *autorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *hashLabel;
@property (weak, nonatomic) IBOutlet UILabel *decriptionLabel;
@property (nonatomic, strong) RepoLastActivityDTO *lastActivityDTO;

@end

@implementation RepoDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getLastActivity];
}

- (void)getLastActivity {
    
    [[GitHubNetworkManager sharedManager] getLastActivitiesFromRepo:self.repoDTO.name
                                                    withOwnerName:self.repoDTO.ownerDTO.name
     
                                                        onSuccess:^(NSArray * _Nonnull activities) {
                                                            [self updateUIWithDTO:activities.firstObject];
                                                            
                                                        } onFailure:^(NSError * _Nonnull error) {
                                                            
                                                        }];
}

- (void)updateUIWithDTO:(RepoLastActivityDTO *)dto {
    self.authorImageView.layer.cornerRadius = 30;
    [self.authorImageView setPin_updateWithProgress: YES];
    [self.authorImageView pin_setImageFromURL:[NSURL URLWithString:dto.committerAvatarURLString]
                             placeholderImage:[UIImage imageNamed:@"gitHubPlaceholder"]];
    self.autorNameLabel.text = [dto.committerName capitalizedString];
    self.decriptionLabel.text = dto.commitMessage;
    self.hashLabel.text = dto.commitHash;
}

@end
