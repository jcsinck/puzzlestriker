//
//  CharacterDetailTableViewCell.m
//  Puzzle Strike Randomizer
//
//  Created by Jeffrey Sinckler on 10/22/12.
//  Copyright (c) 2012 Black Rhino LLC. All rights reserved.
//

#import "CharacterDetailTableViewCell.h"
#import "AppDelegate.h"

@implementation CharacterDetailTableViewCell

@synthesize characterNameLabel;
@synthesize characterCardImage;
@synthesize characterDetailView;
@synthesize detailsButton;
@synthesize characterDataDictionary;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)configureCellWithDictionary:(NSDictionary *)characterData
{
    NSString *chipAssetName = [characterData objectForKey:@"chipAssetName"];
    NSString *characterName = [characterData objectForKey:@"characterName"];
    
    [self.characterNameLabel setText:characterName];
    [self.characterCardImage setImage:[UIImage imageNamed:chipAssetName]];
    
    self.characterDataDictionary = characterData;
}

-(void)detailsButtonTapped
{
    self.characterDetailView = [[SingleCharacterDetailViewController alloc] initWithCharacterData:self.characterDataDictionary];
    UIView *parentView = self.superview.superview;
    [((AppDelegate *)[UIApplication sharedApplication].delegate) animateViewOntoScreen:self.characterDetailView.view onParentView:parentView];
}

@end
